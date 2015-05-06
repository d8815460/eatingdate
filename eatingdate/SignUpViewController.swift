//
//  SignUpViewController.swift
//  eatClub
//
//  Created by ALEX on 2015/4/14.
//  Copyright (c) 2015年 miiitech. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var bgImageView: UIImageView!
    
    @IBOutlet var userContainer: UIView!
    @IBOutlet var userLabel: UILabel!
    @IBOutlet var userTextField: UITextField!
    @IBOutlet var userUnderline: UIView!
    
    @IBOutlet var passwordContainer: UIView!
    @IBOutlet var passwordLabel: UILabel!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var passwordUnderline: UIView!
    
    @IBOutlet var emailContainer: UIView!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var emailUnderline: UIView!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var agreeButton: UIButton!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        /*直接改PFLoginViewController
        self.signUpView?.signUpButton?.setTitle("我同意並註冊", forState: .Normal)
        self.signUpView?.usernameField?.placeholder = "行動電話"
        self.signUpView?.usernameField?.keyboardType = UIKeyboardType.PhonePad
        self.signUpView?.passwordField?.placeholder = "設定密碼"
        self.signUpView?.emailField?.placeholder = "電子信箱"
        */
        
        bgImageView.image = UIImage(named: "nav-bg-2")
        bgImageView.contentMode = .ScaleAspectFill
        
        titleLabel.text = "歡迎您加入"
        titleLabel.font = UIFont(name: MegaTheme.semiBoldFontName(), size: 45)
        titleLabel.textColor = UIColor.whiteColor()
        
        
        userContainer.backgroundColor = UIColor.clearColor()
        
        userLabel.text = "行動電話"
        userLabel.font = UIFont(name: MegaTheme.fontName(), size: 20)
        userLabel.textColor = UIColor.whiteColor()
        
        userTextField.text = ""
        userTextField.font = UIFont(name: MegaTheme.fontName(), size: 20)
        userTextField.textColor = UIColor.whiteColor()
        
        passwordContainer.backgroundColor = UIColor.clearColor()
        
        passwordLabel.text = "登入密碼"
        passwordLabel.font = UIFont(name: MegaTheme.fontName(), size: 20)
        passwordLabel.textColor = UIColor.whiteColor()
        
        passwordTextField.text = ""
        passwordTextField.font = UIFont(name: MegaTheme.fontName(), size: 20)
        passwordTextField.textColor = UIColor.whiteColor()
        passwordTextField.secureTextEntry = true
        
        emailContainer.backgroundColor = UIColor.clearColor()
        
        emailLabel.text = "電子信箱"
        emailLabel.font = UIFont(name: MegaTheme.fontName(), size: 20)
        emailLabel.textColor = UIColor.whiteColor()
        
        emailTextField.text = ""
        emailTextField.font = UIFont(name: MegaTheme.fontName(), size: 20)
        emailTextField.textColor = UIColor.whiteColor()
        emailTextField.delegate = self
        
        agreeButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        agreeButton.titleLabel?.font = UIFont(name: MegaTheme.semiBoldFontName(), size: 22)
        agreeButton.layer.borderWidth = 3
        agreeButton.layer.borderColor = UIColor.whiteColor().CGColor
        agreeButton.layer.cornerRadius = 5
        
        activityIndicator.hidden = true
        
        //Looks for single or multiple taps.
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)

    }
    
    override func viewDidLayoutSubviews() {
        /*要使用Parse提供的註冊畫面才需要修改。

        let image = UIImage(named: "nav-bg-2")
        var bgView = UIImageView(image: image)
        self.signUpView?.addSubview(bgView)
        self.signUpView?.sendSubviewToBack(bgView)
        
        //原本的位置往上移動
        let Logo_X = self.signUpView?.logo?.frame.origin.x
        let Logo_Y = self.signUpView?.logo?.frame.origin.y
        let Logo_width = self.signUpView?.logo?.frame.width
        let Logo_height = self.signUpView?.logo?.frame.height
        self.signUpView?.logo?.frame = CGRectMake(Logo_X!, Logo_Y!-150, Logo_width!, Logo_height!)
        
        let phone_X = self.signUpView?.usernameField?.frame.origin.x
        let phone_Y = self.signUpView?.usernameField?.frame.origin.y
        let phone_width = self.signUpView?.usernameField?.frame.width
        let phone_height = self.signUpView?.usernameField?.frame.height
        self.signUpView?.usernameField?.frame = CGRectMake(phone_X!, phone_Y!-150, phone_width!, phone_height!)
        
        let pw_X = self.signUpView?.passwordField?.frame.origin.x
        let pw_Y = self.signUpView?.passwordField?.frame.origin.y
        let pw_width = self.signUpView?.passwordField?.frame.width
        let pw_height = self.signUpView?.passwordField?.frame.height
        self.signUpView?.passwordField?.frame = CGRectMake(pw_X!, pw_Y!-150, pw_width!, pw_height!)
        
        let em_X = self.signUpView?.emailField?.frame.origin.x
        let em_Y = self.signUpView?.emailField?.frame.origin.y
        let em_width = self.signUpView?.emailField?.frame.width
        let em_height = self.signUpView?.emailField?.frame.height
        self.signUpView?.emailField?.frame = CGRectMake(em_X!, em_Y!-150, em_width!, em_height!)
        
        let s_X = self.signUpView?.signUpButton?.frame.origin.x
        let s_Y = self.signUpView?.signUpButton?.frame.origin.y
        let s_width = self.signUpView?.signUpButton?.frame.width
        let s_height = self.signUpView?.signUpButton?.frame.height
        self.signUpView?.signUpButton?.frame = CGRectMake(s_X!, s_Y!-150, s_width!, s_height!)
        
        
        let t_X:CGFloat = 20
        let t_Y:CGFloat = s_Y! - 80
        let t_width:CGFloat = self.view.frame.width - 40
        let t_height:CGFloat = self.view.frame.height - Logo_height! - phone_height! - pw_height! - em_height! - s_height!
        
        var textcontent = UITextView(frame: CGRectMake(t_X, t_Y, t_width, t_height))
        textcontent.text = "1.註冊會員需年滿20歲（含）以上之單身未婚男女。\n2.透過此平台約會時，進行詐騙、援交、性騷擾等任何不合法之事項，APP會強制要求賠償100萬。\n3.APP採實名制，所有會員都須完成身份證驗證。\n4.此平台聘請建業律師事務所為法律顧問。"
        textcontent.textContainer.lineFragmentPadding = 5 //行距離左邊的距離
        textcontent.textContainerInset = UIEdgeInsetsMake(5, 5, 5, 5) //理解内容到边框的距离
        textcontent.editable = false
        textcontent.selectable = false //设置为True时,链接可以点击
        textcontent.scrollEnabled = false
        textcontent.font = UIFont(name: MegaTheme.fontName, size: 16)
        textcontent.textColor = UIColor.whiteColor()
        textcontent.backgroundColor = UIColor.clearColor()
        
        self.signUpView?.addSubview(textcontent)
        */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Calls this function when the tap is recognized.
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func dismissButtonPressed(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    //email鍵盤按下Go == 按下同意按鈕註冊
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.signUpWithUsernameAndPasswordPressed(self)
        return true
    }

    //MARK: - 註冊功能
    @IBAction func signUpWithUsernameAndPasswordPressed(sender: AnyObject) {
        if count(userTextField.text!) > 10 || count(userTextField.text!) < 10 || !userTextField.text.hasPrefix("09"){
            let alertController = UIAlertController(title: "註冊時發生錯誤",
                message: "行動電話格式錯誤",
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
        
        
        // Build the terms and conditions alert
        let alertController = UIAlertController(title: "同意的條款和條件",
            message: "點擊我同意以表示您同意最終用戶許可協議。",
            preferredStyle: UIAlertControllerStyle.Alert
        )
        alertController.addAction(UIAlertAction(title: "我同意",
            style: UIAlertActionStyle.Default,
            handler: { alertController in self.processSignUp()})
        )
        alertController.addAction(UIAlertAction(title: "我不同意",
            style: UIAlertActionStyle.Default,
            handler: nil)
        )
        
        // Display alert
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func processSignUp(){
//        self.signUpView?.signUpButton?.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
        /* 自訂的UI才有 emailTextField
        */
        if emailTextField.text.isEmpty {
            let alertController = UIAlertController(title: "註冊時發生錯誤",
                message: "電子信箱忘記填寫",
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

        
        var user = PFUser()
        user.username = userTextField.text
        user.password = passwordTextField.text
        //確保電子郵件都是小寫
        var userEmailAddress = emailTextField.text
        userEmailAddress = userEmailAddress.lowercaseString
        user.email = userEmailAddress
        //因為Facebook註冊登錄，預設user欄位不是電話號碼，所以得另外存一個phone
        user["phone"] = userTextField.text
        
        // Start activity indicator
        activityIndicator.hidden = false
        activityIndicator.startAnimating()
        
        user.signUpInBackgroundWithBlock { (succeeded: Bool, error: NSError?) -> Void in
            if error == nil {
                //註冊成功，讓我們開始使用這個App吧
                
                //開始轉場，看要轉到哪裡去，填寫基本資料
                self.performSegueWithIdentifier("wProfile", sender: self)
            }else{
                
                self.activityIndicator.stopAnimating()
                self.activityIndicator.hidden = true
                
                if let message: AnyObject = error!.userInfo!["error"] {
                    let alertController = UIAlertController(title: "註冊時發生錯誤",
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
        }
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
