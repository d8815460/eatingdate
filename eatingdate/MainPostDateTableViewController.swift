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
    var distance:String!
    
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
        
        //餐廳的距離
        
        //報名的人數
        
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
            
            //年齡
            if let years:NSDate! = fromUser[kPAPUserFacebookBirthdayKey] as? NSDate {
                if years != nil {
                    cell.sexLabel.text = self.stringForTimeIntervalFromDate(years!, toDateNow: NSDate())
                }else{
                    cell.sexLabel.text = "0 Y"
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
        
        //被觀看次數
        if let beenLooked:NSNumber! = object?[kDateBeenLookedAmount] as? NSNumber {
            if beenLooked != nil {
                cell.beenLookedLabel.text = "\(beenLooked!)"
            }else{
                cell.beenLookedLabel.text = "0"
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
        
        //約會報名人數
        CMCache.sharedCache()
        
        
        var attributesForDate:NSDictionary! = CMCache.sharedCache()?.attributesForDate!(object!)
        if attributesForDate != nil {
            cell.askLabel.text = "\(CMCache.sharedCache().askCountForDate(object!))/5"
        }else{
            //沒有緩存資料
            var askAmount:PFQuery! = PFQuery(className: kAskDateListClassesKey)
            askAmount.whereKey(kAskDateFromPostDate, equalTo: object!)
            askAmount.findObjectsInBackgroundWithBlock({ (askers, error) -> Void in
                CMCache.sharedCache().setAttributesForDate(object!, askers: askers, commenters: NSArray() as [AnyObject], askedByCurrentUser: false)
                
                cell.askLabel.text = "\(askers!.count)/5"
            })
            
        }
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 105
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 21
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.headerView
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //如果當前用物沒有登入，就不能使用
        if PFUser.currentUser() == nil {
            //轉場登入畫面
            self.performSegueWithIdentifier("signIn", sender: self)
            
        }else {
            //被點擊的物件，該篇約會文的觀看次數要+1
            var cell:PostDateCell!
            cell = self.tableView(tableView, cellForRowAtIndexPath: indexPath) as! PostDateCell
            
            //該篇貼文物件
            var object = self.objects![indexPath.row] as! PFObject
            println("貼文物件 = \(object.objectId)")
            let oldLooked = cell.beenLookedLabel.text?.toInt()
            let beenLooked = (oldLooked! + 1)
            
            cell.beenLookedLabel.text = "\(beenLooked)"
            
            object[kDateBeenLookedAmount] = beenLooked
            
            //如果是男生 manPost
            self.performSegueWithIdentifier("moreDetail", sender: object)
            
            var postACL = PFACL()
            postACL.setPublicReadAccess(true)
            postACL.setPublicWriteAccess(true)
            
            object.ACL = postACL
            object.saveEventually({ (success, error) -> Void in
                
            })
        }
        
    }
    
    
    //計算年齡
    func stringForTimeIntervalFromDate(birthDay:NSDate, toDateNow:NSDate) -> String? {
        
        var calendar:NSCalendar! = NSCalendar.currentCalendar()
        let ageComponents = calendar.components(.CalendarUnitYear,
            fromDate: birthDay,
            toDate: toDateNow,
            options: nil)
        let age = ageComponents.year
        
        if age > 0 {
            return "\(age)y"
        }else{
            return "0y"
        }
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
//        let scene:AnyObject! = segue.destinationViewController
//        
//        if scene.isKindOfClass(PostDateDetailTableViewController) {
//            let VC = scene as! PostDateDetailTableViewController
//            VC.detailItem = sender
//        }
    }
}
