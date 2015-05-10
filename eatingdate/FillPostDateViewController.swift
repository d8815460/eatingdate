//
//  FillPostDateViewController.swift
//  eatingdate
//
//  Created by 駿逸 陳 on 2015/5/9.
//  Copyright (c) 2015年 駿逸 陳. All rights reserved.
//

import UIKit
import MobileCoreServices

class FillPostDateViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, UIAlertViewDelegate, UIPopoverControllerDelegate {

    @IBOutlet weak var nextButton: UIButton!
    var picker:UIImagePickerController = UIImagePickerController()
    var popover:UIPopoverController! = nil
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.setTitle("下一步", forState: UIControlState.Normal)
        nextButton.hidden = true
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //當所有選項都填完之後，nextButton才會顯示。
        
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        /*  0.照片        高125    photoCell
            1.主題        高48     twoFillCell
            2.日期+時間   高48       twoFillCell
            3.餐廳        高48     twoFillCell
            4.注意事項    高未知       attentionCell
        */
        var cell: UITableViewCell!
        
        if indexPath.row == 0 {
            var cell: PostDatePhotoCell! = tableView.dequeueReusableCellWithIdentifier("photoCell", forIndexPath: indexPath) as! PostDatePhotoCell
            return cell
        }else if indexPath.row == 1{
            cell = tableView.dequeueReusableCellWithIdentifier("twoFillCell", forIndexPath: indexPath) as! UITableViewCell
            cell.textLabel?.text = "主題"
        }else if indexPath.row == 2{
            cell = tableView.dequeueReusableCellWithIdentifier("twoFillCell", forIndexPath: indexPath) as! UITableViewCell
            cell.textLabel?.text = "時間日期"
        }else if indexPath.row == 3{
            cell = tableView.dequeueReusableCellWithIdentifier("twoFillCell", forIndexPath: indexPath) as! UITableViewCell
            cell.textLabel?.text = "餐廳"
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
            hight = 48
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
            2.日期+時間
            3.餐廳
            4.注意事項
        */
        
        if indexPath.row == 0 {
            //照片
        }else if indexPath.row == 1{
            
        }else if indexPath.row == 2{
           
        }else if indexPath.row == 3{
            
        }else if indexPath.row == 4{
            
        }else{
            
        }
        
    }
    
    
    // MARK: - UIImagePicker Delegate
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        var firstIndex:NSIndexPath = NSIndexPath(forRow: 0, inSection: 0)
        var cell:PostDatePhotoCell! = self.tableView.cellForRowAtIndexPath(firstIndex) as! PostDatePhotoCell
        
        //指定cell裡面的ImageView
        cell.uploadPhotoView.image = image
        cell.addPhotoButton.setTitle("", forState: .Normal)
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
    
    @IBAction func nextButtonPressed(sender: AnyObject) {
        
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
