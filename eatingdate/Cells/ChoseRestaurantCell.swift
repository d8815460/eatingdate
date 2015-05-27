//
//  ChoseRestaurantCell.swift
//  eatingdate
//
//  Created by 駿逸 陳 on 2015/5/12.
//  Copyright (c) 2015年 駿逸 陳. All rights reserved.
//

import UIKit


protocol ChoseRestaurantCellDelegate {
    func didSelectedRestaurant()
}

class ChoseRestaurantCell: PFTableViewCell {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var iconLocal: UIImageView!
    @IBOutlet weak var localLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var minCostLabel: UILabel!
    @IBOutlet weak var choseButton: UIButton!
    var administrativeArea: UILabel! = UILabel()
    var city: UILabel! = UILabel()
    
    
    var task:WriteTask!
    var restaurantObject:PFObject!
    var delegate:ChoseRestaurantCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.task = WriteTask.sharedWriteTask() as? WriteTask
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func selectButtonPressed(sender: AnyObject) {
        println("我選了這一家")
        
        self.task.restaurant            = self.restaurantObject
        self.task.restaurantAddress     = self.restaurantObject["address"] as! String
        self.task.restaurantGeo         = self.restaurantObject["geo"]  as! PFGeoPoint
        self.task.restaurantCategory    = self.restaurantObject["category"] as! PFObject
        self.task.restaurantMinCost     = self.restaurantObject["minCost"]  as! String
        self.task.restaurantName        = self.restaurantObject["name"] as! String
        self.task.restaurantPhone       = self.restaurantObject["phone"] as! String
        self.task.administrativeArea    = self.restaurantObject["administrativeArea"] as! String
        self.task.city                  = self.restaurantObject["city"] as! String
        
        delegate?.didSelectedRestaurant()
    }
}
