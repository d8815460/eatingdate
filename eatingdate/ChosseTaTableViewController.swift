//
//  ChosseTaTableViewController.swift
//  eatingdate
//
//  Created by 駿逸 陳 on 2015/6/17.
//  Copyright (c) 2015年 駿逸 陳. All rights reserved.
//

import UIKit

class ChosseTaTableViewController: PFQueryTableViewController {

    var detailItem:AnyObject!
    
    @IBOutlet weak var headerView: UIView!
    
    // Initialise the PFQueryTable tableview
    override init(style: UITableViewStyle, className: String?) {
        super.init(style: style, className: className)
        
        // Configure the PFQueryTableView
        self.parseClassName = kAskDateClassesKey
        self.textKey = "text"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
        self.loadingViewEnabled = false
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Configure the PFQueryTableView
        self.parseClassName = kAskDateClassesKey
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func queryForTable() -> PFQuery {
        //取得該約會單目前的報名人。
        var askQuery:PFQuery! = PFQuery(className: kAskDateClassesKey)
        askQuery.whereKey(kAskDateFromPostDate, equalTo: detailItem)
        let currentUser = detailItem?[kDateFromUser] as! PFUser
        askQuery.whereKey(kAskFromUser, notEqualTo: currentUser)
        askQuery.whereKey(kAskToUser, equalTo: currentUser)
        askQuery.includeKey(kAskFromUser)
        
        return askQuery
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if self.objects?.count > 0 {
            return self.objects!.count
        }else{
            return 0
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        let cell:ChoseTaCell! = tableView.dequeueReusableCellWithIdentifier("ChoseTaCell", forIndexPath: indexPath) as! ChoseTaCell
        
        // Configure the cell...
        let fromUser:PFUser = object?[kDateFromUser] as! PFUser
        
        let imageView:UIImageView = cell.viewWithTag(1) as! UIImageView
        if let picProfilePhotoFile: PFFile! = fromUser[kPAPUserProfilePicMediumKey] as? PFFile {
            if picProfilePhotoFile != nil {
                picProfilePhotoFile?.getDataInBackgroundWithBlock({ (imageDate, error:NSError?) -> Void in
                    if error != nil {
                        
                    }else{
                        cell.photoView.image = UIImage(data: imageDate!)
                        cell.photoView.layer.cornerRadius = 42
                    }
                })
            }
        }
        
        // 姓氏＋先生/小姐
        if let userName:String! = fromUser[kPAPUserFacebookLastNameKey] as? String{
            if let userGender:String! = fromUser[kPAPUserFacebookGenderKey] as? String {
                if userGender == "male"{
                    cell.userNameLabel.text = "\(userName!)先生"
                    cell.genderImageView.image = UIImage(named: "icon_ctn_man")
                }else{
                    cell.userNameLabel.text = "\(userName!)小姐"
                    cell.genderImageView.image = UIImage(named: "icon_ctn_women")
                }
            }
        }
        
        //年齡
        if let years:NSDate! = fromUser[kPAPUserFacebookBirthdayKey] as? NSDate {
            if years != nil {
                cell.yearsoldLabel.text = self.stringForTimeIntervalFromDate(years!, toDateNow: NSDate())
            }else{
                cell.yearsoldLabel.text = "0y"
            }
        }
        
        //VIP
        if let isVip: AnyObject! = fromUser[kIsVIP] {
            if isVip != nil {
                if isVip! as! NSObject == true {
                    cell.levelLabel.text = "VIP"
                }else{
                    cell.levelLabel.text = ""
                }
            }else{
                cell.levelLabel.text = ""
            }
        }
        
        //地點
        cell.locationLabel.text = "未知地點" //這裏需要修改？
        
        return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
