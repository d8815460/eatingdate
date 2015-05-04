//
//  IntroViewController.swift
//  eatClub
//
//  Created by 駿逸 陳 on 2015/4/8.
//  Copyright (c) 2015年 miiitech. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let item1 = RMParallaxItem(image: UIImage(named: "item1")!, text: "親！大家時間都寶貴 來這不瞎聊，直接約")
        let item2 = RMParallaxItem(image: UIImage(named: "item2")!, text: "24小時審核團隊，堅持對用戶照片做視頻比對")
        let item3 = RMParallaxItem(image: UIImage(named: "item3")!, text: "舌尖上的約會，惟美食和姑娘不可負也")
        
        let rmParallaxViewController = RMParallax(items: [item1, item2, item3], motion: false)
        rmParallaxViewController.completionHandler = {
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                rmParallaxViewController.view.alpha = 0.0
            })
        }
        
        // Adding parallax view controller.
        self.addChildViewController(rmParallaxViewController)
        self.view.addSubview(rmParallaxViewController.view)
        rmParallaxViewController.didMoveToParentViewController(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    
    func goToHomePage (){
        self.performSegueWithIdentifier("goHome", sender: self)
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
