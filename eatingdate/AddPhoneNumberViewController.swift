//
//  AddPhoneNumberViewController.swift
//  eatingdate
//
//  Created by 駿逸 陳 on 2015/5/23.
//  Copyright (c) 2015年 駿逸 陳. All rights reserved.
//

import UIKit

class AddPhoneNumberViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var addPhoneField: UITextField!
    @IBOutlet weak var addPhoneButton: UIButton!
    @IBOutlet var lawView: UIView!
    @IBOutlet var agreeSegmented: UISegmentedControl!
    
    var hud:MBProgressHUD!
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorView.hidden = true
        // Do any additional setup after loading the view.
        addPhoneButton.userInteractionEnabled = false
        addPhoneButton.setBackgroundImage(self.imageWithColor(UIColor.grayColor()), forState: UIControlState.Normal)
        
        addPhoneField.delegate = self
        addPhoneField.layer.borderColor = UIColor.blackColor().CGColor
        addPhoneField.layer.borderWidth = 1
        addPhoneField.layer.cornerRadius = 5
        
        lawView.layer
        lawView.layer.borderColor = UIColor.redColor().CGColor
        lawView.layer.borderWidth = 1
    }

    func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRectMake(0.0, 0.0, addPhoneButton.frame.size.width, addPhoneButton.frame.height)
        UIGraphicsBeginImageContext(rect.size)
        let context:CGContextRef = UIGraphicsGetCurrentContext()
        
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let newString = (textField.text as NSString).stringByReplacingCharactersInRange(range, withString: string)
        
        if count(newString) > 10 || count(newString) < 10 {
            println("\(count(newString))")
            addPhoneButton.userInteractionEnabled = false
            addPhoneButton.setBackgroundImage(self.imageWithColor(UIColor.grayColor()), forState: UIControlState.Normal)
        }else{
            addPhoneButton.userInteractionEnabled = true
            addPhoneButton.setBackgroundImage(self.imageWithColor(UIColor(red: 195.0/255.0, green: 13/255.0, blue: 35/255.0, alpha: 1.0)), forState: UIControlState.Normal)
        }
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func addPhoneNumberButtonPressed(sender: AnyObject) {
        
        if agreeSegmented.selectedSegmentIndex == 1 {
            //不同意
            let alertController = UIAlertController(title: "協議事項",
                message: "註冊前，須同意協議事項。",
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
        
        
        activityIndicatorView.hidden = false
        activityIndicatorView.startAnimating()
        
        //先確認用戶手機號碼總共有十碼，而且是09開頭的
        self.addPhoneField.resignFirstResponder()
        
        if count(self.addPhoneField.text) == 10 || self.addPhoneField.text.hasPrefix("09")  {
            
        } else {
            activityIndicatorView.stopAnimating()
            activityIndicatorView.hidden = true
            
            let alertController = UIAlertController(title: "電話號碼錯誤",
                message: "請輸入台灣本地的行動電話",
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
        self.hud.labelText = "開始OTP驗證"
        self.hud.dimBackground = true
        
        //儲存電話號碼至用戶名稱(username)& phone
        var user = PFUser.currentUser()!
        
        if PFUser.currentUser() != nil {
            //OTP驗證
            //隨機亂碼
            let valueCodeNumber = randomNumber(range: 1000...9999)
            user["phoneCode"] = valueCodeNumber
            //雲端代碼
            let number = "number"
            let phoneCode = "phoneCode"
            let variable = self.addPhoneField.text.toInt()
            let userPhoneNumber = "+886\(variable!)"
            let params = [number:userPhoneNumber, phoneCode:valueCodeNumber]
            
            user["username"] = self.addPhoneField.text
            user["phone"] = self.addPhoneField.text
            
            user.saveInBackgroundWithBlock({ (success, error:NSError?) -> Void in
                if success {
                    
                    self.activityIndicatorView.stopAnimating()
                    self.activityIndicatorView.hidden = true
                    
                    //開始雲端程式碼，傳送簡訊至用戶手機
                    PFCloud.callFunctionInBackground("inviteWithTwilio", withParameters: params as [NSObject : AnyObject]) { (response: AnyObject?, error: NSError?) -> Void in
                        if error == nil {
                            println("簡訊已經送出")
                            //開始轉頁
                            //開始轉場，看要轉到哪裡去，進行手機驗證
                            self.performSegueWithIdentifier("phone", sender: self)
                        }else{
                            
                        }
                    }
                }
            })
        }
    }
    
    
    func randomNumber(range: Range<Int> = 1...6) -> Int {
        let min = range.startIndex
        let max = range.endIndex
        return Int(arc4random_uniform(UInt32(max - min))) + min
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
