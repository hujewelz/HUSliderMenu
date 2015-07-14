//
//  UIImage+Extention.swift
//  HUSliderMenu
//
//  Created by jewelz on 15/7/14.
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
