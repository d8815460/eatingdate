//
//  MainPostDateTableViewController.swift
//  eatingdate
//
//  Created by 駿逸 陳 on 2015/5/24.
//  Copyright (c) 2015年 駿逸 陳. All rights reserved.
//

import UIKit

class MainPostDateTableViewController: PFQueryTableViewController {

    @IBOutlet weak var headerView: PFTableViewCell!
    
    //取得用戶的經緯座標
    var manager: OneShotLocationManager?
    
    // Initialise the PFQueryTable tableview
    override init(style: UITableViewStyle, className: String?) {
        super.init(style: style, className: className)
        
        // Configure the PFQueryTableView
        self.parseClassName = kPostDateClassesKey
        self.textKey = "text"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
        self.loadingViewEnabled = false
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Configure the PFQueryTableView
        self.parseClassName = kPostDateClassesKey
        self.textKey = "text"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
        self.loadingViewEnabled = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.headerView.frame = CGRectMake(0, 0, self.view.frame.width, 100)
        
        // Get the user from a non-authenticated method
        if PFUser.currentUser() != nil {
            var query = PFUser.query()
            let current = PFUser.currentUser()
            query?.whereKey("objectId", equalTo: current!.objectId!)
            query?.getFirstObjectInBackgroundWithBlock({ (userAgain, error) -> Void in
                println("currentUser = \(userAgain)")
                PFUser.currentUser() == userAgain
            })
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        manager = OneShotLocationManager()
        manager!.fetchWithCompletion {location, error in
            
            // fetch location or an error
            if let loc = location {
                //上傳用戶的所在經緯度
                var currentUser = PFUser.currentUser()
                let Geo:PFGeoPoint = PFGeoPoint(location: loc)
                currentUser?[kPAPParseLocationKey] = Geo
                
                var postACL = PFACL()
                postACL.setPublicReadAccess(true)
                currentUser?.ACL = postACL
                
                currentUser?.saveEventually({ (success, error) -> Void in
                    if success {
                        println("upload user location success!")
                    }else{
                        println("\(error?.localizedFailureReason)")
                    }
                })
            } else if let err = error {
                println("\(err.localizedDescription)")
            }
            
            // destroy the object immediately to save memory
            self.manager = nil
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objects!.count
    }
    
    // Define the query that will provide the data for the table view
    override func queryForTable() -> PFQuery {
        let query = PFQuery(className: self.parseClassName!)
        query.includeKey("category")
        query.includeKey("fromUser")
        query.includeKey(kDateRestaurant)
        
        //過期的就不要顯示
        query.whereKey("dateTime", greaterThan: NSDate())
        
        
        query.addAscendingOrder("postCost")
        query.orderByAscending("dateTime")
        
        return query
    }
    
    override func objectsDidLoad(error: NSError?) {
        self.loadingViewEnabled = false
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        
//        println("objects = \(self.objects)")
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        let cell:PostDateCell! = tableView.dequeueReusableCellWithIdentifier("PostDateCell", forIndexPath: indexPath) as! PostDateCell
        
        if let picMediumFile = object?[kDatePicMedium] as? PFFile {
            picMediumFile.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) -> Void in
                if imageData != nil {
                    cell.bgImageView.image = UIImage(data: imageData!)
                }else{
                    cell.bgImageView.image = UIImage(named: "img_ctn_box")
                    cell.progressView.hidden = true
                }
                
            }, progressBlock: { (percentDone: Int32) -> Void in
                if percentDone < 100 && percentDone != 0 {
                    cell.progressView.hidden = false
                }else{
                    cell.progressView.hidden = true
                }
                cell.progressView.setProgress(( Float(percentDone) / 100.0), animated: true)
            })
        }
        
        if object?[kDateFromUser] != nil {
            let fromUser = object?[kDateFromUser] as! PFUser
            if let picProfilePhotoFile: PFFile! = fromUser[kPAPUserProfilePicMediumKey] as? PFFile {
                if picProfilePhotoFile != nil {
                    picProfilePhotoFile?.getDataInBackgroundWithBlock({ (imageDate, error:NSError?) -> Void in
                        if error != nil {
                            
                        }else{
                            cell.profileImageView.image = UIImage(data: imageDate!)
                        }
                    })
                }
            }
            
            // 姓氏＋先生/小姐
            if let userName:String! = fromUser[kPAPUserFacebookLastNameKey] as? String{
                if let userGender:String! = fromUser[kPAPUserFacebookGenderKey] as? String {
                    if userGender == "male"{
                        cell.nameLabel.text = "\(userName!)先生"
                        cell.sexImageView.image = UIImage(named: "icon_ctn_man")
                    }else{
                        cell.nameLabel.text = "\(userName!)小姐"
                        cell.sexImageView.image = UIImage(named: "icon_ctn_women")
                    }
                }
            }
            
            //餐廳姓名
            if let Restaurant:String! = object?[kDateRestaurantName] as? String {
                cell.restaurantLabel.text = Restaurant!
            }
            
            //誠意值
            if let cost:NSNumber! = object?[kDatePostCost] as? NSNumber {
                if cost != nil{
                    cell.sinceritygoodLabel.text = "誠意\(cost!)%"
                }else{
                    cell.sinceritygoodLabel.text = "無誠意"
                }
                
            }
            
            //我請客/誰請我
            if let dateType:String! = object?[kDateType] as? String {
                cell.whoTreatLabel.text = "\(dateType!)"
            }
            
            //約會時間
            if let dateTime:NSDate! = object?[kDateTime] as? NSDate {
                var dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "HH:mm"
                cell.dateTimeLabel.text = dateFormatter.stringFromDate(dateTime!)
            }
            
            //約會單的地點
            if let restaurant:PFObject! = object?[kDateRestaurant] as? PFObject{
                if let AArea:String! = restaurant?[kDateRestaurantAdministrativeArea] as? String{
                    if let City:String! = restaurant?[kDateRestaurantCity] as? String{
                        cell.locationLabel.text = "\(AArea!) \(City!)"
                    }else{
                        cell.locationLabel.text = "\(AArea!)"
                    }
                    
                }else{
                    
                }
            }
        }
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 105
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.headerView
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
