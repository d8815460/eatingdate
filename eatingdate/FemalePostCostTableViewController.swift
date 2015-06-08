//
//  FemalePostCostTableViewController.swift
//  eatingdate
//
//  Created by 駿逸 陳 on 2015/5/17.
//  Copyright (c) 2015年 駿逸 陳. All rights reserved.
//

import UIKit

class FemalePostCostTableViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var 誠意值Label: UILabel!
    @IBOutlet weak var 報名所需誠意TextField: UITextField!
    
    var task: WriteTask!
    var hud:MBProgressHUD!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        誠意值Label.text = "誠意值"
        報名所需誠意TextField.becomeFirstResponder()
        報名所需誠意TextField.delegate = self
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.task = WriteTask.sharedWriteTask() as! WriteTask
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    // MARK: - textFieldDelegate
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
            
        }else{
            self.task.postCost = NSNumber(integer: number!)
        }
    }
    
    func inputCost() {
        self.報名所需誠意TextField.becomeFirstResponder()
    }
    
    
    @IBAction func postButtonPressed(sender: AnyObject) {
        self.報名所需誠意TextField.endEditing(true)
        
        if 報名所需誠意TextField.text.toInt() < 100 {
            let alertController = UIAlertController(title: "誠意值最低100",
                message: "請輸入至少100",
                preferredStyle: UIAlertControllerStyle.Alert
            )
            alertController.addAction(UIAlertAction(title: "確定",
                style: UIAlertActionStyle.Default,
                handler: { alertController in self.inputCost()})
            )
            // Display alert
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }
        
        self.hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        self.hud.labelText = "準備發佈約會，請稍候"
        self.hud.dimBackground = true
        
        //女生不用扣點數
        
        var postACL = PFACL()
        postACL.setPublicReadAccess(true)
        
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
        if self.報名所需誠意TextField.text != nil {
            savePostObject[kDatePostCost] = self.報名所需誠意TextField.text.toInt()
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
                                        
                                        //清空緩存約會單檔案
                                        self.task.releaseThisTask(self.task);
                                        
                                        //回到首頁
                                        self.dismiss()
                                        
                                        /* 暫時不通知用戶
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
                                        */
                                    }
                                })
                            }else{
                                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                                
                                //清空緩存約會單檔案
                                self.task.releaseThisTask(self.task);
                                
                                //回到首頁
                                self.dismiss()
                                
                                // There was a problem, check error.description
                                // Build the terms and conditions alert
                                /* 暫時不通知用戶
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
                                */
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
