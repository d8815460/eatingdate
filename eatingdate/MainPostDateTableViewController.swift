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
        query.includeKey("restaurant")
        
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
                cell.bgImageView.image = UIImage(data: imageData!)
            }, progressBlock: { (percentDone: Int32) -> Void in
                if percentDone < 100 && percentDone != 0 {
                    cell.progressView.hidden = false
                }else{
                    cell.progressView.hidden = true
                }
                cell.progressView.setProgress(( Float(percentDone) / 100.0), animated: true);
//                cell.bgImageView.image = UIImage(named: "img_ctn_box")
            })
        }
        
        if object?[kDateFromUser] != nil {
            let fromUser = object?[kDateFromUser] as! PFUser
            if let picProfilePhotoFile: PFFile! = fromUser[kPAPUserProfilePicMediumKey] as? PFFile {
                picProfilePhotoFile!.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) -> Void in
                    cell.profileImageView.image = UIImage(data: imageData!)
                })
                
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
                cell.sinceritygoodLabel.text = "誠意\(cost!)%"
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
