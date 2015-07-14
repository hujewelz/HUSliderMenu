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
        //self.transformWithScale = false	//不缩放，默认缩放
        //self.allowSpringAnimation = false		//不允许弹簧效果, 默认有弹簧效果
        //self.leftMenuBarItemTitle = "Menu"	//设置导航栏的菜单按钮文字，如果不设置，会使用默认的
        //self.leftMenuBarItemImage = ""	//设置导航栏的菜单按钮的图片，如果不设置，会使用默认的
        
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
其实这里和UITableView的使用差不多<br>
还可以在这个方法中设置自己的头视图，定制性很高
```Swift
	func headerViewForLeftMenu(menu: HULeftMenu) -> UIView? {
        var view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 120))
   
        var icon = UIImageView(frame: CGRect(x: 40, y: 40, width: 60, height: 60))
        icon.image = UIImage(named: "user.jpg")
        icon.layer.cornerRadius = 30
        icon.layer.masksToBounds = true
        view.addSubview(icon)
        
        return view
    }
```
带缩放效果<br>
![image](https://github.com/hujewelz/HUSliderMenu/raw/master/screenshots/1.png)
![image](https://github.com/hujewelz/HUSliderMenu/raw/master/screenshots/2.png)<br>
不带缩放效果<br>
![image](https://github.com/hujewelz/HUSliderMenu/raw/master/screenshots/3.png)
![image](https://github.com/hujewelz/HUSliderMenu/raw/master/screenshots/4.png)


这样写好后，就不用再担心菜单的问题了，可以安心的写自己要添加的控制器里面的内容了。
在自己的控制器的viewDidLoad中设置一下背景色, 不然看不到内容。
不太清楚的可以参考Sample文件夹中的例子

提醒
-----
* 本框架使用Swift开发， 兼容的系统>=iOS7.0

期望
------
* 如果在使用过程中遇到BUG，希望你能联系我，谢谢（或者尝试下载最新的框架代码看看BUG修复没有）
* 如果在使用过程中发现功能不够用，希望你能联系我，我非常想为这个框架增加更多好用的功能，谢谢

