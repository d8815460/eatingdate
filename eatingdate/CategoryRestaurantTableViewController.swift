//
//  CategoryRestaurantTableViewController.swift
//  eatingdate
//
//  Created by 駿逸 陳 on 2015/5/10.
//  Copyright (c) 2015年 駿逸 陳. All rights reserved.
//

import UIKit

class CategoryRestaurantTableViewController: PFQueryTableViewController, UISearchBarDelegate, ChoseRestaurantCellDelegate{

    @IBOutlet weak var searchBar: UISearchBar!
    var keywork: String!
    
    // Initialise the PFQueryTable tableview
    override init(style: UITableViewStyle, className: String?) {
        super.init(style: style, className: className)
        
        // Configure the PFQueryTableView
        self.parseClassName = "Restaurant"
        self.textKey = "text"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
        self.loadingViewEnabled = false
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Configure the PFQueryTableView
        self.parseClassName = "Restaurant"
        self.textKey = "text"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
        self.loadingViewEnabled = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        
        self.searchBar.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Search Bar Delegate
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.keywork = nil
        searchBar.showsCancelButton = false
        self.view.endEditing(true)
        self.loadObjects()
    }
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.keywork = searchBar.text
        searchBar.showsCancelButton = false
        self.view.endEditing(true)
        
        //開始搜尋關鍵字
        self.loadObjects()
    }
    
    
    
    // MARK: - Table view data source

    // Define the query that will provide the data for the table view
    override func queryForTable() -> PFQuery {
        let query = PFQuery(className: self.parseClassName!)
        query.includeKey("category")
        query.includeKey("photoLibrary")
        if self.objects?.count == 0 {
            
        }else{
            query.fromLocalDatastore()
        }
        query.orderByAscending("createdAt")
        if keywork != nil {
            println("有搜尋到嗎")
            query.whereKey("name", containsString: keywork)
        }
        return query
    }
    
    override func objectsDidLoad(error: NSError?) {
        self.loadingViewEnabled = false
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        
//        println("objects = \(self.objects)")
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        let cell:ChoseRestaurantCell = tableView.dequeueReusableCellWithIdentifier("restaurantCell", forIndexPath: indexPath) as! ChoseRestaurantCell
       
        // Extract values from the PFObject to display in the table cell
        if let nameRestaurant = object?["name"] as? String {
            cell.nameLabel.text = nameRestaurant
        }
        if let address = object?["address"] as? String {
            cell.addressLabel.text = address
        }
        if let category = object?["category"] as? PFObject {
            cell.categoryLabel.text = category["categoryName"] as? String
        }
        if let popularity = object?["popularity"] as? NSNumber {
            cell.popularityLabel.text = "人氣 \(popularity)"
        }
        if let geo = object?["geo"] as? PFGeoPoint {
            cell.localLabel.text = "距離"
        }
        if let miniCost = object?["minCost"] as? String {
            cell.minCostLabel.text = "最低消費 \(miniCost)"
        }
        if let administrativeArea = object?["administrativeArea"] as? String {
            cell.administrativeArea.text = "\(administrativeArea)"
        }
        if let city = object?["city"] as? String {
            cell.city.text = "\(city)"
        }
        
        // Configure the cell...
        //確認餐廳的照片
        var photosquery:PFQuery! = PFQuery(className: "RestaurantPhotoLibrary")
        photosquery.whereKey("restaurant", equalTo: object!)
        photosquery.getFirstObjectInBackgroundWithBlock { (photos, error) -> Void in
            let imageView:UIImageView = cell.viewWithTag(1) as! UIImageView
            if let picProfilePhotoFile: PFFile! = photos?[kDatePicSmall] as? PFFile {
                if picProfilePhotoFile != nil {
                    picProfilePhotoFile?.getDataInBackgroundWithBlock({ (imageDate, error:NSError?) -> Void in
                        if error != nil {
                            
                        }else{
                            cell.photo.image = UIImage(data: imageDate!)
                            cell.photo.layer.cornerRadius = 42
                        }
                    })
                }
            }
        }
        
    
//        let photoLibrary:PFObject = object?["photoLibrary"] as! PFObject
//        
//        let imageView:UIImageView = cell.viewWithTag(1) as! UIImageView
//        if let picProfilePhotoFile: PFFile! = photoLibrary[kDatePicSmall] as? PFFile {
//            if picProfilePhotoFile != nil {
//                picProfilePhotoFile?.getDataInBackgroundWithBlock({ (imageDate, error:NSError?) -> Void in
//                    if error != nil {
//                        
//                    }else{
//                        cell.photo.image = UIImage(data: imageDate!)
//                        cell.photo.layer.cornerRadius = 42
//                    }
//                })
//            }
//        }
        
        cell.choseButton.setTitle("選這家", forState: UIControlState.Normal)
        cell.delegate = self
        cell.restaurantObject = object
        // Configure the cell...
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func didSelectedRestaurant() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("restaurantCell", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }*/

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
