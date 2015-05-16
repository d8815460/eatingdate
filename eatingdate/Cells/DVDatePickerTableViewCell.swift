//
//  DVDatePickerTableViewCell.swift
//  DVDatePickerTableViewCellDemo
//
//  Created by Dylan Vann on 2014-10-21.
//  Copyright (c) 2014 Dylan Vann. All rights reserved.
//

import Foundation
import UIKit

// DVColorLockView ovverides the backgroundColor setter for UIView so that highlighting a UITableViewCell won't change the color of its DVColorLockView subviews (Highlighting a UITableViewCell changes the background color of all subviews, it's annoying.)
class DVColorLockView:UIView {
    
    var lockedBackgroundColor:UIColor {
        set {
            super.backgroundColor = newValue
        }
        get {
            return super.backgroundColor!
        }
    }
    
    override var backgroundColor:UIColor? {
        set {
        }
        get {
            return super.backgroundColor
        }
    }
    
}

class DVDatePickerTableViewCell: UITableViewCell {
    
    var task:WriteTask!
    
    // Class variable workaround.
    struct Stored {
        static var dateFormatter = NSDateFormatter()
    }
    
    var date:NSDate = NSDate() {
        didSet {
            datePicker.date = date
            DVDatePickerTableViewCell.Stored.dateFormatter.dateStyle = dateStyle
            DVDatePickerTableViewCell.Stored.dateFormatter.timeStyle = timeStyle
            rightLabel.text = DVDatePickerTableViewCell.Stored.dateFormatter.stringFromDate(date)
            self.task.dateTime = date
            println("self.date.dateTime = \(self.task.dateTime)")
        }
    }
    var timeStyle = NSDateFormatterStyle.ShortStyle, dateStyle = NSDateFormatterStyle.ShortStyle
    
    var leftLabel = UILabel(), rightLabel = UILabel()
    var rightLabelTextColor = UIColor(hue: 0.639, saturation: 0.041, brightness: 0.576, alpha: 1.0) //Color of normal detail label.
    
    var seperator = DVColorLockView()
    
    var datePickerContainer = UIView()
    var datePicker: UIDatePicker = UIDatePicker()
    
