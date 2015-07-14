//
//  HUViewController.swift
//  HUSliderMenu
//
//  Created by jewelz on 15/7/13.
//  Copyright (c) 2015年 yangtzeu. All rights reserved.
//

import UIKit

class HUViewController: HUSliderMenuViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.backgroundImage = UIImage(named: "bg2.jpeg")!
        //self.transformWithScale = false
        //self.leftMenuBarItemTitle = "Menu"
        //self.leftMenuBarItemImage = ""
        
        let rootView = HUFirstViewController()
        let secView = HUSecondViewController()
        let thirdView = HUThirdViewController()
        
        self.viewControllers = [rootView, secView, thirdView]
        
       
    }
    
    var menuItems = [ ["title": "首页", "image": "btn_save"],
                      ["title": "第二页", "image": "btn_share"],
                      ["title": "第三页", "image": "btn_support"]]

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func numberOfItems() -> Int {
        return menuItems.count
    }
    
    override func leftMenu(menu: HULeftMenu, menuItemAtIndex index: Int) -> AnyObject {
        let item = menu.menuItemAtIndex(index) as! HUMenuItenCell
        if index == 0 {
            item.selectedBackground = UIColor(red: 228.0/255.0, green: 36.0/255.0, blue: 65.0/225.0, alpha: 0.5)
        } else if index == 1 {
            item.selectedBackground = UIColor(red: 237.0/255.0, green: 130.0/255.0, blue: 46.0/225.0, alpha: 0.5)
        } else {
            item.selectedBackground = UIColor(red: 64.0/255.0, green: 187.0/255.0, blue: 245.0/225.0, alpha: 0.5)
        }
        
        item.titleLabText = menuItems[index]["title"]
        item.image = UIImage(named: menuItems[index]["image"]!)
        item.titleLabel?.font = UIFont.systemFontOfSize(16)
        item.titleLabColor = UIColor.greenColor()
        
        return item
    }
    
    func headerViewForLeftMenu(menu: HULeftMenu) -> UIView? {
        var view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 120))
       // view.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.5)
        
        var icon = UIImageView(frame: CGRect(x: 40, y: 40, width: 60, height: 60))
        icon.image = UIImage(named: "user.jpg")
        icon.layer.cornerRadius = 30
        icon.layer.masksToBounds = true
        view.addSubview(icon)
        
        return view
    }


}
