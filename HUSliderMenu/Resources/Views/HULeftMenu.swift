//
//  HULeftMenu.swift
//  HUSliderMenu
//
//  Created by jewelz on 15/7/13.
//  Copyright (c) 2015年 yangtzeu. All rights reserved.
//

import UIKit


@objc protocol HULeftMenuDelegate: NSObjectProtocol {
    
    func leftMenu(menu: HULeftMenu,  didSelectedItemAtIndex index: Int, toNewItem newIndex: Int)
  
    optional func footerViewForLeftMenu(menu: HULeftMenu) -> UIView?
    
    optional func headerViewForLeftMenu(menu: HULeftMenu) -> UIView?
    
    
}

protocol HULeftMenuDataSource: NSObjectProtocol {
    
    func numberOfItems() -> Int
    
    func leftMenu(menu: HULeftMenu, menuItemAtIndex index: Int) -> AnyObject
    
}


class HULeftMenu: UIView {
    
    weak var selectedItem: UIButton!
    weak var delegate: HULeftMenuDelegate?
    weak var dataSoruce: HULeftMenuDataSource?
    
    var headerView: UIView?
    var footerView: UIView!
    
   // var menuItem: UIButton?
    
    let sHeight = UIScreen.mainScreen().bounds.height
    let scale: CGFloat = 0.78
    let maxRowHeight: CGFloat = 60.0
    let minRowHeight: CGFloat = 40.0
    
    var headerHeight: CGFloat = 80.0
    var footerHeight: CGFloat = 40.0

    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupMenuItem() {
        
        self.clipsToBounds = true
        
        //setup header view
        var view = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: headerHeight))
        view.backgroundColor = UIColor.clearColor()
        headerView = view
        
        if let header = delegate?.headerViewForLeftMenu?(self) {
            headerView = header
        }
        
        self.addSubview(headerView!)
        
        
        // setup menuCell
        if let counts = self.dataSoruce?.numberOfItems() {
            var height = (self.bounds.height-headerHeight-footerHeight) / CGFloat(counts) - 1
            
            if height > maxRowHeight {
                height = maxRowHeight
            }
            
            if height < minRowHeight {
                height = minRowHeight
            }
            
            for i in 1...counts {
                
                var button = HUMenuItenCell(frame: CGRectZero)
                button.frame = CGRectMake(0, height*CGFloat(i-1)+headerView!.bounds.height+1, self.bounds.width, height)
                button.tag = i-1
                button.addTarget(self, action: "buttonClicked:", forControlEvents: .TouchUpInside)
                self.addSubview(button)

                self.dataSoruce?.leftMenu(self, menuItemAtIndex: i-1)
                
            }
            selectedItem = self.subviews[1] as! HUMenuItenCell
            selectedItem.selected = true
        }
        
        //setup footer View
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setupMenuItem()
        
    }
    
    
    func menuItemAtIndex(index: Int) -> AnyObject {
        return self.subviews[index+1]
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
