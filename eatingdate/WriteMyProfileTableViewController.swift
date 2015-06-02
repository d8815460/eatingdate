//
//  WriteMyProfileTableViewController.swift
//  eatClub
//
//  Created by 駿逸 陳 on 2015/4/18.
//  Copyright (c) 2015年 miiitech. All rights reserved.
//

import UIKit

extension Int {
    var days:Int {
        return 60*60*24*self
    }
    
    var years:Int {
        return 60*60*24*365*self
    }
    
    var ago:NSDate{
        return NSDate().dateByAddingTimeInterval(-Double(self))
    }
}

class WriteMyProfileTableViewController: UITableViewController, UITextFieldDelegate, UIActionSheetDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    
    @IBOutlet var firstNameField: UITextField!
    @IBOutlet var lastNameField: UITextField!
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
            //跳下一個，性別
            self.view.endEditing(true)
            let index:NSIndexPath! = NSIndexPath(forRow: 2, inSection: 0)
            tableView(self.tableView, didSelectRowAtIndexPath: index)
        }
        
        return true
    }
    
    @IBAction func nextButtonPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("uploadProfilePhoto", sender: self)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 64
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nextStepButton
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        /*
        0.姓氏
        1.名字
        2.性別
        3.居住地
        4.出生年月日
        5.身高
        6.體型
        7.職業
        */
        
        if indexPath.row > 1 {
            var cell:WriteProfileCells!
            
            cell = self.tableView(tableView, cellForRowAtIndexPath: indexPath) as! WriteProfileCells
            
            if indexPath.row == 2 {
                //性別
                /* Supports UIAlert Controller */
                if( controllerAvailable()){
                    handleIOS8(cell)
                } else {
                    var actionSheet:UIActionSheet
                    actionSheet = UIActionSheet(title: "選擇性別", delegate: self, cancelButtonTitle: nil, destructiveButtonTitle: "我是男性", otherButtonTitles: "我是女性")
                    actionSheet.delegate = self
                    actionSheet.showInView(self.view)
                    /* Implement the delegate for actionSheet */
                }
            } else if indexPath.row == 3 {
                //居住地
                
            } else if indexPath.row == 4 {
                //出生年月日
                DatePickerDialog().show(title: "選擇出生日期", doneButtonTitle: "確定", cancelButtonTitle: "取消", defaultDate: 25.years.ago, datePickerMode: .Date, callback: { (date) -> Void in
                    println("\(date)")
                    var dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "MM/dd/yyyy"   // 資料庫的規劃是 月份/日期/年份
                    let birthday = dateFormatter.stringFromDate(date)
                    println("\(birthday)")
                    
                    cell.detailLabel.text = "\(birthday)"
                })
            } else if indexPath.row == 5 {
                //身高
            } else if indexPath.row == 6 {
                //體型
            } else if indexPath.row == 7 {
                //職業
            }
        }else{
            var cell:UITableViewCell!
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
        
        //選完性別之後，跳下一個選擇居住地
        let index:NSIndexPath! = NSIndexPath(forRow: 3, inSection: 0)
        tableView(self.tableView, didSelectRowAtIndexPath: index)
        
        
        //選完性別之後，就先顯示 下一步
//        self.nextStepButton.hidden = false
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
