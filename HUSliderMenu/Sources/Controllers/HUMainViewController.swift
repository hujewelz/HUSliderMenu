//
//  ViewController.swift
//  HUSliderMenu
//
//  Created by jewelz on 15/7/13.
//  Copyright (c) 2015年 yangtzeu. All rights reserved.
//

import UIKit

class HUMainViewController: UIViewController, HULeftMenuDelegate {
    var viewControllers: [UIViewController]!
    var currentViewController: UIViewController!
    var contentViewControllers: [UIViewController] = []
    
    let scale = 400 / UIScreen.mainScreen().bounds.height

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bg = UIImageView(frame: view.bounds)
        bg.image = UIImage(named: "sidebar_bg.jpg")
        view.addSubview(bg)
        
        var leftMenu = HULeftMenu(frame: CGRect(x: 0, y: 80, width: 200, height: 400))
        leftMenu.delegate = self
        view.addSubview(leftMenu)
        
        let rootView = HUFirstViewController()
        //self.setupViewController(rootView, title: "首页")
        
        
        let secView = HUFirstViewController()
        //self.setupViewController(secView, title: "二页")
        
        let thirdView = HUFirstViewController()
        //self.setupViewController(thirdView, title: "三页")
        self.childviewControllers = [rootView, secView, thirdView]
        
        
       
        
        //self.rootViewController = UINavigationController(rootViewController: rootView)
        
        
        
    }
    
    var childviewControllers: [UIViewController] {
        set {
            
            for viewController in newValue {
                self.setupViewController(viewController)
            }
            contentViewControllers = self.childViewControllers as! [UIViewController]
            view.addSubview(contentViewControllers[0].view)
            self.currentViewController = contentViewControllers[0]
        }
        
        get {
            return contentViewControllers
        }
    }
    
//    var rootViewController: UIViewController {
//        set {
//            if currentViewController != nil {
//                currentViewController.removeFromParentViewController()
//            }
//    
//            view.addSubview(newValue.view)
//            //self.addChildViewController(currentViewController)
//        }
//        
//        get {
//            return currentViewController
//        }
//    }
    
    func setupViewController(viewController: UIViewController) {
        viewController.view.backgroundColor =  UIColor.redColor()
        
        let leftBtn = UIButton.buttonWithType(.Custom) as! UIButton
        leftBtn.frame = CGRect(x: 0, y: 0, width: 60, height: 44)
        leftBtn.setTitle("Menu", forState: UIControlState.Normal)
        leftBtn.addTarget(self, action: "sliderLeft", forControlEvents: .TouchUpInside)
        leftBtn.setTitleColor(UIColor.redColor(), forState: .Normal)
        
        let nav = UINavigationController(rootViewController: viewController)
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        
        self.addChildViewController(nav)
    }
    
    func leftMenu(menu: HULeftMenu, didSelectedItemAtIndex index: Int, toNewItem newIndex: Int) {
       // rootViewController.view.removeFromSuperview()
        println(self.childViewControllers.count)
        
        let oldVc = self.contentViewControllers[index] as! UINavigationController
        oldVc.view.removeFromSuperview()
        oldVc.removeFromParentViewController()
        
        let newVc = self.contentViewControllers[newIndex] as! UINavigationController
        newVc.view.transform = oldVc.view.transform
        view.addSubview(newVc.view)
        self.addChildViewController(newVc)
        
        self.currentViewController = newVc
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            newVc.view.transform = CGAffineTransformIdentity
        })
        
    }
    
    
    func sliderLeft() {
        contentViewControllers.count
        println("contentViewControllers.count: \(contentViewControllers.count)")
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            if CGAffineTransformIsIdentity(self.currentViewController.view.transform) {
                
                var scaleform = CGAffineTransformMakeScale(self.scale, self.scale)
                var trans = CGAffineTransformTranslate(scaleform, 200, 10);
                self.currentViewController.view.transform = trans
                
            } else {
                self.currentViewController.view.transform = CGAffineTransformIdentity
                
            }
        })
        
    }

}

