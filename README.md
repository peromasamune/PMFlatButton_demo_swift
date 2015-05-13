# PMFlatButton_swift

##

![Screen1](https://github.com/peromasamune/PMFlatButton_demo_swift/blob/master/screens/screen1.png?raw=true)

swift based simple flat button

# Implementation

##

- Example

```swift
var flatButton : PMFlatButton = PMFlatButton(frame: CGRectMake(0, 0, 200, 50))
flatButton.setText("Flat Button")

//Click handler with closure
flatButton.addClickHandler { () -> Void in
    //Called when button clicked
}

//Click handler with selector
flatButton.addTarget(self, selector: "buttonDidPush:")

self.view.addSubview(flatButton)
```

- Customize

```swift
//MARK: Properties
//Public
var lineColor : UIColor = (UIColor(red: 0.294, green: 0.431, blue: 0.988, alpha: 1.000))
var disableColor : UIColor = UIColor.lightGrayColor()
var disableTextColor : UIColor = UIColor.whiteColor()
var highlightedTextColor : UIColor = UIColor.whiteColor()
var textLabel : UILabel?
var highlighted : Bool = false 
var enabled : Bool = true
```


##License
Copyright &copy; 2015 Peromasamune  
Distributed under the [MIT License][mit].
[MIT]: http://www.opensource.org/licenses/mit-license.php 