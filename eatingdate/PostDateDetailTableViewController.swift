//
//  PostDateDetailTableViewController.swift
//  eatingdate
//
//  Created by 駿逸 陳 on 2015/6/8.
//  Copyright (c) 2015年 駿逸 陳. All rights reserved.
//

import UIKit
import MapKit

class PostDateDetailTableViewController: PFQueryTableViewController, UICollectionViewDelegate, UICollectionViewDataSource{

    var detailItem:AnyObject!
    var Geo:PFGeoPoint!
    var friends:NSArray!
    
    @IBOutlet weak var actionCell: UITableViewCell!
    
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
    
    //取得用戶的經緯座標
    var manager: OneShotLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        manager = OneShotLocationManager()
        manager?.fetchWithCompletion({ (location, error) -> () in
            if let loc = location {
                self.Geo = PFGeoPoint(location: loc)
            } else if let err = error {
                println("\(error?.localizedDescription)")
            }
        })
        
        self.friends = NSArray()
        self.loadFriends()
        
        //加入手勢辨識
        var upSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        var downSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        var leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        var rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        
        upSwipe.delegate = self
        downSwipe.delegate = self
        leftSwipe.delegate = self
        rightSwipe.delegate = self
        
        upSwipe.direction = UISwipeGestureRecognizerDirection.Up
        downSwipe.direction = UISwipeGestureRecognizerDirection.Down
        leftSwipe.direction = UISwipeGestureRecognizerDirection.Left
        rightSwipe.direction = UISwipeGestureRecognizerDirection.Right
        
        self.tableView.addGestureRecognizer(upSwipe)
        self.tableView.addGestureRecognizer(downSwipe)
        self.tableView.addGestureRecognizer(leftSwipe)
        self.tableView.addGestureRecognizer(rightSwipe)
        
//        self.followScrollView(self.tableView, withDelay: 65.0)
//        self.setShouldScrollWhenContentFits(true)
//        self.setUseSuperview(false)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    func loadFriends () {
        //取得該約會單目前的報名人。
        var attributesForDate:NSDictionary! = CMCache.sharedCache()?.attributesForDate!(detailItem as! PFObject)
        
