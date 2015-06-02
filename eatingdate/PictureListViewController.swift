//
//  PictureListViewController.swift
//  eatingdate
//
//  Created by 駿逸 陳 on 2015/5/24.
//  Copyright (c) 2015年 駿逸 陳. All rights reserved.
//

import UIKit

class PictureListViewController: UIViewController {

    @IBOutlet weak var contentViewForTable: UIView!
    @IBOutlet weak var postDateButton: UIButton!
    
    var mainTable:MainPostDateTableViewController!
    let mainStoryboard:UIStoryboard! = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.mainTable = mainStoryboard.instantiateViewControllerWithIdentifier("mainTable") as! MainPostDateTableViewController
        self.mainTable.view.frame = CGRectMake(0.0, 0.0, self.contentViewForTable.frame.size.width, self.contentViewForTable.frame.size.height)
        
        self.contentViewForTable.addSubview(self.mainTable.view)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func postDateButtonPressed(sender: AnyObject) {
        let userCurrent = PFUser.currentUser()
        if userCurrent != nil {
            self.performSegueWithIdentifier("showPost", sender: self)
        }else {
            self.performSegueWithIdentifier("signIn", sender: self)
        }
        
    }
}
