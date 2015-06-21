//
//  RestaurantDetailTableViewController.swift
//  eatingdate
//
//  Created by 駿逸 陳 on 2015/6/21.
//  Copyright (c) 2015年 駿逸 陳. All rights reserved.
//

import UIKit

class RestaurantDetailTableViewController: ParallaxTableViewController {

    var detailItem:AnyObject!
    var Geo:PFGeoPoint!
    
    //取得用戶的經緯座標
    var manager: OneShotLocationManager?
    
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
        
        //Query restaurant photo
        var queryPhoto:PFQuery! = PFQuery(className: "RestaurantPhotoLibrary")
        queryPhoto.whereKey("restaurant", equalTo: detailItem?[kDateRestaurant]! as! PFObject)
        queryPhoto.findObjectsInBackgroundWithBlock { (photos, error) -> Void in
            let photoarray:NSArray = (photos! as NSArray)
            let photoObj:PFObject = photoarray.objectAtIndex(0) as! PFObject
            let photoFile:PFFile = photoObj["picMedium"] as! PFFile
            
            photoFile.getDataInBackgroundWithBlock({ (photodata, error) -> Void in
                if error == nil {
                     self.imageView.image = UIImage(data: photodata!)
                }
            })
        }
        
        manager = OneShotLocationManager()
        manager?.fetchWithCompletion({ (location, error) -> () in
            if let loc = location {
                self.Geo = PFGeoPoint(location: loc)
            } else if let err = error {
                println("\(error?.localizedDescription)")
            }
        })
        
        // Set the image:
        self.imageView.image = UIImage(named: "image.jpg")
        
        // Set the appearance of the tableView
        self.view.backgroundColor = UIColor.blackColor()
        self.tableView.separatorColor = UIColor(white: 0.25, alpha: 1)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func queryForTable() -> PFQuery {
        var resQuery:PFQuery! = PFQuery(className: "Restaurant")
        
        println(" restaurant = \(detailItem?[kDateRestaurant]! as! PFObject)")
        resQuery.whereKey(kDateRestaurant, equalTo: detailItem?[kDateRestaurant]! as! PFObject)
        
        return resQuery
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 5
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell!
        var cell2:MapCell!
        var cell3:commentCell!
        
        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCellWithIdentifier("BasicCell", forIndexPath: indexPath) as! UITableViewCell
        } else if indexPath.row == 1 {
            cell = tableView.dequeueReusableCellWithIdentifier("BasicCell", forIndexPath: indexPath) as! UITableViewCell
        } else if indexPath.row == 2 {
            cell2 = tableView.dequeueReusableCellWithIdentifier("mapCell", forIndexPath: indexPath) as! MapCell
        }else if indexPath.row == 3 || indexPath.row == 4{
            cell3 = tableView.dequeueReusableCellWithIdentifier("commentCell", forIndexPath: indexPath) as! commentCell
        }
        
        
        
        let restaurantObj:PFObject = detailItem?[kDateRestaurant]! as! PFObject
        
        
        if indexPath.row == 0 {
            if let name:String = restaurantObj["name"] as? String {
                cell.textLabel?.text = "\(name)"
//                cell.detailTextLabel?.text = "\(phoneNumber)"
            }
        } else if indexPath.row == 1 {
            if let phoneNumber:String = restaurantObj["phone"] as? String {
                cell.textLabel?.text = "電話"
                cell.detailTextLabel?.text = "\(phoneNumber)"
            }
        } else if indexPath.row == 2 {
            //地址
            cell2.titleLabel?.text = "地址"
            if let res:String! = detailItem?[kDateRestaurantAddress] as? String {
                cell2.detailLabel?.text = res!
            }
            
            //1
            let rGeo = detailItem?[kDateRestaurantGeo] as! PFGeoPoint
            let RestaurantLocation = CLLocationCoordinate2D(latitude: rGeo.latitude, longitude: rGeo.longitude)
            //2
            let span = MKCoordinateSpanMake(0.01, 0.01)
            let region = MKCoordinateRegionMake(RestaurantLocation, span)
            cell2.map.setRegion(region, animated: true)
            
            //3
            let annotation = MKPointAnnotation()
            annotation.coordinate = RestaurantLocation
            
            if let res:String! = detailItem?[kDateRestaurantPhone] as? String {
                annotation.title = res!
            }
            cell2.map.addAnnotation(annotation)
            
            //距離你多遠
            let caseLoc:CLLocation = CLLocation(latitude: rGeo.latitude, longitude: rGeo.longitude)
            if self.Geo != nil {
                let userLoc:CLLocation = CLLocation(latitude: self.Geo.latitude, longitude: self.Geo.longitude)
                let mLabel = userLoc.distanceFromLocation(caseLoc)
                cell2.distanceLabel.text = String(format:"%.0fm", mLabel)
            }else{
                cell2.distanceLabel.text = "無法取得用戶位置"
            }
            
            return cell2
        } else if indexPath.row == 3 || indexPath.row == 4{
            
            return cell3
        }
        
        
        // Configure the cell...

        return cell
    }

    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 105
        } else if indexPath.row == 2 {
            return 213
        } else {
            return 48
        }
    }

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