    var expanded = false
    var unexpandedHeight = CGFloat(48)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                
        setup()
    }
    
    private func setup() {
        // The datePicker overhangs the view slightly to avoid invalid constraints.
        self.clipsToBounds = true
        
        var views = [leftLabel, rightLabel, seperator, datePickerContainer, datePicker]
        for view in views {
            self.contentView .addSubview(view)
            view.setTranslatesAutoresizingMaskIntoConstraints(false)
        }
        
        self.task = WriteTask.sharedWriteTask() as! WriteTask
        
        datePickerContainer.clipsToBounds = true
        datePickerContainer.addSubview(datePicker)
        
        // Add a seperator between the date text display, and the datePicker. Lighter grey than a normal seperator.
        seperator.lockedBackgroundColor = UIColor(white: 0, alpha: 0.1)
        datePickerContainer.addSubview(seperator)
        datePickerContainer.addConstraints([
            NSLayoutConstraint(
                item: seperator,
                attribute: NSLayoutAttribute.Left,
                relatedBy: NSLayoutRelation.Equal,
                toItem: datePickerContainer,
                attribute: NSLayoutAttribute.Left,
                multiplier: 1.0,
                constant: 0
            ),
            NSLayoutConstraint(
                item: seperator,
                attribute: NSLayoutAttribute.Right,
                relatedBy: NSLayoutRelation.Equal,
                toItem: datePickerContainer,
                attribute: NSLayoutAttribute.Right,
                multiplier: 1.0,
                constant: 0
            ),
            NSLayoutConstraint(
                item: seperator,
                attribute: NSLayoutAttribute.Height,
                relatedBy: NSLayoutRelation.Equal,
                toItem: nil,
                attribute: NSLayoutAttribute.NotAnAttribute,
                multiplier: 1.0,
                constant: 0.5
            ),
            NSLayoutConstraint(
                item: seperator,
                attribute: NSLayoutAttribute.Top,
                relatedBy: NSLayoutRelation.Equal,
                toItem: datePickerContainer,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 0
            ),
            ])
        
        
        rightLabel.textColor = rightLabelTextColor
        
        //Left label.
        self.contentView.addConstraints([
            NSLayoutConstraint(
                item: leftLabel,
                attribute: NSLayoutAttribute.Height,
                relatedBy: NSLayoutRelation.Equal,
                toItem: nil,
                attribute: NSLayoutAttribute.NotAnAttribute,
                multiplier: 1.0,
                constant: 48
            ),
            NSLayoutConstraint(
                item: leftLabel,
                attribute: NSLayoutAttribute.Top,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self.contentView,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 0
            ),
            NSLayoutConstraint(
                item: leftLabel,
                attribute: NSLayoutAttribute.Left,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self.contentView,
                attribute: NSLayoutAttribute.Left,
                multiplier: 1.0,
                constant: self.separatorInset.left
            ),
            ])
        
        //Right label
        self.contentView.addConstraints([
            NSLayoutConstraint(
                item: rightLabel,
                attribute: NSLayoutAttribute.Height,
                relatedBy: NSLayoutRelation.Equal,
                toItem: nil,
                attribute: NSLayoutAttribute.NotAnAttribute,
                multiplier: 1.0,
                constant: 48
            ),
            NSLayoutConstraint(
                item: rightLabel,
                attribute: NSLayoutAttribute.Top,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self.contentView,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 0
            ),
            NSLayoutConstraint(
                item: rightLabel,
                attribute: NSLayoutAttribute.Right,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self.contentView,
                attribute: NSLayoutAttribute.Right,
                multiplier: 1.0,
                constant: -self.separatorInset.left
            ),
            ])
        
        // Container.
        self.contentView.addConstraints([
            NSLayoutConstraint(
                item: datePickerContainer,
                attribute: NSLayoutAttribute.Left,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self.contentView,
                attribute: NSLayoutAttribute.Left,
                multiplier: 1.0,
                constant: 0
            ),
            NSLayoutConstraint(
                item: datePickerContainer,
                attribute: NSLayoutAttribute.Right,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self.contentView,
                attribute: NSLayoutAttribute.Right,
                multiplier: 1.0,
                constant: 0
            ),
            NSLayoutConstraint(
                item: datePickerContainer,
                attribute: NSLayoutAttribute.Top,
                relatedBy: NSLayoutRelation.Equal,
                toItem: leftLabel,
                attribute: NSLayoutAttribute.Bottom,
                multiplier: 1.0,
                constant: 0
            ),
            NSLayoutConstraint(
                item: datePickerContainer,
                attribute: NSLayoutAttribute.Bottom,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self.contentView,
                attribute: NSLayoutAttribute.Bottom,
                multiplier: 1.0,
                constant: 1
            ),
            ])
        
        // Picker constraints.
        datePickerContainer.addConstraints([
            NSLayoutConstraint(
                item: datePicker,
                attribute: NSLayoutAttribute.Left,
                relatedBy: NSLayoutRelation.Equal,
                toItem: datePickerContainer,
                attribute: NSLayoutAttribute.Left,
                multiplier: 1.0,
                constant: 0
            ),
            NSLayoutConstraint(
                item: datePicker,
                attribute: NSLayoutAttribute.Right,
                relatedBy: NSLayoutRelation.Equal,
                toItem: datePickerContainer,
                attribute: NSLayoutAttribute.Right,
                multiplier: 1.0,
                constant: 0
            ),
            NSLayoutConstraint(
                item: datePicker,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: datePickerContainer,
                attribute: NSLayoutAttribute.CenterY,
                multiplier: 1.0,
                constant: 0
            ),
            ])
        
        datePicker.addTarget(self, action: "datePicked", forControlEvents: UIControlEvents.ValueChanged)
        self.date = NSDate()
        
        println("datePicker mode = \(datePicker.datePickerMode)")
        if datePicker.datePickerMode == UIDatePickerMode.Date {
            leftLabel.text = "日期"
        }else if datePicker.datePickerMode == UIDatePickerMode.Time {
            leftLabel.text = "時間"
        }
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
        
        
    }
    
    func datePickerHeight() -> CGFloat {
        var expandedHeight = unexpandedHeight + CGFloat(datePicker.frame.size.height)
        return expanded ? expandedHeight : unexpandedHeight
    }
    
    func selectedInTableView(tableView: UITableView) {
        expanded = !expanded
        
        UIView.transitionWithView(rightLabel, duration: 0.25, options:UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
                self.rightLabel.textColor = self.expanded ? self.tintColor : self.rightLabelTextColor
        }, completion: nil)
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func datePicked() {
        date = datePicker.date
    }
}
