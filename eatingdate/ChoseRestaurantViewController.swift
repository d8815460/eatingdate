//
//  ChoseRestaurantViewController.swift
//  eatingdate
//
//  Created by 駿逸 陳 on 2015/5/10.
//  Copyright (c) 2015年 駿逸 陳. All rights reserved.
//

import Foundation
import UIKit

class ChoseRestaurantViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDelegate {
    
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var categoryButton: UIButton!
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var categoryLayout: UICollectionViewFlowLayout!
    
    @IBOutlet weak var viewForTableView: UIView!
    
    var task:WriteTask!
    var categoryTable:CategoryRestaurantTableViewController!
    let mainStoryboard:UIStoryboard! = UIStoryboard(name: "Main", bundle: nil)
    var hotRestaurantTable:HotRestaurantTableViewController!
    var myRestaurantTable:MyRestaurantTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        categoriesForRestaurant = ["日式料理", "中式料理", "亞洲料理", "異國料理", "主題特色餐廳", "燒烤類", "鍋類", "Buffet自助", "速食料理", "素食", "小吃", "烘培甜點零食", "冰品飲料甜湯", "咖啡簡餐茶", "早餐", "其他"]
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.backgroundColor = UIColor.clearColor()
        
        //iphone5 以下的螢幕(寬320)，90
        //iphone6 的螢幕(寬)，110
        //iPhone6 plus 以上的螢幕，110 OK
        if CMUtility.windowWidth() <= 320 {
            categoryLayout.itemSize = CGSizeMake(90, 44)
        }else{
            categoryLayout.itemSize = CGSizeMake(110, 44)
        }
        categoryLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        categoryLayout.minimumInteritemSpacing = 5
        categoryLayout.minimumLineSpacing = 10
        categoryLayout.scrollDirection == UICollectionViewScrollDirection.Horizontal
        
        self.task = WriteTask.sharedWriteTask() as! WriteTask
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if collectionView == categoryCollectionView {
            let cell:RestaurantCategoryCell! = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! RestaurantCategoryCell
            var category:NSString! = categoriesForRestaurant.objectAtIndex(indexPath.row) as! NSString
            cell.categoryLabel.text = "\(category)"
            
            return cell;
        }else{
            var cell:RestaurantCategoryCell! = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! RestaurantCategoryCell
            var category:NSString! = categoriesForRestaurant.objectAtIndex(indexPath.row) as! NSString
            cell.categoryLabel.layer.cornerRadius = 5
            cell.categoryLabel.text = "\(category)"
            
            return cell;
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionView {
            return categoriesForRestaurant.count
        }else{
            return categoriesForRestaurant.count
        }
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        println("select \(indexPath.row)")
        
        //選擇否個類別之後，就隱藏colllectionView
        categoryCollectionView.hidden = true
        
        //然後已經有 categoryTable 就直接顯示，並隱藏其他的tableview
        if self.categoryTable != nil {
            self.categoryTable.view.hidden = false
        }else{
            self.loadPostsTableViewController()
        }
        if self.hotRestaurantTable != nil {
            self.hotRestaurantTable.view.hidden = true
        }
        if self.myRestaurantTable != nil {
            self.myRestaurantTable.view.hidden = true
        }
    }
    
    @IBAction func categoryButtonPressed(sender: AnyObject) {
        self.categoryCollectionView.hidden = false   //顯示類別
        
        println("self.view.subviews = \(self.view.subviews[0].subviews)")
        if self.categoryTable != nil {
            self.categoryTable.view.hidden = true
        }
//        self.view.subviews[0].bringSubviewToFront(self.categoryCollectionView)
        self.segmentedControl.selectedSegmentIndex = 0
        self.tabBarButtonPressed(self.segmentedControl)
    }
    
    
    func loadPostsTableViewController () {
        // add the posts tableview as a subview with view containment
        self.categoryTable = mainStoryboard.instantiateViewControllerWithIdentifier("categoryRestaurantTable") as! CategoryRestaurantTableViewController
        self.categoryTable.view.frame = CGRectMake(0.0, 0.0, self.viewForTableView.frame.size.width, self.viewForTableView.frame.size.height)
        
        self.viewForTableView.addSubview(self.categoryTable.view)
        self.addChildViewController(self.categoryTable)
        self.categoryTable.didMoveToParentViewController(self)
    }
    
    func loadHotRestaurantTableViewController () {
        self.hotRestaurantTable = mainStoryboard.instantiateViewControllerWithIdentifier("hotRestaurant") as! HotRestaurantTableViewController
        self.hotRestaurantTable.view.frame = CGRectMake(0.0, 0.0, self.viewForTableView.frame.size.width, self.viewForTableView.frame.size.height)
        self.viewForTableView.addSubview(self.hotRestaurantTable.view)
        self.addChildViewController(self.hotRestaurantTable)
        self.hotRestaurantTable.didMoveToParentViewController(self)
    }
    
    func loadMyRestaurantTableViewController () {
        self.myRestaurantTable = mainStoryboard.instantiateViewControllerWithIdentifier("myRestaurant") as! MyRestaurantTableViewController
        self.myRestaurantTable.view.frame = CGRectMake(0.0, 0.0, self.viewForTableView.frame.size.width, self.viewForTableView.frame.size.height)
        self.viewForTableView.addSubview(self.myRestaurantTable.view)
        self.addChildViewController(self.myRestaurantTable)
        self.myRestaurantTable.didMoveToParentViewController(self)
    }
    
    @IBAction func tabBarButtonPressed(sender: UISegmentedControl) {
        println("dateTypeSet = \(sender.selectedSegmentIndex)")
        if sender.selectedSegmentIndex == 1 {
            self.categoryButton.hidden = false
            categoryCollectionView.hidden = true
        
            println("self.hotRestaurantTable = \(self.hotRestaurantTable)")
            //隱藏其他的tableview
            if self.categoryTable != nil {
                self.categoryTable.view.hidden = true
            }
            if self.hotRestaurantTable != nil {
                self.hotRestaurantTable.view.hidden = false
            }else{
                self.loadHotRestaurantTableViewController()
            }
            if self.myRestaurantTable != nil {
                self.myRestaurantTable.view.hidden = true
            }
        
        }else if sender.selectedSegmentIndex == 2 {
            self.categoryButton.hidden = false
            categoryCollectionView.hidden = true
            
            println("self.myRestaurantTable = \(self.myRestaurantTable)")
            //隱藏其他的tableview
            if self.categoryTable != nil {
                self.categoryTable.view.hidden = true
            }
            if self.hotRestaurantTable != nil {
                self.hotRestaurantTable.view.hidden = true
            }
            if self.myRestaurantTable != nil {
                self.myRestaurantTable.view.hidden = false
            }else{
                self.loadMyRestaurantTableViewController()
            }
        }else{
            self.categoryButton.hidden = false
            categoryCollectionView.hidden = false   //顯示類別
            //隱藏其他的tableview
            
            println("self.categorytable = \(self.categoryTable)")
            if self.categoryTable != nil {
                self.categoryTable.view.hidden = true
            }else{
                self.loadPostsTableViewController()
            }
            if self.hotRestaurantTable != nil {
                self.hotRestaurantTable.view.hidden = true
            }
            if self.myRestaurantTable != nil {
                self.myRestaurantTable.view.hidden = true
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
