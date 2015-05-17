//
//  FillPostDateViewController.swift
//  eatingdate
//
//  Created by 駿逸 陳 on 2015/5/9.
//  Copyright (c) 2015年 駿逸 陳. All rights reserved.
//

import UIKit
import MobileCoreServices

let datePickerTag: Int = 100
let timePickerTag: Int = 101
let uploadImageViewTag: Int = 102

class FillPostDateViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, UIAlertViewDelegate, UIPopoverControllerDelegate {

    @IBOutlet weak var nextButton: UIButton!
    var picker:UIImagePickerController = UIImagePickerController()
    var popover:UIPopoverController! = nil
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var datePicker: UIDatePicker!
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var dateTypeSegmented: UISegmentedControl!
    
    
    
    
    
    var task:WriteTask!
    

    var cells:NSArray = []
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //暫存的約會任務單
        self.task = WriteTask.sharedWriteTask() as! WriteTask
        
        println("self.task = \(self.task)")
        
        nextButton.setTitle("下一步", forState: UIControlState.Normal)
        nextButton.hidden = true
        
        // Do any additional setup after loading the view.
        
        // Cells is a 2D array containing sections and rows.
        cells = [[DVDatePickerTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)], [DVDatePickerTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)]]
        
        //男生預設是我請客，女生預設是誰請我
        if let gender:String = PFUser.currentUser()?.objectForKey("gender") as? String {
            if gender == "male" {
                dateTypeSegmented.selectedSegmentIndex = 0
                self.task.dateType = "我請客"
            }else if gender == "female" {
                dateTypeSegmented.selectedSegmentIndex = 1
                self.task.dateType = "誰請我"
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //當所有選項都填完之後，nextButton才會顯示。
        println("will appear \(self.task.restaurant)")
        self.table.reloadData()
        
        if self.task.restaurant != nil && self.task.dateTime != nil && self.task.dateTitle != nil {
            self.nextButton.hidden = false
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        /*  0.照片        高125    photoCell
            1.主題        高48     twoFillCell
            2.日期        高48     twoFillCell
            3.時間        高48     twoFillCell
            4.餐廳        高48     twoFillCell
            5.注意事項    高未知     attentionCell
        */
        var cell: UITableViewCell!
        
        if indexPath.row == 0 {
            var cell: PostDatePhotoCell! = tableView.dequeueReusableCellWithIdentifier("photoCell", forIndexPath: indexPath) as! PostDatePhotoCell
            cell.uploadPhotoView.tag = uploadImageViewTag
            return cell
        }else if indexPath.row == 1{
            cell = tableView.dequeueReusableCellWithIdentifier("twoFillCell", forIndexPath: indexPath) as! UITableViewCell
            cell.textLabel?.text = "主題"
            
            if task.dateTitle != nil {
                println("主題 \(task.dateTitle)")
                cell.detailTextLabel?.text = task.dateTitle
            }else{
                cell.detailTextLabel?.text = "簡述約會主題"
            }
        }else if indexPath.row == 2{
            var cell = cells[0][0] as! DVDatePickerTableViewCell
            cell.leftLabel.text = "日期/時間"
            var now = NSDate()
            //1個小時
            var calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
            var comps = NSDateComponents()
            comps.hour = 1
            var onehourlater = calendar?.dateByAddingComponents(comps, toDate: now, options: nil)
            cell.datePicker.minimumDate = onehourlater
            cell.datePicker.minuteInterval = 15
            return cell
        }else if indexPath.row == 3{
            cell = tableView.dequeueReusableCellWithIdentifier("twoFillCell", forIndexPath: indexPath) as! UITableViewCell
            cell.textLabel?.text = "餐廳"
            if self.task.restaurant != nil {
                cell.detailTextLabel?.text = self.task.restaurant?.objectForKey("name") as? String
            }else{
                cell.detailTextLabel?.text = "選擇餐廳"
            }
            
            return cell
        }else if indexPath.row == 4{
            cell = tableView.dequeueReusableCellWithIdentifier("attentionCell", forIndexPath: indexPath) as! UITableViewCell
        }else{
            cell = nil
        }
        return cell
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var hight:CGFloat!
        if indexPath.row == 0 {
            hight = 125
        }else if indexPath.row == 1{
            hight = 48
        }else if indexPath.row == 2{
            var cell = self.tableView(tableView, cellForRowAtIndexPath: indexPath)
            return (cell as! DVDatePickerTableViewCell).datePickerHeight()
        }else if indexPath.row == 3{
            hight = 48
        }else if indexPath.row == 4{
            hight = 220
        }else{
            hight = 44
        }
        return hight
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        /*  0.照片
            1.主題
            2.日期
            3.時間
            4.餐廳
            5.注意事項
        */
        
        
        if indexPath.row == 0 {
            //照片
        }else if indexPath.row == 1{
            //設定主題
            self.performSegueWithIdentifier("mainTitle", sender: self)
        }else if indexPath.row == 2{
            //設定日期 時間
            var cell = self.tableView(tableView, cellForRowAtIndexPath: indexPath)
            if (cell.isKindOfClass(DVDatePickerTableViewCell)) {
                var datePickerTableViewCell = cell as! DVDatePickerTableViewCell
                datePickerTableViewCell.selectedInTableView(tableView)
            }
        }else if indexPath.row == 3{
            //設定餐廳
            self.performSegueWithIdentifier("choseRestaurant", sender: self)
        }else if indexPath.row == 4{
            
        }else{
            
        }
    }
    
    // MARK: - UIDatePicker Delegate
    @IBAction func datePickerChanged(sender: UIDatePicker) {
        var dateformatter = NSDateFormatter()
        dateformatter.dateStyle = NSDateFormatterStyle.ShortStyle
        
        if datePicker.tag == datePickerTag {
            var strDate = dateformatter.stringFromDate(datePicker.date)
            let index:NSIndexPath = NSIndexPath(forRow: 2, inSection: 0)
            var cell = self.table.dequeueReusableCellWithIdentifier("twoFillCell", forIndexPath: index) as! UITableViewCell
            cell.detailTextLabel?.text = strDate
        }else if datePicker.tag == timePickerTag {
            var strTime = dateformatter.stringFromDate(datePicker.date)
            let index:NSIndexPath = NSIndexPath(forRow: 3, inSection: 0)
            var cell = self.table.dequeueReusableCellWithIdentifier("twoFillCell", forIndexPath: index) as! UITableViewCell
            cell.detailTextLabel?.text = strTime
        }
    }
    
    
    // MARK: - UIImagePicker Delegate
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        var firstIndex:NSIndexPath = NSIndexPath(forRow: 0, inSection: 0)
        var cell:PostDatePhotoCell! = self.table.cellForRowAtIndexPath(firstIndex) as! PostDatePhotoCell
        
        //指定cell裡面的ImageView
        cell.uploadPhotoView.image = image
        cell.addPhotoButton.setTitle("", forState: .Normal)
        cell.addLabel.text = ""
        
        //要將照片壓縮成兩個大小，以利儲存到WriteTask的picMedium & picSmall
        var medium = image.thumbnailImage(640, transparentBorder: 0, cornerRadius: 0, interpolationQuality: kCGInterpolationHigh)
        var small  = image.thumbnailImage(120, transparentBorder: 0, cornerRadius: 0, interpolationQuality: kCGInterpolationLow)
        var mediumData = UIImagePNGRepresentation(medium)
        var smallData  = UIImagePNGRepresentation(small)
        
        var 串行執行列隊 = dispatch_queue_create(kPAPUploadPhotoQueueKey, DISPATCH_QUEUE_SERIAL)
        
        dispatch_async(串行執行列隊, { () -> Void in
            if mediumData.length > 0 {
                var fileMediumImage:PFFile! = PFFile(data: mediumData)
                fileMediumImage.saveInBackgroundWithBlock({ (succeeded:Bool, error:NSError?) -> Void in
                    if succeeded {
                        //成功上傳
                        self.task.picMedium = fileMediumImage
                    }else{
                        //上傳失敗
                    }
                    }, progressBlock: { (precentDone:Int32) -> Void in
                    // Update your progress spinner here. percentDone will be between 0 and 100.
                        println(" 中 precentDone\(precentDone)")
                        if precentDone < 100 && precentDone != 0{
                            cell.progressView.hidden = false
                        }else{
                            cell.progressView.hidden = true
                        }
                        cell.progressView.setProgress(( Float(precentDone) / 100.0), animated: true);
                })
            }
        })
        
        dispatch_async(串行執行列隊, { () -> Void in
            if smallData.length > 0 {
                var fileSmallImage:PFFile! = PFFile(data: smallData)
                fileSmallImage.saveInBackgroundWithBlock({ (succeeded:Bool, error:NSError?) -> Void in
                    if succeeded {
                        //成功上傳
                        self.task.picSmall = fileSmallImage
                    }else{
                        //上傳失敗
                    }
                    }, progressBlock: { (precentDone:Int32) -> Void in
                        // Update your progress spinner here. percentDone will be between 0 and 100.
                })
            }
        })
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addPhotoButtonPressed(sender: AnyObject) {
        /* Supports UIAlert Controller */
        if( controllerAvailable()){
            handleIOS8()
        } else {
            var actionSheet:UIActionSheet
            if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
                actionSheet = UIActionSheet(title: "Hello this is IOS7", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil,otherButtonTitles:"從相簿選擇照片", "直接拍照")
            } else {
                actionSheet = UIActionSheet(title: "Hello this is IOS7", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil,otherButtonTitles:"從相簿選擇照片")
            }
            actionSheet.delegate = self
            actionSheet.showInView(self.view)
            /* Implement the delegate for actionSheet */
        }
        
        
        let cameraDeviceAvailable: Bool = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        let photoLibraryAvailable: Bool = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary)
    }
    
    
    func handleIOS8(){
        
        self.picker.editing = true
        self.picker.delegate = self;
        
        let alert = UIAlertController(title: "開始上傳照片", message: "請選擇您照片的來源", preferredStyle: UIAlertControllerStyle.ActionSheet)
        let libButton = UIAlertAction(title: "從相簿選擇照片", style: UIAlertActionStyle.Default) { (alert) -> Void in
            
            self.picker.allowsEditing = true
            self.picker.delegate = self
            self.picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.presentViewController(self.picker, animated: true, completion: nil)
        }
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
            let cameraButton = UIAlertAction(title: "直接拍照", style: UIAlertActionStyle.Default) { (alert) -> Void in
                println("直接拍照")
                self.picker.sourceType = UIImagePickerControllerSourceType.Camera
                self.picker.allowsEditing = true
                self.picker.showsCameraControls = true
                self.picker.delegate = self
                self.presentViewController(self.picker, animated: true, completion: nil)
                
            }
            alert.addAction(cameraButton)
        } else {
            println("照相機不支援")
            
        }
        let cancelButton = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel) { (alert) -> Void in
            println("Cancel Pressed")
        }
        
        alert.addAction(libButton)
        alert.addAction(cancelButton)
        
        /* Code for UIAlert View Controller
        let alert = UIAlertController(title: "This is an alert!", message: "Using UIAlertViewController", preferredStyle: UIAlertControllerStyle.Alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (okSelected) -> Void in
        println("Ok Selected")
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (cancelSelected) -> Void in
        println("Cancel Selected")
        }
        alert.addAction(okButton)
        alert.addAction(cancelButton)
        */
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func controllerAvailable() -> Bool {
        if let gotModernAlert: AnyClass = NSClassFromString("UIAlertController") {
            return true;
        }
        else {
            return false;
        }
    }
    
    func shouldPresentPhotoCaptureController () -> Bool {
        var presentedPhotoCaptureController = self.shouldStartCameraController()
        
        if presentedPhotoCaptureController {
            
        }else{
            presentedPhotoCaptureController = self.shouldStartPhotoLibraryPickerController()
        }
        
        return presentedPhotoCaptureController
    }
    
    func shouldStartCameraController () -> Bool {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) == false {
            return false
        }
        
        let cameraUI = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            
            cameraUI.mediaTypes = [kUTTypeImage]
            cameraUI.sourceType = UIImagePickerControllerSourceType.Camera
            
            if UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.Rear) {
                cameraUI.cameraDevice = UIImagePickerControllerCameraDevice.Rear
            }else if UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.Front) {
                cameraUI.cameraDevice = UIImagePickerControllerCameraDevice.Front
            }
        }else{
            return false
        }
        
        cameraUI.allowsEditing = true
        cameraUI.showsCameraControls = true
        cameraUI.delegate = self
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            self.presentViewController(cameraUI, animated: true, completion: nil)
        }else{
//            popover = UIPopoverController(contentViewController: picker)
        }
        
        return true
    }
    
    func shouldStartPhotoLibraryPickerController () -> Bool {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) == false && UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum) == false {
            return false
        }
        
        let cameraUI = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            
            cameraUI.mediaTypes = [kUTTypeImage]
            cameraUI.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            
        }else if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum) {
            
            cameraUI.mediaTypes = [kUTTypeImage]
            cameraUI.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
            
        }
        
        cameraUI.allowsEditing = true
        cameraUI.delegate = self
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            self.presentViewController(cameraUI, animated: true, completion: nil)
        }else{
            //            popover = UIPopoverController(contentViewController: picker)
        }
        
        return true
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        
        println("Title : \(actionSheet.buttonTitleAtIndex(buttonIndex))")
        println("Button Index : \(buttonIndex)")
        
        picker.editing = false
        picker.delegate = self;
        if( buttonIndex == 1){
            picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.picker.allowsEditing = true
            self.picker.delegate = self
        } else if(buttonIndex == 2){
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            self.picker.allowsEditing = true
            self.picker.showsCameraControls = true
            self.picker.delegate = self
        } else {
            
        }
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    @IBAction func dateTypeButtonPressed(sender: AnyObject) {
        var dateTypeSeg = sender as! UISegmentedControl
        println("dateTypeSet = \(dateTypeSeg.selectedSegmentIndex)")
        if dateTypeSeg.selectedSegmentIndex == 0 {
            self.task.dateType = "我請客"
        }else if dateTypeSeg.selectedSegmentIndex == 1 {
            self.task.dateType = "誰請我"
        }
    }
    
    @IBAction func nextButtonPressed(sender: AnyObject) {
        
    }
    
    
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
    }
}
