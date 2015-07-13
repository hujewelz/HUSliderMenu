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
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
