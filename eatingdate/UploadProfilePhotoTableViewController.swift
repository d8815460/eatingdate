//
//  UploadProfilePhotoTableViewController.swift
//  eatClub
//
//  Created by 駿逸 陳 on 2015/4/19.
//  Copyright (c) 2015年 miiitech. All rights reserved.
//

import UIKit
import MobileCoreServices

protocol UploadProfilePhotoDelegate
{
    func finishButtonPressed()
}

class UploadProfilePhotoTableViewController: UITableViewController, UIImagePickerControllerDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, UIAlertViewDelegate, UIPopoverControllerDelegate {
    
    @IBOutlet var nextButton: UIButton!
    var picker:UIImagePickerController = UIImagePickerController()
    var popover:UIPopoverController! = nil
    var hud:MBProgressHUD!
    
    var delegate:UploadProfilePhotoDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        nextButton.hidden = true
        
        self.navigationController?.navigationBarHidden = false
        self.navigationItem.hidesBackButton = false
        let label = UILabel()
        label.backgroundColor = UIColor.clearColor()
        label.font = UIFont.boldSystemFontOfSize(20.0)
        label.shadowColor = UIColor(white: 0.0, alpha: 0.5)
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor.whiteColor()
        self.navigationItem.titleView = label
        label.text = "上傳個人照片"
        label.sizeToFit()
        
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
        return 3
    }

    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell!
        
        if indexPath.row == 0 {
            var cell: uploadPhotoCell! = tableView.dequeueReusableCellWithIdentifier("photoCell", forIndexPath: indexPath) as! uploadPhotoCell
            
            let cellImageLayer:CALayer = cell.uploadPhotoView.layer
            cellImageLayer.cornerRadius = 8.0
            cellImageLayer.masksToBounds = true
            
            return cell
        }else if indexPath.row == 1{
            cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
            cell.textLabel?.text = "外表的形容"
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }else if indexPath.row == 2{
            cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
            cell.textLabel?.text = "最滿意的部位"
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        // Configure the cell...

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let row = indexPath.row
        if row == 0 {
            return 202.0
        }else{
            return 60.0
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let row = indexPath.row
        if row == 0 {
            //上傳大頭照
        }else if row == 1 {
            //外表的形容
        }else if row == 2 {
            //最滿意的部位
        }else{
            
        }
    }
    
    
    
    // MARK: - UIImagePicker Delegate
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        println("取得照片\(image)")
        self.hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        self.hud.labelText = "開始上傳照片"
        self.hud.dimBackground = true
        
        var firstIndex:NSIndexPath = NSIndexPath(forRow: 0, inSection: 0)
        var cell:uploadPhotoCell! = self.tableView.cellForRowAtIndexPath(firstIndex) as! uploadPhotoCell
        
        //指定cell裡面的ImageView
        cell.uploadPhotoView.image = image
        cell.addPhotoButton.setTitle("", forState: .Normal)
        self.dismissViewControllerAnimated(true, completion: nil)
        
        //儲存到個人的檔案大頭照
        //要將照片壓縮成兩個大小，以利儲存到WriteTask的picMedium & picSmall
        var medium = image.thumbnailImage(640, transparentBorder: 0, cornerRadius: 0, interpolationQuality: kCGInterpolationHigh)
        var small  = image.thumbnailImage(120, transparentBorder: 0, cornerRadius: 0, interpolationQuality: kCGInterpolationLow)
        var mediumData = UIImagePNGRepresentation(medium)
        var smallData  = UIImagePNGRepresentation(small)
        
        var 串行執行列隊 = dispatch_queue_create(kPAPUploadPhotoQueueKey, DISPATCH_QUEUE_SERIAL)
        
        let user = PFUser.currentUser()
        
        var ACL = PFACL()
        ACL.setPublicReadAccess(true)
        
        user!.ACL = ACL
        
        dispatch_async(串行執行列隊, { () -> Void in
            if mediumData.length > 0 {
                var fileMediumImage:PFFile! = PFFile(data: mediumData)
                fileMediumImage.saveInBackgroundWithBlock({ (succeeded:Bool, error:NSError?) -> Void in
                    if succeeded {
                        //成功上傳
                        user?.setObject(fileMediumImage, forKey: kPAPUserProfilePicMediumKey)
                        user?.saveInBackgroundWithBlock({ (succeeded:Bool, error:NSError?) -> Void in
                            MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                            self.nextButton.hidden = false
                        })
                    }else{
                        //上傳失敗
                    }
                    }, progressBlock: { (precentDone:Int32) -> Void in
                        // Update your progress spinner here. percentDone will be between 0 and 100.
                        println("\(precentDone)")
                        if precentDone < 100 && precentDone != 0{
                            
                        }else{
                            
                        }
                        
                })
            }
        })
        
        dispatch_async(串行執行列隊, { () -> Void in
            if smallData.length > 0 {
                var fileSmallImage:PFFile! = PFFile(data: smallData)
                fileSmallImage.saveInBackgroundWithBlock({ (succeeded:Bool, error:NSError?) -> Void in
                    if succeeded {
                        //成功上傳
                        user?.setObject(fileSmallImage, forKey: kPAPUserProfilePicSmallKey)
                    }else{
                        //上傳失敗
                    }
                    }, progressBlock: { (precentDone:Int32) -> Void in
                        // Update your progress spinner here. percentDone will be between 0 and 100.
                })
            }
        })
    }
    
    
    
    
    
    @IBAction func uploadButtonPressed(sender: AnyObject) {
        
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
    
    @IBAction func finishButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            //要通知登入畫面 dismissViewController
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.presentToHomePage()
        })
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO 
    if you do not want the specified item to be editable.
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
