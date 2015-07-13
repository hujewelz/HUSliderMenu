//
//  HULeftMenu.swift
//  HUSliderMenu
//
//  Created by jewelz on 15/7/13.
//  Copyright (c) 2015年 yangtzeu. All rights reserved.
//

import UIKit

extension UIImage {
    class func imageWithColor(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 1.0, height: 10), false, 0.0)
        
        color.set()
        UIRectFill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 10))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image
    }
}

protocol HULeftMenuDelegate: NSObjectProtocol {
    
    func leftMenu(menu: HULeftMenu,  didSelectedItemAtIndex index: Int, toNewItem newIndex: Int)
}

protocol HULeftMenuDataSource: NSObjectProtocol {
    
    func numberOfItems() -> Int
    
    func leftMenu(menu: HULeftMenu, menuItemAtIndex index: Int) -> AnyObject
    
}

class HUMenuItenCell: UIButton {
    
    var titleLabText: String? {
        set {
            self.setTitle(newValue, forState: .Normal)
        }
        
        get {
            return self.currentTitle
        }
    }
    
    
    var image: UIImage? {
        set {
            self.setImage(newValue, forState: .Normal)
        }
        
        get {
            return self.currentImage
        }
    }
    
    var selectedBackground: UIColor? {
        set {
            self.setBackgroundImage(UIImage.imageWithColor(newValue!), forState: UIControlState.Selected)
        }
        
        get {
           return self.backgroundColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupItem()
    }
    
    func setupItem() {
        
        self.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        self.adjustsImageWhenHighlighted = false
        
        self.contentHorizontalAlignment = .Left
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class HULeftMenu: UIView {
    weak var selectedItem: UIButton!
    weak var delegate: HULeftMenuDelegate?
    weak var dataSoruce: HULeftMenuDataSource?
    
    var menuItem: UIButton?
    let ItemHeight: CGFloat = 60.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupMenuItem() -> HUMenuItenCell{
        var button = HUMenuItenCell(frame: CGRectZero)
        
//        //button.setTitle(title, forState: .Normal)
//        button.tag = self.subviews.count
//        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
//        
//        button.setBackgroundImage(self.imageWithColor(UIColor.redColor()), forState: UIControlState.Selected)
//        
//        //button.setImage(UIImage(named: imageNamed), forState: .Normal)
//        button.adjustsImageWhenHighlighted = false
//        
//        button.contentHorizontalAlignment = .Left
//        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
//        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
//        
        button.addTarget(self, action: "buttonClicked:", forControlEvents: .TouchUpInside)
        
        self.addSubview(button)
        
        
        return button
    }
    
    func menuItemAtIndex(index: Int) -> AnyObject {
        return self.subviews[index]
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let counts = self.dataSoruce?.numberOfItems() {
            for i in 0..<counts {
                self.setupMenuItem()
                var btn = self.subviews[i] as! HUMenuItenCell
                btn.tag = i
                btn.frame = CGRectMake(0, ItemHeight*CGFloat(i), self.bounds.width, ItemHeight)
                
                self.dataSoruce?.leftMenu(self, menuItemAtIndex: i)
                
            }
            selectedItem = self.subviews[0] as! HUMenuItenCell
            selectedItem.selected = true
        }
        
        
    }
    
    func buttonClicked(button: UIButton) {
        println("selected at \(button.tag)")
        selectedItem.selected = false
        
        button.selected = true
         println("old: \(selectedItem.tag), new: \(button.tag)")
        
        self.delegate?.leftMenu(self, didSelectedItemAtIndex: selectedItem.tag, toNewItem: button.tag)
       
        selectedItem = button
        
    }
    
    

}
