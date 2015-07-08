//
//  PhoneVerifiedViewController.swift
//  eatingdate
//
//  Created by 駿逸 陳 on 2015/5/22.
//  Copyright (c) 2015年 駿逸 陳. All rights reserved.
//

import UIKit

class PhoneVerifiedViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var startVerifiedButton: UIButton!
    @IBOutlet var countDownTimerLabel: UILabel!
    @IBOutlet var reSendVerifiedButton: UIButton!
    var countDownTimer:NSTimer!
    var IntCount:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        IntCount = 180
        countDownTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("handleInputPasswordTimeout:"), userInfo: nil, repeats: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func handleInputPasswordTimeout(sender: NSTimer) {
        if (IntCount > 0) {
            IntCount = IntCount - 1;
            countDownTimerLabel.text = "\(IntCount) s"
        }else{
            countDownTimer.invalidate();
            countDownTimer = nil;
            
            let alertController = UIAlertController(title: "行動電話號碼驗證失敗",
                message: "您有可能未提供正確行動電話號碼或已超過3分鐘驗證時間",
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
    
    @IBAction func startPhoneVerifiedViewController(sender: AnyObject) {
        
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let newString = (textField.text as NSString).stringByReplacingCharactersInRange(range, withString: string)
        
        if count(newString.utf16) > 0 {
            startVerifiedButton.hidden = false
        }else{
            startVerifiedButton.hidden = true
        }
        return true
    }
    
    @IBAction func startVerifiedButtonPressed(sender: AnyObject) {
        // Start activity indicator
        
        let variable = textField.text.toInt()
        
        //確認是否跟網路上儲存的一致。
        PFUser.currentUser()?.fetchInBackgroundWithBlock({ (user: PFObject?, error: NSError?) -> Void in
            if error != nil || user == nil{
                println("The get user request failed.")
            }else{
                
                if let thisVariable = user?.objectForKey("phoneCode") as? Int{
                    if thisVariable == variable {
                        
                        //一致，儲存phoneVerified，然後下一頁
                        let user:PFUser! = PFUser.currentUser()!
                        var ACL = PFACL()
                        ACL.setPublicReadAccess(true)
                        user!.ACL = ACL
                        
                        user?.setObject(true, forKey: "isPhoneVerified")
                        user?.saveInBackgroundWithBlock({ (succeeded:Bool, error:NSError?) -> Void in
                            
                        })
                        
                        //開始轉場，看要轉到哪裡去，開始填寫個人資料
                        self.performSegueWithIdentifier("wProfile", sender: self)
                    }else{
                        // Stop activity indicator
                        
                        //不一致，彈出錯誤
                        let alertController = UIAlertController(title: "驗證時發生錯誤",
                            message: "您所輸入的驗證碼不正確，請重新確認",
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
        })
    }
    
    @IBAction func reSendVerifiedButtonPressed(sender: AnyObject) {
        
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
