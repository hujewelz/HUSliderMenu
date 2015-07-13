//
//  HULeftMenu.swift
//  HUSliderMenu
//
//  Created by jewelz on 15/7/13.
//  Copyright (c) 2015年 yangtzeu. All rights reserved.
//

import UIKit

protocol HULeftMenuDelegate: NSObjectProtocol {
    
    func numberOfItems() -> Int
    
    func leftMenu(menu: HULeftMenu, menuItemAtIndex index: Int)
    
    func leftMenu(menu: HULeftMenu,  didSelectedItemAtIndex index: Int, toNewItem newIndex: Int)
}

protocol HULeftMenuDataSource: NSObjectProtocol {
    
    func numberOfItems() -> Int
    
    func leftMenu(menu: HULeftMenu, menuItemAtIndex index: Int)
    
}

class HULeftMenu: UIView {
    weak var selectedItem: UIButton!
    weak var delegate: HULeftMenuDelegate!
    weak var dataSoruce: HULeftMenuDataSource!
    
    let ItemHeight: CGFloat = 60.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        
        selectedItem = setupMenuItemWithTitle("收藏", imageNamed: "btn_save")
        //self.buttonClicked(selectedItem)
        selectedItem.selected = true
       
        
        setupMenuItemWithTitle("赞一个", imageNamed: "btn_support")
        setupMenuItemWithTitle("分享", imageNamed: "btn_share")
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupMenuItemWithTitle(title: String, imageNamed: String) -> UIButton{
        var button = UIButton.buttonWithType(.Custom) as! UIButton
        button.setTitle(title, forState: .Normal)
        button.tag = self.subviews.count
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        button.setBackgroundImage(self.imageWithColor(UIColor.redColor()), forState: UIControlState.Selected)
        
        button.setImage(UIImage(named: imageNamed), forState: .Normal)
        button.adjustsImageWhenHighlighted = false
        
        button.contentHorizontalAlignment = .Left
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        
        button.addTarget(self, action: "buttonClicked:", forControlEvents: .TouchUpInside)
        
        self.addSubview(button)
        
        return button
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let counts = self.subviews.count
        
        for i in 0..<counts {
            var btn = self.subviews[i] as! UIButton
            btn.frame = CGRectMake(0, ItemHeight*CGFloat(i), self.bounds.width, ItemHeight)
            
            
        }
    }
    
    func buttonClicked(button: UIButton) {
        selectedItem.selected = false
        
        button.selected = true
         println("old: \(selectedItem.tag), new: \(button.tag)")
        
        self.delegate.leftMenu(self, didSelectedItemAtIndex: selectedItem.tag, toNewItem: button.tag)
       
        selectedItem = button
        
    }
    
    func imageWithColor(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 1.0, height: ItemHeight), false, 0.0)
        
        color.set()
        UIRectFill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: ItemHeight))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image
    }

}
