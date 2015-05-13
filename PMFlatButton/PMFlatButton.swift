//
//  PMFlatButton.swift
//  OCR_demo
//
//  Created by Taku Inoue on 2015/05/12.
//  Copyright (c) 2015年 Taku Inoue. All rights reserved.
//

import UIKit

class PMFlatButton: UIView {

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: Properties
    //Public
    var lineColor : UIColor = (UIColor(red: 0.294, green: 0.431, blue: 0.988, alpha: 1.000)) {
        didSet{
            if (contentView != nil) {contentView?.layer.borderColor = lineColor.CGColor}
            if (textLabel != nil) {textLabel?.textColor = lineColor}
        }
    }
    var disableColor : UIColor = UIColor.lightGrayColor()
    var disableTextColor : UIColor = UIColor.whiteColor()
    var highlightedTextColor : UIColor = UIColor.whiteColor()
    var textLabel : UILabel?

    var highlighted : Bool = false {
        didSet{
            if (highlighted != oldValue){ reloadButtonColors() }
        }
    }

    var enabled : Bool = true {
        willSet{
            if (enabled != newValue){
                self.userInteractionEnabled = newValue
                reloadButtonColors()
            }
        }
    }

    var bulrEffect : Bool = false{
        didSet{
            setBulrEffect()
        }
    }

    //Private
    private var bulrView : UIToolbar?
    private var contentView : UIView?
    private var target : AnyObject?
    private var selector : Selector?
    private var clickHandler: (() -> Void)?

    //MARK: Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = UIColor.clearColor()
        self.alpha = 1.0

        contentView = UIView(frame: CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame)))
        contentView?.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        contentView?.backgroundColor = UIColor.clearColor()
        contentView?.layer.borderColor = lineColor.CGColor
        contentView?.layer.borderWidth = 1.0
        contentView?.layer.cornerRadius = 5.0
        contentView?.layer.masksToBounds = true
        self.addSubview(contentView!)

        textLabel = UILabel(frame: CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame)))
        textLabel?.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        textLabel?.backgroundColor = UIColor.clearColor()
        textLabel?.textColor = lineColor
        textLabel?.numberOfLines = 0
        textLabel?.textAlignment = NSTextAlignment.Center
        textLabel?.font = UIFont.systemFontOfSize(14)
        self.addSubview(textLabel!)
    }

    //MARK: Property Method


    //MARK: Class Method
    func setText(text: NSString){
        if (textLabel != nil){
            textLabel?.text = text as String
        }
    }

    func addTarget(target: AnyObject, selector: Selector){
        self.target = target;
        self.selector = selector
    }

    func addClickHandler(handler : () -> Void){
        self.clickHandler = handler
    }

    //MARK: Private Method
    private func reloadButtonColors(){
        if(enabled == true){
            contentView?.backgroundColor = (highlighted) ? lineColor : UIColor.clearColor()
            textLabel?.textColor = (highlighted) ? highlightedTextColor : lineColor
        }else{
            contentView?.backgroundColor = disableColor
            contentView?.layer.borderColor = disableColor.CGColor
            textLabel?.textColor = disableTextColor
        }
    }

    private func setBulrEffect(){
        if(bulrEffect == true){
            if (bulrView == nil){
                bulrView = UIToolbar(frame: CGRectMake(0, -1, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + 1))
                bulrView?.layer.masksToBounds = true
                bulrView?.layer.cornerRadius = 5.0
                self.addSubview(bulrView!)
                self.sendSubviewToBack(bulrView!)
            }
            bulrView?.hidden = false
            contentView?.alpha = 0.8
            textLabel?.alpha = 0.8
        }else{
            if (bulrView != nil){
                bulrView?.hidden = true
                contentView?.alpha = 1.0;
                textLabel?.alpha = 1.0;
            }
        }
    }

    //MARK: Touch Event
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        highlighted = true
    }

    override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        highlighted = false
    }

    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {

        let touch = touches.first as? UITouch

        var touchPoint : CGPoint = CGPointZero
        if let _touch = touch{
            touchPoint = _touch.locationInView(self)
        }

        if(touchPoint.x > CGRectGetWidth(self.bounds) || touchPoint.x < 0 || touchPoint.y > CGRectGetHeight(self.bounds) || touchPoint.y < 0){
            self.highlighted = false
            touchesCancelled(touches, withEvent: event)
        }
    }

    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        if (!highlighted){
            return
        }

        if (target != nil && selector != nil && target!.respondsToSelector(selector!)){
            NSThread.detachNewThreadSelector(selector!, toTarget: target!, withObject: nil)
        }

        if (clickHandler != nil){
            clickHandler!()
        }

        highlighted = false
    }
}
