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
        
        //取得該約會單目前的報名人。
        var askAmount:PFQuery! = PFQuery(className: kAskDateClassesKey)
        askAmount.whereKey(kAskDateFromPostDate, equalTo: detailItem)
        let currentUser = detailItem?[kDateFromUser] as! PFUser
        askAmount.whereKey(kAskFromUser, notEqualTo: currentUser)
        askAmount.whereKey(kAskToUser, equalTo: currentUser)
        
        askAmount.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            if error != nil {
                println("get any error \(error)")
            }else{
                self.friends = objects
                
                //重新整理tableview reload
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            cell.detailTextLabel?.text = ""
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
            if self.friends != nil {
                if self.friends.count == 0{
                    //使用一般cell即可
                    return 48
                }else{
                    return 96
                }
            }else{
                return 48
            }
            
        }else{
            return 48
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
                var askAmount:PFQuery! = PFQuery(className: kAskDateClassesKey)
                askAmount.whereKey(kAskDateFromPostDate, equalTo: detailItem)
                let currentUser = PFUser.currentUser()!
                askAmount.whereKey(kAskFromUser, equalTo: currentUser)
                
                askAmount.getFirstObjectInBackgroundWithBlock({ (askObject, error) -> Void in
                    if error != nil {
                        //新增報名
                        //儲存報名資料
                        var savePostObject = PFObject(className: kAskDateClassesKey)
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
                
                
            }
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 8 {
            if self.friends.count > 0 {
//                self.performSegueWithIdentifier("choseTa", sender: detailItem)
            }
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
        let view = segue.destinationViewController as! ChosseTaTableViewController
        view.detailItem = detailItem
        
    }


}
