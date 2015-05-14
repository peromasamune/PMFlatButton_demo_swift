//
//  ViewController.swift
//  PMFlatButton_demo_swift
//
//  Created by Taku Inoue on 2015/05/13.
//  Copyright (c) 2015年 Taku Inoue. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        var contentView : UIView = UIView(frame: CGRectMake(0, 0, 200, 230))
        contentView.backgroundColor = UIColor.clearColor()
        contentView.center = CGPointMake(CGRectGetWidth(self.view.bounds) / 2, CGRectGetHeight(self.view.bounds) / 2)
        self.view.addSubview(contentView)

        var flatButton : PMFlatButton = PMFlatButton(frame: CGRectMake(0, 0, 200, 50))
        flatButton.setText("Flat Button")
        flatButton.setClickHandler { () -> Void in
            NSLog(__FUNCTION__+" Button clicked")
        }
        contentView.addSubview(flatButton)

        var greenButton : PMFlatButton = PMFlatButton(frame: CGRectMake(0, 90, 200, 50))
        greenButton.lineColor = UIColor(red: 0.063, green: 0.525, blue: 0.459, alpha: 1.000)
        greenButton.setText("Flat Button")
        greenButton.setTarget(self, selector: "buttonDidPush:")
        contentView.addSubview(greenButton)

        var redButton : PMFlatButton = PMFlatButton(frame: CGRectMake(0, 180, 200, 50))
        redButton.lineColor = UIColor(red: 0.933, green: 0.169, blue: 0.165, alpha: 1.000)
        redButton.setText("Flat Button")
        redButton.setTarget(self, selector: "buttonDidPush:")
        contentView.addSubview(redButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func buttonDidPush(sender : AnyObject){
        NSLog(__FUNCTION__+" Button clicked")
    }


}

