//
//  ViewController.swift
//  HUSliderMenu
//
//  Created by jewelz on 15/7/13.
//  Copyright (c) 2015年 yangtzeu. All rights reserved.
//

import UIKit

class HUMainViewController: UIViewController, HULeftMenuDelegate {
   
    private var currentViewController: UIViewController!
    private var contentViewControllers: [UIViewController] = []
   
    var transformWithScale = true
    var leftMenuBarItemTitle: String = "Menu"
    var leftMenuBarItemImage: String = "nav_btn_menu"
   
    private var bg: UIImageView!
    
    
    let scale = 400 / UIScreen.mainScreen().bounds.height

    var backgroundImage: UIImage {
        set {
            bg.image = newValue
        }
        get {
            return bg.image!
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bg = UIImageView(frame: view.bounds)
        //bg.image = backgroundImage
        view.addSubview(bg)
        
        var leftMenu = HULeftMenu(frame: CGRect(x: 0, y: 80, width: 200, height: 400))
        leftMenu.delegate = self
        view.addSubview(leftMenu)
        
        
    }
    
    var viewControllers: [UIViewController] {
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
    
    
    func setupViewController(viewController: UIViewController) {
       
        let leftBtn = self.leftMenuBarItem()
        
        let nav = UINavigationController(rootViewController: viewController)
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        
        self.addChildViewController(nav)
    }
    
    
    func leftMenu(menu: HULeftMenu, didSelectedItemAtIndex index: Int, toNewItem newIndex: Int) {
       
        if index >= self.contentViewControllers.count {
            return
        }
        
        if newIndex >= self.contentViewControllers.count {
            return
        }
        
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
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            if CGAffineTransformIsIdentity(self.currentViewController.view.transform) {
                
                var trans = CGAffineTransformMakeTranslation(200, 0)
                
                if self.transformWithScale {
                    var scaleform = CGAffineTransformMakeScale(self.scale, self.scale)
                    trans = CGAffineTransformTranslate(scaleform, 200, 10);
                    
                }
                
                self.currentViewController.view.transform = trans
                
                
            } else {
                self.currentViewController.view.transform = CGAffineTransformIdentity
                
            }
        })
        
    }
    
   private func leftMenuBarItem() -> UIButton {
        let leftBtn = UIButton.buttonWithType(.Custom) as! UIButton
        leftBtn.frame = CGRect(x: 0, y: 0, width: 60, height: 44)
    
    
        if let image =  UIImage(named: self.leftMenuBarItemImage) {
            leftBtn.setImage(image, forState:.Normal)
            leftBtn.contentHorizontalAlignment = .Left
        } else {
            leftBtn.setTitle(self.leftMenuBarItemTitle, forState: .Normal)
            leftBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        }
    
        leftBtn.addTarget(self, action: "sliderLeft", forControlEvents: .TouchUpInside)
    
        return leftBtn
    }
    
  

}

