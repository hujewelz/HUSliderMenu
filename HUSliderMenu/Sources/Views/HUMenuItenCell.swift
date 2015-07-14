//
//  HUMenuItenCell.swift
//  HUSliderMenu
//
//  Created by jewelz on 15/7/14.
//  Copyright (c) 2015年 yangtzeu. All rights reserved.
//

import UIKit

class HUMenuItenCell: UIButton {
    
    var titleLabText: String? {
        set {
            self.setTitle(newValue, forState: .Normal)
        }
        
        get {
            return self.currentTitle
        }
    }
    
    var titleLabColor: UIColor {
        set {
            self.setTitleColor(newValue, forState: .Normal)
        }
        
        get {
            return self.titleLabColor
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
        let color = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.5)
        self.setBackgroundImage(UIImage.imageWithColor(color), forState: UIControlState.Selected)
        self.adjustsImageWhenHighlighted = false
        
        self.contentHorizontalAlignment = .Left
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

