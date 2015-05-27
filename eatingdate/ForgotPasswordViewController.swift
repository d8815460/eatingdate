//
//  ForgotPasswordViewController.swift
//  eatClub
//
//  Created by 駿逸 陳 on 2015/4/15.
//  Copyright (c) 2015年 miiitech. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var bgImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dissmissButton: UIButton!
    
    @IBOutlet var emailContainer: UIView!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var emailUnderline: UIView!
    
    @IBOutlet var okButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        bgImageView.image = UIImage(named: "nav-bg-2")
        bgImageView.contentMode = .ScaleAspectFill
        
        titleLabel.text = "請輸入您註冊的電子信箱"
        titleLabel.font = UIFont(name: MegaTheme.semiBoldFontName(), size: 30)
        titleLabel.textColor = UIColor.whiteColor()
        
        dissmissButton.addTarget(self, action: "dismiss", forControlEvents: .TouchUpInside)
        
        // Do any additional setup after loading the view.
        
        emailContainer.backgroundColor = UIColor.clearColor()
        
        emailLabel.text = "電子信箱"
        emailLabel.font = UIFont(name: MegaTheme.fontName(), size: 20)
        emailLabel.textColor = UIColor.whiteColor()
        
        emailTextField.text = ""
        emailTextField.font = UIFont(name: MegaTheme.fontName(), size: 20)
        emailTextField.textColor = UIColor.whiteColor()
        emailTextField.delegate = self
        emailTextField.becomeFirstResponder()
        
        okButton.setTitle("確定", forState: .Normal)
        okButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        okButton.titleLabel?.font = UIFont(name: MegaTheme.semiBoldFontName(), size: 22)
        okButton.layer.borderWidth = 3
        okButton.layer.borderColor = UIColor.whiteColor().CGColor
        okButton.layer.cornerRadius = 5
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //返回上一頁，登錄畫面
    func dismiss(){
        /*dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })*/
        
        self.navigationController?.popViewControllerAnimated(true)

    }
    
    //密碼鍵盤按下Go == 按下登錄按鈕
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.okButtonPressed(self)
        return true
    }
    
    @IBAction func okButtonPressed(sender: AnyObject) {
        emailTextField.resignFirstResponder()
        //開始進入忘記密碼流程，主要發送變更密碼email
        var userEmailAddress = emailTextField.text
        userEmailAddress = userEmailAddress.lowercaseString
        PFUser.requestPasswordResetForEmailInBackground(userEmailAddress, block: { (succeed, error: NSError?) -> Void in
            if succeed {
                let alertController = UIAlertController(title: "變更密碼函已寄送",
                    message: "請至信箱收取變更密碼函",
                    preferredStyle: UIAlertControllerStyle.Alert
                )
                alertController.addAction(UIAlertAction(title: "確定",
                    style: UIAlertActionStyle.Default,
                    handler: { alertController in self.dismiss()})
                )
                // Display alert
                self.presentViewController(alertController, animated: true, completion: nil)
            }else{
                if let message: AnyObject = error!.userInfo!["error"] {
                    let alertController = UIAlertController(title: "發生錯誤",
                        message: message as? String,
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
