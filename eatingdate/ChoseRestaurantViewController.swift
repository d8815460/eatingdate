//
//  ChoseRestaurantViewController.swift
//  eatingdate
//
//  Created by 駿逸 陳 on 2015/5/10.
//  Copyright (c) 2015年 駿逸 陳. All rights reserved.
//

import Foundation
import UIKit

class ChoseRestaurantViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var categoryLayout: UICollectionViewFlowLayout!
    
    @IBOutlet weak var viewForTableView: UIView!
    
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
        var categoryTable = self.storyboard?.instantiateViewControllerWithIdentifier("categoryRestaurantTable") as! CategoryRestaurantTableViewController
        viewForTableView.addSubview(categoryTable.view)
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
