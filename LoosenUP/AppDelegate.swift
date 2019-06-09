//
//  AppDelegate.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2017/3/3.
//  Copyright © 2017年 黃麒安. All rights reserved.
//

import UIKit
import RAMAnimatedTabBarController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        
        let subviewcontroller1 = MainViewController()
        subviewcontroller1.title = "首頁"
        let animation1 = RAMBounceAnimation.init()
//        let animation1 = RAMFrameItemAnimation()
//        let animation1 = RAMFumeAnimation()
        RAMAnimateService.setItemSelectedColor(Item: animation1, color: Const.Main_Color)
        let animateditem1 = RAMAnimatedTabBarItem.init()
        animateditem1.title = "首頁"
        RAMAnimateService.setItemColor(tabbarItem: animateditem1,color: UIColor.lightGray)
        animateditem1.image = UIImage(named: "icon1")
//        animateditem1.image = UIImage(named: "TabbarIcon1")
        animateditem1.animation = animation1
        subviewcontroller1.tabBarItem = animateditem1

        
        let subviewcontroller2 = ForumViewController()
        subviewcontroller2.title = "討論區"
        let animation2 = RAMBounceAnimation.init()
        RAMAnimateService.setItemSelectedColor(Item: animation2, color: Const.Main_Color)
        let animateditem2 = RAMAnimatedTabBarItem.init()
        animateditem2.title = "討論區"
        RAMAnimateService.setItemColor(tabbarItem: animateditem2,color: UIColor.lightGray)
        animateditem2.image = UIImage(named: "icon2")
//        animateditem2.image = UIImage(named: "TabbarIcon2")
        animateditem2.animation = animation2
        subviewcontroller2.tabBarItem = animateditem2

        
        let subviewcontroller3 = ManageViewController()
        subviewcontroller3.title = "個人專區"
        let animation3 = RAMBounceAnimation.init()
        RAMAnimateService.setItemSelectedColor(Item: animation3, color: Const.Main_Color)
        let animateditem3 = RAMAnimatedTabBarItem.init()
        animateditem3.title = "個人專區"
        RAMAnimateService.setItemColor(tabbarItem: animateditem3,color: UIColor.lightGray)
        animateditem3.image = UIImage(named: "icon3")
//        animateditem3.image = UIImage(named: "TabbarIcon3")
        animateditem3.animation = animation3
        subviewcontroller3.tabBarItem = animateditem3
        
        
        let navigationcontroller1 = UINavigationController()
        navigationcontroller1.pushViewController(subviewcontroller1, animated: true)
        UINavigationService.setNavBarColor(navigationController: navigationcontroller1,color: Const.Main_Color)
        
        let navigationcontroller2 = UINavigationController()
        navigationcontroller2.pushViewController(subviewcontroller2, animated: true)
        UINavigationService.setNavBarColor(navigationController: navigationcontroller2,color: Const.Main_Color)
        
        
        let navigationcontroller3 = UINavigationController()
        navigationcontroller3.pushViewController(subviewcontroller3, animated: true)
        UINavigationService.setNavBarColor(navigationController: navigationcontroller3,color: Const.Main_Color)
        
        
        let viewcontroller = HomeTabBarController(viewControllers: [navigationcontroller2,navigationcontroller1,navigationcontroller3])
        viewcontroller.tabBar.isTranslucent = false
        viewcontroller.setSelectIndex(from: 0, to: 1)
        
        self.window?.rootViewController = viewcontroller
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