        if attributesForDate != nil {
            self.friends = CMCache.sharedCache().askersForDate(detailItem as! PFObject)
            self.tableView.reloadData()
        }else{
            //如果沒有，就要update the cache.
            objc_sync_enter(self)
            // do something
            var query:PFQuery = CMUtility.queryForActivitiesOnDate(detailItem as! PFObject, cachePolicy: PFCachePolicy.CacheThenNetwork)
            query.findObjectsInBackgroundWithBlock({ (objects:[AnyObject]?, error:NSError?) -> Void in
                if error != nil {
                    return
                }
                
                let askers:NSMutableArray! = NSMutableArray()
                let commenters:NSMutableArray! = NSMutableArray()
                var isAskedByCurrentuser = false
                
                if let allActivities = objects as? [PFObject] {
                    //取得所有請求約會的人、以及留言
                    for activity:PFObject in allActivities {
                        if (activity.objectForKey("type")! as! String == "ask" && activity.objectForKey("fromUser") != nil){
                            askers.addObject(activity.objectForKey("fromUser")!)
                            if activity.objectForKey("fromUser")?.objectId == PFUser.currentUser()?.objectId {
                                isAskedByCurrentuser = true
                            }
                        } else if (activity.objectForKey("type")! as! String == "comment" && activity.objectForKey("fromUser") != nil) {
                            commenters.addObject(activity.objectForKey("fromUser")!)
                        }
                    }
                    
                    CMCache.sharedCache().setAttributesForDate(self.detailItem as! PFObject, askers: askers as NSArray as [AnyObject], commenters: commenters as NSArray as [AnyObject], askedByCurrentUser: isAskedByCurrentuser)
                    
                    self.friends = askers as NSArray
                    self.tableView.reloadData()
                }
            })
            objc_sync_exit(self);
        }
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - 手勢辨識
    func handleSwipes(sender:UISwipeGestureRecognizer) {
        if (sender.direction == .Up) {
            println("Swipe Up")
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
        
        if (sender.direction == .Down) {
            println("Swipe Down")
            self.navigationController?.setNavigationBarHidden(false, animated: true)
//            self.navigationController?.showNavBarAnimated(true)
        }
        
        if (sender.direction == .Left) {
            println("Swipe Left")
        }
        
        if (sender.direction == .Right) {
            println("Swipe Right")
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 13
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell!
        var cell0:PostDateCell!
        var cell1:ActionCell!
        var cell2:MapCell!
        var cell3:AskCell!
        
        if indexPath.row == 0{
            cell0 = tableView.dequeueReusableCellWithIdentifier("PostDateCell", forIndexPath: indexPath) as! PostDateCell
        }else if indexPath.row == 11 {
            cell1 = tableView.dequeueReusableCellWithIdentifier("actionCell", forIndexPath: indexPath) as! ActionCell
        }else if indexPath.row == 12 {
            cell = tableView.dequeueReusableCellWithIdentifier("attentionCell", forIndexPath: indexPath) as! UITableViewCell
        }else if indexPath.row == 7 {
            cell2 = tableView.dequeueReusableCellWithIdentifier("mapCell", forIndexPath: indexPath) as! MapCell
        }else if indexPath.row == 8 {
            if self.friends != nil || self.friends.count > 0{
                cell3 = tableView.dequeueReusableCellWithIdentifier("askCell", forIndexPath: indexPath) as! AskCell
                
            }else{
                //使用一般cell即可
            }
        }else if indexPath.row == 9 {
            cell = tableView.dequeueReusableCellWithIdentifier("BasicCellRed", forIndexPath: indexPath) as! UITableViewCell
        }else if indexPath.row == 5 {
            cell = tableView.dequeueReusableCellWithIdentifier("BasicCellRed2", forIndexPath: indexPath) as! UITableViewCell
        }else if indexPath.row == 2 {
            cell = tableView.dequeueReusableCellWithIdentifier("BasicCellRed3", forIndexPath: indexPath) as! UITableViewCell
        }
        else{
            cell = tableView.dequeueReusableCellWithIdentifier("BasicCell", forIndexPath: indexPath) as! UITableViewCell
        }
        
        
        
        
        // Configure the cell...
        if indexPath.row == 0 {
            
            if let picMediumFile = detailItem?[kDatePicMedium] as? PFFile {
                picMediumFile.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) -> Void in
                    if imageData != nil {
                        cell0.bgImageView.image = UIImage(data: imageData!)
                    }else{
                        cell0.bgImageView.image = UIImage(named: "img_ctn_box")
                        cell0.progressView.hidden = true
                    }
                    
                    }, progressBlock: { (percentDone: Int32) -> Void in
                        if percentDone < 100 && percentDone != 0 {
                            cell0.progressView.hidden = false
                        }else{
                            cell0.progressView.hidden = true
                        }
                        cell0.progressView.setProgress(( Float(percentDone) / 100.0), animated: true)
                })
            }
            
            if detailItem?[kDateFromUser] != nil {
                let fromUser = detailItem?[kDateFromUser] as! PFUser
                if let picProfilePhotoFile: PFFile! = fromUser[kPAPUserProfilePicMediumKey] as? PFFile {
                    if picProfilePhotoFile != nil {
                        picProfilePhotoFile?.getDataInBackgroundWithBlock({ (imageDate, error:NSError?) -> Void in
                            if error != nil {
                                
                            }else{
                                cell0.profileImageView.image = UIImage(data: imageDate!)
                            }
                        })
                    }
                }
                
                // 姓氏＋先生/小姐
                if let userName:String! = fromUser[kPAPUserFacebookLastNameKey] as? String{
                    if let userGender:String! = fromUser[kPAPUserFacebookGenderKey] as? String {
                        if userGender == "male"{
                            cell0.nameLabel.text = "\(userName!)先生"
                            cell0.sexImageView.image = UIImage(named: "icon_ctn_man")
                        }else{
                            cell0.nameLabel.text = "\(userName!)小姐"
                            cell0.sexImageView.image = UIImage(named: "icon_ctn_women")
                        }
                    }
                }
                
                //年齡
                if let years:NSDate! = fromUser[kPAPUserFacebookBirthdayKey] as? NSDate {
                    if years != nil {
                        cell0.sexLabel.text = self.stringForTimeIntervalFromDate(years!, toDateNow: NSDate())
                    }else{
                        cell0.sexLabel.text = "0y"
                    }
                }
            }
            
            //餐廳姓名
            if let Restaurant:String! = detailItem?[kDateRestaurantName] as? String {
                cell0.restaurantLabel.text = Restaurant!
            }
            
            //誠意值
            if let cost:NSNumber! = detailItem?[kDatePostCost] as? NSNumber {
                if cost != nil{
                    cell0.sinceritygoodLabel.text = "誠意\(cost!)%"
                }else{
                    cell0.sinceritygoodLabel.text = "無誠意"
                }
            }
            
            //被觀看次數
            if let beenLooked:NSNumber! = detailItem?[kDateBeenLookedAmount] as? NSNumber {
                if beenLooked != nil {
                    cell0.beenLookedLabel.text = "\(beenLooked!)"
                }else{
                    cell0.beenLookedLabel.text = "0"
                }
            }
            
            //我請客/誰請我
            if let dateType:String! = detailItem?[kDateType] as? String {
                cell0.whoTreatLabel.text = "\(dateType!)"
            }
            
            //約會時間
            if let dateTime:NSDate! = detailItem?[kDateTime] as? NSDate {
                var dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "HH:mm"
                cell0.dateTimeLabel.text = dateFormatter.stringFromDate(dateTime!)
            }
            
            //約會單的地點
            if let restaurant:PFObject! = detailItem?[kDateRestaurant] as? PFObject{
                if let AArea:String! = restaurant?[kDateRestaurantAdministrativeArea] as? String{
                    if let City:String! = restaurant?[kDateRestaurantCity] as? String{
                        cell0.locationLabel.text = "\(AArea!) \(City!)"
                    }else{
                        cell0.locationLabel.text = "\(AArea!)"
                    }
                    
                }else{
                    
                }
            }
            
            var attributesForDate:NSDictionary! = CMCache.sharedCache()?.attributesForDate!(detailItem! as! PFObject)
            if attributesForDate != nil {
                cell0.askLabel.text = "\(CMCache.sharedCache().askCountForDate(detailItem! as! PFObject))/5"
            }else{
                //沒有緩存資料
                var askAmount:PFQuery! = PFQuery(className: kAskDateListClassesKey)
                askAmount.whereKey(kAskDateFromPostDate, equalTo: detailItem!)
                askAmount.findObjectsInBackgroundWithBlock({ (askers, error) -> Void in
                    CMCache.sharedCache().setAttributesForDate(self.detailItem! as! PFObject, askers: askers, commenters: NSArray() as [AnyObject], askedByCurrentUser: false)
                    
                    cell0.askLabel.text = "\(askers!.count)/5"
                })
                
            }
            
            return cell0
            
        } else if indexPath.row == 1 {
            //主題
            cell.textLabel?.text = "主題"
            if let title:String! = detailItem?[kDateTitle] as? String {
                cell.detailTextLabel?.text = title!
            }
        } else if indexPath.row == 2 {
            //費用
            cell.textLabel?.text = "費用"
            if let dateType:String! = detailItem?[kDateType] as? String {
                cell.detailTextLabel?.text = dateType!
            }
        } else if indexPath.row == 3 {
            //日期
            cell.textLabel?.text = "日期"
            if let dateDay:NSDate! = detailItem?[kDateTime] as? NSDate {
                var dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy/MM/dd EEEE"
                cell.detailTextLabel?.text = dateFormatter.stringFromDate(dateDay!)
            }
        } else if indexPath.row == 4 {
            //時間
            cell.textLabel?.text = "時間"
            if let dateDay:NSDate! = detailItem?[kDateTime] as? NSDate {
                var dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "HH:mm"
                cell.detailTextLabel?.text = dateFormatter.stringFromDate(dateDay!)
            }
        } else if indexPath.row == 5 {
            //餐廳名稱
            cell.textLabel?.text = "餐廳"
            if let res:String! = detailItem?[kDateRestaurantName] as? String {
                cell.detailTextLabel?.text = res!
            }
        } else if indexPath.row == 6 {
            //電話
            cell.textLabel?.text = "電話"
            if let res:String! = detailItem?[kDateRestaurantPhone] as? String {
                cell.detailTextLabel?.text = res!
            }
        } else if indexPath.row == 7 {
            //地址
            cell2.titleLabel?.text = "地址"
            if let res:String! = detailItem?[kDateRestaurantAddress] as? String {
                cell2.detailLabel?.text = res!
            }
            
            //1
            let rGeo = detailItem?[kDateRestaurantGeo] as! PFGeoPoint
            let RestaurantLocation = CLLocationCoordinate2D(latitude: rGeo.latitude, longitude: rGeo.longitude)
            //2
            let span = MKCoordinateSpanMake(0.01, 0.01)
            let region = MKCoordinateRegionMake(RestaurantLocation, span)
            cell2.map.setRegion(region, animated: true)
            
            //3
            let annotation = MKPointAnnotation()
            annotation.coordinate = RestaurantLocation
            
            if let res:String! = detailItem?[kDateRestaurantPhone] as? String {
                annotation.title = res!
            }
            cell2.map.addAnnotation(annotation)
            
            //距離你多遠
            let caseLoc:CLLocation = CLLocation(latitude: rGeo.latitude, longitude: rGeo.longitude)
            if self.Geo != nil {
                let userLoc:CLLocation = CLLocation(latitude: self.Geo.latitude, longitude: self.Geo.longitude)
                let mLabel = userLoc.distanceFromLocation(caseLoc)
                cell2.distanceLabel.text = String(format:"%.0fm", mLabel)
            }else{
                cell2.distanceLabel.text = "無法取得用戶位置"
            }
            
            return cell2
        } else if indexPath.row == 8 {
            //報名人數
            cell3.titleLabel.text = "報名人數"
            if self.friends.count > 0 {
                cell3.askCountLabel?.text = "\(friends.count)/5"
            }else{
                cell3.askCountLabel?.text = "0/5"
            }
            cell3.friendsCollectionView.delegate = self
            cell3.friendsCollectionView.dataSource = self
            cell3.friendsCollectionView.backgroundColor = UIColor.clearColor()
            return cell3
        } else if indexPath.row == 9 {
            //報名截止倒數
            cell.textLabel?.text = "報名截止倒數"
            cell.detailTextLabel?.text = self.stringForTimeIntervalFromDateNow(NSDate(), toDateDay: detailItem?[kDateTime]! as! NSDate)
        } else if indexPath.row == 10 {
            //報名者所需支付誠意值
            cell.textLabel?.text = "報名者所需支付誠意值"
            if let res:NSNumber! = detailItem?[kDatePostCost] as? NSNumber {
                cell.detailTextLabel?.text = "\(res!)%"
            }
        } else if indexPath.row == 11 {
            //修改或報名
            let fromUser = detailItem?[kDateFromUser] as! PFUser
            if let objectId:String! = fromUser.objectId {
                if objectId == PFUser.currentUser()?.objectId! {
                    cell1.askOrModifyButton.setTitle("修改", forState: UIControlState.Normal)
                }else{
                    cell1.askOrModifyButton.setTitle("報名", forState: UIControlState.Normal)
                }
            }
            return cell1
        } else if indexPath.row == 12 {
            //注意事項
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 105
        } else if indexPath.row == 11 {
            return 93
        } else if indexPath.row == 12 {
            return 220
        } else if indexPath.row == 7 {
            return 213
        } else if indexPath.row == 8 {
            //顯示大頭照與否
            let fromUser = detailItem?[kDateFromUser] as! PFUser
            if let objectId:String! = fromUser.objectId {
                if objectId == PFUser.currentUser()?.objectId! {
                    return 96
                }else{
                    return 48
                }
            }
        }else{
            return 48
        }
        return 48
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

