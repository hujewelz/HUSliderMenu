//
//  HUViewController.swift
//  HUSliderMenu
//
//  Created by jewelz on 15/7/13.
//  Copyright (c) 2015年 yangtzeu. All rights reserved.
//

import UIKit

class HUViewController: HUMainViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.backgroundImage = UIImage(named: "sidebar_bg.jpg")!
        self.transformWithScale = false
        //self.leftMenuBarItemTitle = "HHHH"
        //self.leftMenuBarItemImage = ""

        
        let rootView = HUFirstViewController()
        let secView = HUSecondViewController()
        let thirdView = HUFirstViewController()
        
        self.viewControllers = [rootView, secView, thirdView]
        
       
    }
    
    var menuItems = [ ["title": "首页", "image": "btn_save"],
                      ["title": "第二页", "image": "btn_share"],
                      ["title": "第三页", "image": "btn_support"] ]
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func numberOfItems() -> Int {
        return menuItems.count
    }
    
    override func leftMenu(menu: HULeftMenu, menuItemAtIndex index: Int) -> AnyObject {
        let item = menu.menuItemAtIndex(index) as! HUMenuItenCell
       
        item.selectedBackground = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.5)
        item.titleLabText = menuItems[index]["title"]
        item.image = UIImage(named: menuItems[index]["image"]!)
        
       // println("index: \(index)")
        return item
    }


}
