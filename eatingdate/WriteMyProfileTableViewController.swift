//
//  WriteMyProfileTableViewController.swift
//  eatClub
//
//  Created by 駿逸 陳 on 2015/4/18.
//  Copyright (c) 2015年 miiitech. All rights reserved.
//

import UIKit

class WriteMyProfileTableViewController: UITableViewController, UITextFieldDelegate, UIActionSheetDelegate {

    
    @IBOutlet var firstNameField: UITextField!
    @IBOutlet var lastNameField: UITextField!
    @IBOutlet var workField: UITextField!
    @IBOutlet var livePlaceLabel: UILabel!
    @IBOutlet var genderLabel: UILabel!
    @IBOutlet var birthdayLabel: UILabel!
    @IBOutlet var heightLabel: UILabel!
    @IBOutlet var educationalLabel: UILabel!
    @IBOutlet var emotionalStatusLabel: UILabel!
    @IBOutlet var nextStepButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        nextStepButton.hidden = true
        
        lastNameField.tag = 100
        firstNameField.tag = 101
        workField.tag = 102
        
        
        
        self.navigationController?.navigationBarHidden = false
        self.navigationItem.hidesBackButton = true
        let label = UILabel()
        label.backgroundColor = UIColor.clearColor()
        label.font = UIFont.boldSystemFontOfSize(20.0)
        label.shadowColor = UIColor(white: 0.0, alpha: 0.5)
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor.whiteColor()
        self.navigationItem.titleView = label
        label.text = "請輸入基本資料"
        label.sizeToFit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        println("textfield tag = \(textField.tag)")
        if textField.tag == 100 {
            //跳下一個，名字
            firstNameField.becomeFirstResponder()
            
        }else if textField.tag == 101 {
            //跳下一個，職業
            workField.becomeFirstResponder()
            
        }else if textField.tag == 102 {
            //跳居住地，選擇模式，等同於選擇 table cell = index 3
            workField.resignFirstResponder()
            nextStepButton.hidden = false
        }
        
        return true
    }
    
    @IBAction func nextButtonPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("uploadProfilePhoto", sender: self)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 64
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nextStepButton
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var cell:UITableViewCell!
        
        if indexPath.row > 2 {
            cell = self.tableView(tableView, cellForRowAtIndexPath: indexPath) as! WriteProfileCells
        }
        
        if indexPath.row == 3 {
            //性別
            /* Supports UIAlert Controller */
            if( controllerAvailable()){
                handleIOS8(cell as! WriteProfileCells)
            } else {
                var actionSheet:UIActionSheet
                actionSheet = UIActionSheet(title: "選擇性別", delegate: self, cancelButtonTitle: nil, destructiveButtonTitle: "我是男性", otherButtonTitles: "我是女性")
                actionSheet.delegate = self
                actionSheet.showInView(self.view)
                /* Implement the delegate for actionSheet */
            }
            
        } else if indexPath.row == 4 {
            //居住地
        } else if indexPath.row == 5 {
            //生日
        } else if indexPath.row == 6 {
            //身高
        } else if indexPath.row == 7 {
            //學歷
        } else if indexPath.row == 8 {
            //感情狀態
        }
        
    }

    
    
    func handleIOS8(cell:WriteProfileCells!){
        
        let alert = UIAlertController(title: "選擇性別", message: "一旦選擇了性別，之後就不能再做變更。", preferredStyle: UIAlertControllerStyle.ActionSheet)
        let manButton = UIAlertAction(title: "我是男性", style: UIAlertActionStyle.Default) { (alert) -> Void in
            self.choseGender(cell, gender: "我是男性");
        }
        let femaleButton = UIAlertAction(title: "我是女性", style: UIAlertActionStyle.Default) { (alert) -> Void in
            self.choseGender(cell, gender: "我是女性");
        }
        let cancelButton = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel) { (alert) -> Void in
            println("取消")
        }
        
        alert.addAction(cancelButton)
        alert.addAction(manButton)
        alert.addAction(femaleButton)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func choseGender(cell:WriteProfileCells, gender:String!){
        cell.detailLabel.text = "\(gender)"
        //選完性別之後，就先顯示 下一步
        self.nextStepButton.hidden = false
    }
    
    func controllerAvailable() -> Bool {
        if let gotModernAlert: AnyClass = NSClassFromString("UIAlertController") {
            return true;
        }
        else {
            return false;
        }
    }
    
    
    
    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Potentially incomplete method implementation.
//        // Return the number of sections.
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete method implementation.
//        // Return the number of rows in the section.
//        return 0
//    }

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
