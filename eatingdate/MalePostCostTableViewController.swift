//
//  MalePostCostTableViewController.swift
//  eatingdate
//
//  Created by 駿逸 陳 on 2015/5/17.
//  Copyright (c) 2015年 駿逸 陳. All rights reserved.
//

import UIKit

class MalePostCostTableViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var 儲值Label: UILabel!
    @IBOutlet weak var 剩餘點數Label: UILabel!
    @IBOutlet weak var 點數餘額Label: UILabel!
    
    @IBOutlet weak var 誠意值Label: UILabel!
    @IBOutlet weak var 購買TextField: UITextField!
    
    var task: WriteTask!
    var hud:MBProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        剩餘點數Label.text = "-"
        誠意值Label.text = "誠意值"
        儲值Label.text = "儲值"
        購買TextField.delegate = self
        
        self.task = WriteTask.sharedWriteTask() as! WriteTask
    }
    
    override func viewDidAppear(animated: Bool) {
        
        // Get the user from a non-authenticated method
        var query = PFUser.query()
        let current = PFUser.currentUser()
        query?.whereKey("objectId", equalTo: current!.objectId!)
        query?.getFirstObjectInBackgroundWithBlock({ (userAgain, error) -> Void in
            let point = current?["myPoint"] as? NSNumber
            self.剩餘點數Label.text = "\(point!)"
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    // MARK: - textFieldDelegate
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let newString = (textField.text as NSString).stringByReplacingCharactersInRange(range, withString: string)
        
        if count(newString) > 3 {
            println("\(count(newString))")
            textField.text = "999"
        }else if count(newString) < 2 {
            
        }
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        var number = textField.text.toInt()
        if number < 50 {

        }else{
            self.task.postCost = NSNumber(integer: number!)
        }
    }
    
    func inputCost() {
        self.購買TextField.becomeFirstResponder()
    }

    
    @IBAction func postButtonPressed(sender: AnyObject) {
        
        self.view.endEditing(true)
        
        if 購買TextField.text.toInt() < 50 {
            let alertController = UIAlertController(title: "誠意值最低50",
                message: "請輸入至少50",
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
        
        if self.購買TextField.text.toInt() <= 剩餘點數Label.text?.toInt() && self.購買TextField.text.toInt() > 0 {
            //可以發布，要相減並儲存新的值
            var currentUser = PFUser.currentUser()
            let 剩餘點數 = 剩餘點數Label.text?.toInt()
            let 購買點數 = self.購買TextField.text.toInt()
            currentUser?["myPoint"] = (剩餘點數! - 購買點數!)
            
            println("剩餘點數是 \(剩餘點數! - 購買點數!)")
            
            var postACL = PFACL()
            postACL.setPublicReadAccess(true)
            
            currentUser?.ACL = postACL
            currentUser?.saveEventually({ (success, error) -> Void in
                
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
                if 購買點數 != nil {
                    savePostObject[kDatePostCost] = 購買點數
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
            })
            
        }else{
            
            MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
            
            //不能發布，要先購買點數
            let alertController = UIAlertController(title: "點數不足",
                message: "請購買點數",
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
    
    func dismiss (){
        dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }

}
