//
//  ViewController.swift
//  HUSliderMenu
//
//  Created by jewelz on 15/7/13.
//  Copyright (c) 2015年 yangtzeu. All rights reserved.
//

import UIKit

class HUSliderMenuViewController: UIViewController, HULeftMenuDelegate, HULeftMenuDataSource {
   
    var transformWithScale = true   //是否允许缩放效果
    var allowSpringAnimation = true ////是否允许弹簧效果
    var leftMenuBarItemTitle: String = "Menu"   //设置菜单按钮标题
    var leftMenuBarItemImage: String = "menu.png"   //设置菜单按钮图标
    
    var menuView: HULeftMenu!
   
    private var bg: UIImageView!
    private var currentViewController: UIViewController!
    private var contentViewControllers: [UIViewController] = []
    private var menuWidth: CGFloat = 0.0
    private let scale: CGFloat = 0.78
    private let animationDuration: NSTimeInterval = 0.5
    private let springDamping: CGFloat = 0.7
    private let springVelocity: CGFloat = 20

    var backgroundImage: UIImage {  //设置左侧菜单背景图片
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
        view.addSubview(bg)
        
        let width = UIScreen.mainScreen().bounds.width * scale
        let height = UIScreen.mainScreen().bounds.height
       
        var leftMenu = HULeftMenu(frame: CGRect(x: 0, y: 0, width: width, height: height))
        leftMenu.delegate = self
        leftMenu.dataSoruce = self
        view.addSubview(leftMenu)
        
        self.menuWidth = width
        
        self.menuView = leftMenu
        
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

    
    func numberOfItems() -> Int {
        return 0
    }
    
    func leftMenu(menu: HULeftMenu, menuItemAtIndex index: Int) -> AnyObject {
        let item = menu.menuItemAtIndex(index) as! HUMenuItenCell
        return item
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
        
        
        
        if allowSpringAnimation {
            
            UIView.animateWithDuration(animationDuration, delay: 0, usingSpringWithDamping: springDamping, initialSpringVelocity: springVelocity, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                newVc.view.transform = CGAffineTransformIdentity
            }, completion: { (finished) -> Void in
                
            })
        
        } else {
            UIView.animateWithDuration(animationDuration, animations: { () -> Void in
                newVc.view.transform = CGAffineTransformIdentity
            })
        }
        
    }
    
    
     func sliderLeft() {
 
        if allowSpringAnimation {
            UIView.animateWithDuration(animationDuration, delay: 0, usingSpringWithDamping: springDamping, initialSpringVelocity: springVelocity, options: nil, animations: { () -> Void in
                    self.showLeftMenu()
                }, completion: { (finished) -> Void in
                    
            })
            
        } else {
            
            UIView.animateWithDuration(animationDuration, animations: { () -> Void in
                self.showLeftMenu()
            })
        }
        
    }
    
    private func showLeftMenu() {
        let sWidth = UIScreen.mainScreen().bounds.width
        let leftPadding = sWidth * (1-self.scale) * 0.5
        let tX = self.menuWidth - leftPadding
        
        if CGAffineTransformIsIdentity(self.currentViewController.view.transform) {
            
            var trans = CGAffineTransformMakeTranslation(sWidth*self.scale, 0)
            
            if self.transformWithScale {
                var scaleform = CGAffineTransformMakeScale(self.scale, self.scale)
                trans = CGAffineTransformTranslate(scaleform, tX/self.scale, 0);
                
            }
            
            self.currentViewController.view.transform = trans
            
            
        } else {
            self.currentViewController.view.transform = CGAffineTransformIdentity
            
        }
        
    }
    
    private func setupViewController(viewController: UIViewController) {
       
        let leftBtn = self.leftMenuBarItem()
        
        let nav = UINavigationController(rootViewController: viewController)
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        
        self.addChildViewController(nav)
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