    //計算倒數時間
    func stringForTimeIntervalFromDateNow(fromDateNow:NSDate, toDateDay:NSDate) -> String? {
        
        //倒數到約會時間的前12小時
        let newDate = toDateDay.dateByAddingTimeInterval(-60*60*12)
        
        var calendar:NSCalendar! = NSCalendar.currentCalendar()
        let dayComponents = calendar.components(.CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay | .CalendarUnitHour | .CalendarUnitMinute,
            fromDate: fromDateNow,
            toDate: newDate,
            options: nil)
        
        let year = dayComponents.year
        let month = dayComponents.month
        let day = dayComponents.day
        let hour = dayComponents.hour
        let min = dayComponents.minute
        
        println("\(year), \(month), \(day), \(hour), \(min)")
        
        return "\(day)D \(hour)H \(min)M"
    }
    
    
    
    @IBAction func dismiss(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    
    
    // MARK: - action
    
    @IBAction func askOrModifyButtonPressed(sender: AnyObject) {
        let fromUser = detailItem?[kDateFromUser] as! PFUser
        if let objectId:String! = fromUser.objectId {
            
            if objectId == PFUser.currentUser()?.objectId! {
                //可以修改
                
            }else{
                //確認當前用戶是否已經報名過，如果已經報名過，就提示，否則就新增報名
                var attributesForDate:NSDictionary! = CMCache.sharedCache()?.attributesForDate!(detailItem as! PFObject)
                if attributesForDate != nil {
                    //當前用戶是否已經報過名？
                    if CMCache.sharedCache().isDateAskedByCurrentUser(detailItem as! PFObject) {
                        //報過名
                        //已經報名過
                        let alertController = UIAlertController(title: "您過去曾報名",
                            message: "請靜候佳音",
                            preferredStyle: UIAlertControllerStyle.Alert
                        )
                        alertController.addAction(UIAlertAction(title: "確定",
                            style: UIAlertActionStyle.Default,
                            handler: nil)
                        )
                        // Display alert
                        self.presentViewController(alertController, animated: true, completion: nil)
                    }else{
                        //沒報過名，確認人數是否超過五人，超過就不能報名，沒超過才能報名
                        if CMCache.sharedCache().askCountForDate(detailItem as! PFObject).intValue < 5 {
                            //還能報名
                            //新增報名
                            //儲存報名資料
                            var savePostObject = PFObject(className: kAskDateListClassesKey)
                            savePostObject[kAskFromUser] = PFUser.currentUser()
                            savePostObject[kAskToUser] = fromUser
                            savePostObject[kAskDateFromPostDate] = self.detailItem as! PFObject
                            
                            var ACL = PFACL()
                            ACL.setPublicReadAccess(true)
                            ACL.setPublicWriteAccess(true)
                            savePostObject.ACL = ACL
                            
                            savePostObject.saveEventually({ (success, error) -> Void in
                                let alertController = UIAlertController(title: "完成報名",
                                    message: "請靜候佳音",
                                    preferredStyle: UIAlertControllerStyle.Alert
                                )
                                alertController.addAction(UIAlertAction(title: "確定",
                                    style: UIAlertActionStyle.Default,
                                    handler: nil)
                                )
                                // Display alert
                                self.presentViewController(alertController, animated: true, completion: nil)
                                self.loadFriends()
                                
                                CMCache.sharedCache().setDateIsAskedByCurrentUser(self.detailItem as! PFObject, asked: true)
                            })
                            
                            //另外要儲存Activities
                            var activities = PFObject(className: kPAPActivityClassKey)
                            activities[kPAPActivityDateKey]     = self.detailItem as! PFObject
                            activities[kPAPActivityTypeKey] = kPAPActivityTypeAsk
                            activities[kPAPActivityFromUserKey] = PFUser.currentUser()
                            activities[kPAPActivityToUserKey]   = fromUser
                            
                            activities.ACL = ACL
                            
                            activities.saveEventually({ (success, error) -> Void in
                                if success {
                                    //推播
                                    let privateChannelName:String! = fromUser.objectForKey(kPAPUserPrivateChannelKey) as! String
                                    if privateChannelName.isEmpty {
                                        
                                    }else{
                                        let user = PFUser.currentUser()
                                        let userName: String! = user?.objectForKey(kPAPUserFacebookLastNameKey) as! String
                                        let postDate: PFObject! = self.detailItem as! PFObject
                                        let data:Dictionary<String, String> = ["\(userName!) 報名您的約會." : kAPNSAlertKey,
                                            kPAPPushPayloadPayloadTypeActivityKey : kPAPPushPayloadPayloadTypeKey,
                                            kPAPPushPayloadActivityAskKey : kPAPPushPayloadActivityTypeKey,
                                            user!.objectId! : kPAPPushPayloadFromUserObjectIdKey,
                                            postDate.objectId! : kPAPPushPayloadPostDateObjectIdKey]
                                        
                                        let push:PFPush = PFPush()
                                        push.setChannel(privateChannelName)
                                        push.setData(data)
                                        push.sendPushInBackgroundWithBlock({ (success, error) -> Void in
                                            
                                        })
                                    }
                                    
                                }
                            })
                            
                        } else {
                            //不能報名
                            //已經額滿
                            let alertController = UIAlertController(title: "已經額滿",
                                message: "請參考其他的約會",
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
                }else{
                    //沒有緩存資料
                    var askAmount:PFQuery! = PFQuery(className: kAskDateListClassesKey)
                    askAmount.whereKey(kAskDateFromPostDate, equalTo: detailItem)
                    
                    //先確定現在報名人數是不是已經達到上限5人，若達上線就表示不能報名了
                    askAmount.countObjectsInBackgroundWithBlock({ (count, error) -> Void in
                        if error == nil {
                            if count < 5 {
                                //還能報名
                                let currentUser = PFUser.currentUser()!
                                askAmount.whereKey(kAskFromUser, equalTo: currentUser)
                                
                                askAmount.getFirstObjectInBackgroundWithBlock({ (askObject, error) -> Void in
                                    if error != nil {
                                        //新增報名
                                        //儲存報名資料
                                        var savePostObject = PFObject(className: kAskDateListClassesKey)
                                        savePostObject[kAskFromUser] = PFUser.currentUser()
                                        savePostObject[kAskToUser] = fromUser
                                        savePostObject[kAskDateFromPostDate] = self.detailItem as! PFObject
                                        
                                        var ACL = PFACL()
                                        ACL.setPublicReadAccess(true)
                                        ACL.setPublicWriteAccess(true)
                                        savePostObject.ACL = ACL
                                        
                                        savePostObject.saveEventually({ (success, error) -> Void in
                                            
                                            if success {
                                                let alertController = UIAlertController(title: "完成報名",
                                                    message: "請靜候佳音",
                                                    preferredStyle: UIAlertControllerStyle.Alert
                                                )
                                                alertController.addAction(UIAlertAction(title: "確定",
                                                    style: UIAlertActionStyle.Default,
                                                    handler: nil)
                                                )
                                                // Display alert
                                                self.presentViewController(alertController, animated: true, completion: nil)
                                                self.loadFriends()
                                                
                                                CMCache.sharedCache().setDateIsAskedByCurrentUser(self.detailItem as! PFObject, asked: true)
                                            }
                                            
                                        })
                                        
                                        //另外要儲存Activities
                                        var activities = PFObject(className: kPAPActivityClassKey)
                                        activities[kPAPActivityDateKey]     = self.detailItem as! PFObject
                                        activities[kPAPActivityTypeKey] = kPAPActivityTypeAsk
                                        activities[kPAPActivityFromUserKey] = PFUser.currentUser()
                                        activities[kPAPActivityToUserKey]   = fromUser
                                        
                                        activities.ACL = ACL
                                        
                                        activities.saveEventually({ (success, error) -> Void in
                                            if success {
                                                //推播
                                                let privateChannelName:String! = fromUser.objectForKey(kPAPUserPrivateChannelKey) as! String
                                                if privateChannelName.isEmpty {
                                                    
                                                }else{
                                                    let user = PFUser.currentUser()
                                                    let userName: String! = user?.objectForKey(kPAPUserFacebookLastNameKey) as! String
                                                    let postDate: PFObject! = self.detailItem as! PFObject
                                                    let data:Dictionary<String, String> = ["\(userName!) 報名您的約會" : kAPNSAlertKey,
                                                        kPAPPushPayloadPayloadTypeActivityKey : kPAPPushPayloadPayloadTypeKey,
                                                        kPAPPushPayloadActivityAskKey : kPAPPushPayloadActivityTypeKey,
                                                        user!.objectId! : kPAPPushPayloadFromUserObjectIdKey,
                                                        postDate.objectId! : kPAPPushPayloadPostDateObjectIdKey]
                                                    
                                                    let push:PFPush = PFPush()
                                                    push.setChannel(privateChannelName)
                                                    push.setData(data)
                                                    push.sendPushInBackgroundWithBlock({ (success, error) -> Void in
                                                        
                                                    })
                                                }
                                                
                                            }
                                        })
                                    }else{
                                        //已經報名過
                                        let alertController = UIAlertController(title: "您過去曾報名",
                                            message: "請靜候佳音",
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
                                //已經額滿
                                let alertController = UIAlertController(title: "已經額滿",
                                    message: "請參考其他的約會",
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
                }
            }
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 8 {
            
        } else if indexPath.row == 5 {
            //餐廳詳細資料
            self.performSegueWithIdentifier("detail", sender: detailItem!)
        }
    }
    

    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! UICollectionViewCell
        let imageView:UIImageView = cell.viewWithTag(1) as! UIImageView
        if self.friends.count > 0 {
            println("self.friend = \(self.friends.objectAtIndex(indexPath.row))")
            var dateObject:PFObject! = self.friends.objectAtIndex(indexPath.row) as! PFObject
            var fromUser:PFUser! = dateObject[kDateFromUser] as! PFUser
            if fromUser != nil {
                var query = PFUser.query()
                query?.getObjectInBackgroundWithId(fromUser.objectId!, block: { (fromuser, error) -> Void in
                    
                    if let picProfilePhotoFile: PFFile! = fromuser![kPAPUserProfilePicSmallKey] as? PFFile {
                        if picProfilePhotoFile != nil {
                            picProfilePhotoFile?.getDataInBackgroundWithBlock({ (imageDate, error:NSError?) -> Void in
                                if error != nil {
                                    
                                }else{
                                    imageView.image = UIImage(data: imageDate!)
                                    imageView.layer.cornerRadius = 23
                                }
                            })
                        }
                    }
                })
                
            }
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.friends.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(46, 46)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("choseTa", sender: detailItem)
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
        if segue.identifier == "choseTa" {
            let view = segue.destinationViewController as! ChosseTaTableViewController
            view.detailItem = detailItem
        } else if segue.identifier == "detail" {
            let view = segue.destinationViewController as! RestaurantDetailTableViewController
            view.detailItem = detailItem
        }
        
    }


}
