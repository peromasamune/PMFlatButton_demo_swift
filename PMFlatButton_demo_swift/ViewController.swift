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

        let contentView : UIView = UIView(frame: CGRect(x:0, y:0, width:200, height:230))
        contentView.backgroundColor = .clear
        contentView.center = CGPoint(x:self.view.frame.width / 2, y:self.view.frame.height / 2)
        self.view.addSubview(contentView)

        let flatButton : PMFlatButton = PMFlatButton(frame: CGRect(x:0, y:0, width:200, height:50))
        flatButton.setText("Flat Button")
        flatButton.setClickHandler { () -> Void in
            print(#function+" Button clicked")
        }
        contentView.addSubview(flatButton)

        let greenButton : PMFlatButton = PMFlatButton(frame: CGRect(x:0, y:90, width:200, height:50))
        greenButton.lineColor = UIColor(red: 0.063, green: 0.525, blue: 0.459, alpha: 1.000)
        greenButton.setText("Flat Button")
        greenButton.setTarget(self, selector: #selector(buttonDidPush(sender:)))
        contentView.addSubview(greenButton)

        let redButton = PMFlatButton(frame: CGRect(x:0, y:180, width:200, height:50))
        redButton.lineColor = UIColor(red: 0.933, green: 0.169, blue: 0.165, alpha: 1.000)
        redButton.setText("Flat Button")
        redButton.setTarget(self, selector: #selector(buttonDidPush(sender:)))
        contentView.addSubview(redButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @objc func buttonDidPush(sender : AnyObject){
        print(#function+" Button clicked")
    }
}

