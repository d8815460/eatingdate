//
//  SettingPostTitleViewController.swift
//  eatingdate
//
//  Created by 駿逸 陳 on 2015/5/12.
//  Copyright (c) 2015年 駿逸 陳. All rights reserved.
//

import UIKit

class SettingPostTitleViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var textView2: UITextView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var doneButton: UIButton!
    var task:WriteTask!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.doneButton.setTitle("完成", forState: UIControlState.Normal)
        
        self.textView2.delegate = self
        
        //暫存的約會任務單
        self.task = WriteTask.sharedWriteTask() as! WriteTask
        
        if self.task.dateTitle != nil {
            placeholderLabel.hidden = true
            self.textView2.text = self.task.dateTitle
        }
        
        self.textView2.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        var string:NSString! = textView.text
        var newText:NSString! = string.stringByReplacingCharactersInRange( range, withString: text)
        
        println("newtext = \(newText)")
        
        let tallerSize:CGSize! = CGSizeMake(textView.frame.width-15.0, textView.frame.height*2)
        
        let boundingRect = newText.boundingRectWithSize(tallerSize, options:  NSStringDrawingOptions.TruncatesLastVisibleLine | NSStringDrawingOptions.UsesLineFragmentOrigin, attributes:nil, context:nil)
        
        var newSize = boundingRect.size
        
        if newSize.height > textView.frame.size.height {
            return false
        }else{
            if newText.hasPrefix("\n") {
                if ( newSize.height + textView.font.lineHeight ) > textView.frame.size.height {
                    textView.resignFirstResponder()
                    return false
                }
            }else{
                if newText.length > 0 {
                    placeholderLabel.hidden = true
                }else{
                    placeholderLabel.hidden = false
                }
            }
            return true
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        //中文字最後得儲存這裡的文字，所以通一都在這裡儲存
        
        if textView.text.isEmpty {
            
        }else{
            self.task.dateTitle = textView.text
            println("儲存 \(self.task)")
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

    @IBAction func doneButtonPressed(sender: AnyObject) {
        //縮小鍵盤，並返回
        self.view.endEditing(true)
        self.navigationController?.popViewControllerAnimated(true)
    }
}
