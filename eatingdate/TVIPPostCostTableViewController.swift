//
//  TVIPPostCostTableViewController.swift
//  eatingdate
//
//  Created by 駿逸 陳 on 2015/5/17.
//  Copyright (c) 2015年 駿逸 陳. All rights reserved.
//

import UIKit

class TVIPPostCostTableViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet var toturialLabelView: UIView!
    @IBOutlet weak var postCostTextField: UITextField!
    @IBOutlet weak var postCostLabel: UILabel!
    @IBOutlet weak var tvipLabel: UILabel!
    var task: WriteTask!
    var hud:MBProgressHUD!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.postCostLabel.text = "誠意值"
        
        self.task = WriteTask.sharedWriteTask() as! WriteTask
        
        //☐使用TVIP身份發佈（最低1000%）
        self.tvipLabel.text = "☑︎使用TVIP身份發佈（最低1000%）"
        self.tvipLabel.textColor = UIColor(red: 211.0/255.0, green: 83.0/255.0, blue: 19.0/255.0, alpha: 1.0)
        self.task.isTVIP = NSNumber(bool: true)   //0=false, 1=true
        
        self.postCostTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 2 {
            if self.tvipLabel.text == "☑︎使用TVIP身份發佈（最低1000%）" {
                self.tvipLabel.text = "◻︎使用TVIP身份發佈（最低1000%）"
                self.tvipLabel.textColor = UIColor(red: 79.0/255.0, green: 131.0/255.0, blue: 44.0/255.0, alpha: 1.0)
                self.task.isTVIP = NSNumber(bool: true)   //0=false, 1=true
            }else if self.tvipLabel.text == "◻︎使用TVIP身份發佈（最低1000%）"{
                self.tvipLabel.text = "☑︎使用TVIP身份發佈（最低1000%）"
                self.tvipLabel.textColor = UIColor(red: 211.0/255.0, green: 83.0/255.0, blue: 19.0/255.0, alpha: 1.0)
                self.task.isTVIP = NSNumber(bool: true)   //0=false, 1=true
            }
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let newString = (textField.text as NSString).stringByReplacingCharactersInRange(range, withString: string)
        
        if count(newString) > 4 {
            println("\(count(newString))")
            textField.text = "999"
        }else if count(newString) < 2 {
            
        }
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        var number = textField.text.toInt()
        if number < 100 {
            self.task.postCost = 100
            self.postCostTextField.text = "100"
        }else{
            self.task.postCost = NSNumber(integer: number!)
        }
    }
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

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
    @IBAction func postButtonPressed(sender: AnyObject) {
        
        self.view.endEditing(true)
        
        if postCostTextField.text.toInt() < 100 {
            let alertController = UIAlertController(title: "誠意值最低100",
                message: "請輸入至少100",
                preferredStyle: UIAlertControllerStyle.Alert
            )
            alertController.addAction(UIAlertAction(title: "確定",
                style: UIAlertActionStyle.Default,
                handler: nil)
            )
            // Display alert
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }
        
        
        
        
        
        
        self.hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        self.hud.labelText = "準備發佈約會，請稍候"
        self.hud.dimBackground = true
    
        var savePostObject = PFObject(className: kPostDateClassesKey)
        
        if PFUser.currentUser() != nil {
            savePostObject[kDateFromUser] = PFUser.currentUser()
        }
        if self.task.dateTitle != nil {
            savePostObject[kDateTitle] = self.task.dateTitle
        }
        if self.task.picMedium != nil {
            savePostObject[kDatePicMedium] = self.task.picMedium
        }
        if self.task.picSmall != nil {
            savePostObject[kDatePicSmall] = self.task.picSmall
        }
        if self.task.restaurant != nil {
            savePostObject[kDateRestaurant] = self.task.restaurant
        }
        if self.task.restaurantName != nil {
            savePostObject[kDateRestaurantName] = self.task.restaurantName
        }
        if self.task.dateTime != nil {
            savePostObject[kDateTime] = self.task.dateTime
        }
        if self.task.restaurantAddress != nil {
            savePostObject[kDateRestaurantAddress] = self.task.restaurantAddress
        }
        if self.task.restaurantGeo != nil {
            savePostObject[kDateRestaurantGeo] = self.task.restaurantGeo
        }
        if self.task.dateType != nil {
            savePostObject[kDateType] = self.task.dateType
        }
        if self.task.gameType != nil {
            savePostObject[kDateGameType] = self.task.gameType
        }
        if self.task.restaurantPhone != nil {
            savePostObject[kDateRestaurantPhone] = self.task.restaurantPhone
        }
        if self.task.peopleAskNumber != nil {
            savePostObject[kDatePeopleAskNumber] = self.task.peopleAskNumber
        }
        if self.task.toUser != nil {
            savePostObject[kDateToUser] = self.task.toUser
        }
        if postCostTextField.text.toInt() != nil {
            savePostObject[kDatePostCost] = self.postCostTextField.text.toInt()
        }
        if self.task.restaurantMinCost != nil {
            savePostObject[kDateRestaurantMinCost] = self.task.restaurantMinCost
        }
        if self.task.isTVIP != nil {
            savePostObject[kIsTVIP] = self.task.isTVIP.boolValue
        }
        
        var ACL = PFACL()
        ACL.setPublicReadAccess(true)
        ACL.setPublicWriteAccess(true)
        
        savePostObject.ACL = ACL
        
        //儲存，然後推播
        savePostObject.saveInBackgroundWithBlock { (success, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
                
                //開始搜尋附近的異性，並傳送推播
                var findPeopleQuery = PFUser.query()
                //排除自己
                findPeopleQuery?.whereKey("objectId", notEqualTo: PFUser.currentUser()?.objectId as String!)
                //尋找餐廳附近的人
                let Geo:PFGeoPoint! = savePostObject[kDateRestaurantGeo] as! PFGeoPoint
                findPeopleQuery?.whereKey("geo", nearGeoPoint: Geo, withinKilometers: 350.0)
                //尋找異性
                if PFUser.currentUser()?.objectForKey("gender")! as! String == "male" {
                    findPeopleQuery?.whereKey("gender", equalTo: "female")
                }else if PFUser.currentUser()?.objectForKey("gender")! as! String == "female" {
                    findPeopleQuery?.whereKey("gender", equalTo: "male")
                }
                findPeopleQuery?.limit = 100
                
                println("開始尋找附近的人")
                
                findPeopleQuery?.findObjectsInBackgroundWithBlock({ (objects: [AnyObject]?, error: NSError?) -> Void in
                    
                    
                    if error != nil {
                        println("尋找失敗")
                        // There was an error
                        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                        // There was a problem, check error.description
                        // Build the terms and conditions alert
                        let alertController = UIAlertController(title: "發生了錯誤",
                            message: "\(error!.localizedFailureReason)",
                            preferredStyle: UIAlertControllerStyle.Alert
                        )
                        alertController.addAction(UIAlertAction(title: "確定",
                            style: UIAlertActionStyle.Default,
                            handler: nil)
                        )
                        
                        // Display alert
                        self.presentViewController(alertController, animated: true, completion: nil)
                    }else{
                        println("尋找成功")
                        // objects has all finded
                        // 照理講，我發請帖出去收到推播的人，必須要能夠收到訊息。
                        if let allUsers = objects as? [PFUser] {
                            
                            var channelSet = NSMutableSet(capacity: objects?.count as Int!)
                            
                            for author in allUsers {
                                var activity = PFObject(className: kPAPActivityClassKey)
                                activity["datePost"] = savePostObject
                                activity[kPAPActivityFromUserKey] = PFUser.currentUser()
                                activity[kPAPActivityToUserKey] = author
                                activity[kPAPActivityTypeKey] = kPAPActivityTypePost
                                activity[kPAPActivityCommentKey] = savePostObject.objectForKey(kDateTitle)
                                
                                activity.ACL = ACL
                                
                                activity.saveEventually({ (success, error: NSError?) -> Void in
                                    
                                })
                                
                                var privateChannelName = "user_\(author.objectId)"
                                if privateChannelName.isEmpty {
                                    
                                }else{
                                    channelSet.addObject(privateChannelName)
                                }
                            }
                            
                            if channelSet.count > 0 {
                                //推播內容
                                var alert:String!
                                let userName = PFUser.currentUser()?.objectForKey(kPAPUserFacebookLastNameKey)! as! String
                                if PFUser.currentUser()?.objectForKey(kPAPUserFacebookGenderKey)! as! String == "male" {
                                    alert = "\(userName)先生希望一起在\(savePostObject[kDateRestaurantName])共度美好時光"
                                }else if PFUser.currentUser()?.objectForKey("gender")! as! String == "female" {
                                    alert = "\(userName)小姐希望一起在\(savePostObject[kDateRestaurantName])共度美好時光"
                                }
                                
                                var data:NSDictionary! = NSDictionary(objectsAndKeys:
                                    alert!, kAPNSAlertKey,
                                    kPAPPushPayloadPayloadTypeActivityKey, kPAPPushPayloadPayloadTypeKey,
                                    kPAPPushPayloadActivitySendPlzKey, kPAPPushPayloadActivityTypeKey,
                                    PFUser.currentUser()?.objectId as String!, "fu",
                                    savePostObject.objectId!, "po",
                                    "Increment", kAPNSBadgeKey,
                                    "action", "com.eatingDate.CUSTOM_BROADCAST")
                                
                                let push:PFPush = PFPush()
                                push.setChannels(channelSet.allObjects)
                                push.setData(data as [NSObject : AnyObject]!)
                                push.sendPushInBackgroundWithBlock({ (success, error: NSError?) -> Void in
                                    
                                    if success {
                                        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                                        //完成之後，就直接回到該回到的頁面
                                        
                                        let alertController = UIAlertController(title: "系統通知了\(channelSet.allObjects.count)人",
                                            message: "\(error!.localizedFailureReason)",
                                            preferredStyle: UIAlertControllerStyle.Alert
                                        )
                                        alertController.addAction(UIAlertAction(title: "確定",
                                            style: UIAlertActionStyle.Default,
                                            handler: nil)
                                        )
                                        
                                        // Display alert
                                        self.presentViewController(alertController, animated: true, completion: nil)
                                        
                                        
                                    }
                                })
                            }else{
                                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                                // There was a problem, check error.description
                                // Build the terms and conditions alert
                                let alertController = UIAlertController(title: nil,
                                    message: "附近找不到合適的人",
                                    preferredStyle: UIAlertControllerStyle.Alert
                                )
                                alertController.addAction(UIAlertAction(title: "確定",
                                    style: UIAlertActionStyle.Default,
                                    handler: { alertController in self.dismiss()})
                                )
                                
                                // Display alert
                                self.presentViewController(alertController, animated: true, completion: nil)
                            }
                        }
                        
                        
                    }
                })
                
            }else{
                // There was a problem, check error.description
                // Build the terms and conditions alert
                let alertController = UIAlertController(title: "發生了錯誤",
                    message: "\(error?.localizedFailureReason)",
                    preferredStyle: UIAlertControllerStyle.Alert
                )
                alertController.addAction(UIAlertAction(title: "確定",
                    style: UIAlertActionStyle.Default,
                    handler: nil)
                )
                
                // Display alert
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        }
    }
    
    
    func dismiss (){
        dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
