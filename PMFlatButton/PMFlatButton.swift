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

    //MARK: - Properties
    //Public
    var lineColor : UIColor = (UIColor(red: 0.294, green: 0.431, blue: 0.988, alpha: 1.000)) {
        didSet{
            contentView.layer.borderColor = lineColor.cgColor
            textLabel.textColor = lineColor
        }
    }
    var disableColor : UIColor = .lightGray
    var disableTextColor : UIColor = .white
    var highlightedTextColor : UIColor = .white
    var textLabel : UILabel!
    var borderWidth : CGFloat = 1.0
    var cornerRadius : CGFloat = 5.0

    var highlighted : Bool = false {
        didSet{
            if (highlighted != oldValue){ reloadButtonColors() }
        }
    }

    var enabled : Bool = true {
        didSet{
            if (enabled != oldValue){
                self.isUserInteractionEnabled = enabled
                reloadButtonColors()
            }
        }
    }

    //Private
    private var contentView : UIView!
    private weak var target : AnyObject?
    private var selector : Selector?
    private var clickHandler: (() -> Void)?

    //MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .clear
        self.alpha = 1.0

        contentView = UIView(frame: CGRect(x:0, y:0, width:frame.width, height:frame.height))
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.backgroundColor = .clear
        contentView.layer.borderColor = lineColor.cgColor
        contentView.layer.borderWidth = borderWidth
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.masksToBounds = true
        self.addSubview(contentView)

        textLabel = UILabel(frame: CGRect(x:0, y:0, width:frame.width, height:frame.height))
        textLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        textLabel.backgroundColor = .clear
        textLabel.textColor = lineColor
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center
        textLabel.font = UIFont.systemFont(ofSize:14)
        self.addSubview(textLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.borderWidth = borderWidth
        contentView.layer.cornerRadius = cornerRadius
    }

    //MARK: - Class Method
    func setText(_ text: NSString){
        textLabel.text = text as String
    }

    func setTarget(_ target: AnyObject, selector: Selector){
        self.target = target;
        self.selector = selector
    }

    func setClickHandler(handler : @escaping () -> Void){
        self.clickHandler = handler
    }

    //MARK: - Private Method
    private func reloadButtonColors(){
        if(enabled == true){
            contentView.backgroundColor = (highlighted) ? lineColor : .clear
            textLabel.textColor = (highlighted) ? highlightedTextColor : lineColor
        }else{
            contentView.backgroundColor = disableColor
            contentView.layer.borderColor = disableColor.cgColor
            textLabel.textColor = disableTextColor
        }
    }

    //MARK: Touch Event
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        highlighted = true
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        highlighted = false
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first

        var touchPoint : CGPoint = .zero
        if let _touch = touch{
            touchPoint = _touch.location(in: self)
        }
        
        if(touchPoint.x > self.bounds.width || touchPoint.x < 0 || touchPoint.y > self.bounds.height || touchPoint.y < 0){
            touchesCancelled(touches, with: event)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (!highlighted){
            return
        }
        
        if (target != nil && selector != nil && target!.responds(to: selector!)){
            let control : UIControl = UIControl()
            control.sendAction(selector!, to: target, for: nil)
        }
        
        if (clickHandler != nil){
            clickHandler!()
        }
        
        highlighted = false
    }
}
