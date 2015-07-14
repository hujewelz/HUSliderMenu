HUSliderMenu
==============
* 简单易用的左划菜单
* 有支持缩放和不缩放两种效果
* 简单定制自己的左侧菜单，可设置文字和图片

如何使用HUSliderMenu
-------------------
* 手动导入:
	* 将HUSliderMenu文件夹中的Resource文件夹加入到项目中
	* 只要让根控制器继承HUSliderMenuViewController即可
参考
-----
```Swift
override func viewDidLoad() {
        super.viewDidLoad()
        self.backgroundImage = UIImage(named: "bg2.jpeg")! //设置背景图
        //self.transformWithScale = false	//不缩放
        //self.leftMenuBarItemTitle = "Menu"	//设置导航栏的菜单按钮文字
        //self.leftMenuBarItemImage = ""	//设置导航栏的菜单按钮的图片	如果不设置，会使用默认的
        
        let rootView = HUFirstViewController()
        let secView = HUSecondViewController()
        let thirdView = HUThirdViewController()
        
        self.viewControllers = [rootView, secView, thirdView]   //设置左侧所有要显示的控制器，不要添加NavigationViewcontroller
        
       
    }

    override func numberOfItems() -> Int {	//左侧菜单数目
        return menuItems.count
    }

    override func leftMenu(menu: HULeftMenu, menuItemAtIndex index: Int) -> AnyObject {
        let item = menu.menuItemAtIndex(index) as! HUMenuItenCell
        /**
		*	这里设置菜单样式，标题，图标，选中颜色等
        */
        return item
    }
```
