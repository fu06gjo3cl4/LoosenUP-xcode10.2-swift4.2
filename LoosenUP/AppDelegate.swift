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
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let subviewcontroller1 = MainViewController.shared
        subviewcontroller1.title = NSLocalizedString("MainVC.NavBarTitle", comment: "")
        let subviewcontroller2 = ForumViewController.shared
        subviewcontroller2.title = NSLocalizedString("ForumVC.NavBarTitle", comment: "")
        let subviewcontroller3 = ManageViewController.shared
        subviewcontroller3.title = NSLocalizedString("ManageVC.NavBarTitle", comment: "")
        let subviewcontroller4 = SearchViewController.shared
        subviewcontroller4.title = NSLocalizedString("SearchVC.NavBarTitle", comment: "")
        let subviewcontroller5 = PersonalQualityViewController.shared
        subviewcontroller5.title = NSLocalizedString("ShelfVC.NavBarTitle", comment: "")
        
        let animation1 = RAMBounceAnimation.init()
        RAMAnimateService.setItemSelectedColor(Item: animation1, color: Setting.shared.mainColor())
        let animateditem1 = RAMAnimatedTabBarItem.init()
        animateditem1.title = NSLocalizedString("MainVC.TabBtnTitle", comment: "")
        RAMAnimateService.setItemColor(tabbarItem: animateditem1,color: UIColor.lightGray)
        animateditem1.image = UIImage(named: "icon1")
        animateditem1.animation = animation1

        let animation2 = RAMBounceAnimation.init()
        RAMAnimateService.setItemSelectedColor(Item: animation2, color: Setting.shared.mainColor())
        let animateditem2 = RAMAnimatedTabBarItem.init()
        animateditem2.title = NSLocalizedString("ForumVC.TabBtnTitle", comment: "")
        RAMAnimateService.setItemColor(tabbarItem: animateditem2,color: UIColor.lightGray)
        animateditem2.image = UIImage(named: "icon2")
        animateditem2.animation = animation2

        let animation3 = RAMBounceAnimation.init()
        RAMAnimateService.setItemSelectedColor(Item: animation3, color: Setting.shared.mainColor())
        let animateditem3 = RAMAnimatedTabBarItem.init()
        animateditem3.title = NSLocalizedString("ManageVC.TabBtnTitle", comment: "")
        RAMAnimateService.setItemColor(tabbarItem: animateditem3,color: UIColor.lightGray)
        animateditem3.image = UIImage(named: "icon3")
        animateditem3.animation = animation3
        
        let animation4 = RAMBounceAnimation.init()
        RAMAnimateService.setItemSelectedColor(Item: animation4, color: Setting.shared.mainColor())
        let animateditem4 = RAMAnimatedTabBarItem.init()
        animateditem4.title = NSLocalizedString("SearchVC.TabBtnTitle", comment: "")
        RAMAnimateService.setItemColor(tabbarItem: animateditem4,color: UIColor.lightGray)
        animateditem4.image = UIImage(named: "icon1")
        animateditem4.animation = animation4
        
        let animation5 = RAMBounceAnimation.init()
        RAMAnimateService.setItemSelectedColor(Item: animation5, color: Setting.shared.mainColor())
        let animateditem5 = RAMAnimatedTabBarItem.init()
        animateditem5.title = NSLocalizedString("ShelfVC.TabBtnTitle", comment: "")
        RAMAnimateService.setItemColor(tabbarItem: animateditem5,color: UIColor.lightGray)
        animateditem5.image = UIImage(named: "icon1")
        animateditem5.animation = animation5

        let navigationcontroller1 = UINavigationController()
        navigationcontroller1.pushViewController(subviewcontroller1, animated: true)
        navigationcontroller1.tabBarItem = animateditem1

        let navigationcontroller2 = UINavigationController()
        navigationcontroller2.pushViewController(subviewcontroller2, animated: true)
        navigationcontroller2.tabBarItem = animateditem2

        let navigationcontroller3 = UINavigationController()
        navigationcontroller3.pushViewController(subviewcontroller3, animated: true)
        navigationcontroller3.tabBarItem = animateditem3
        
        let navigationcontroller4 = UINavigationController()
        navigationcontroller4.pushViewController(subviewcontroller4, animated: true)
        navigationcontroller4.tabBarItem = animateditem4
        let navigationcontroller5 = UINavigationController()
        navigationcontroller5.pushViewController(subviewcontroller5, animated: true)
        navigationcontroller5.tabBarItem = animateditem5

        let viewcontroller = HomeTabBarController.shared
        viewcontroller.setViewControllers([navigationcontroller2,navigationcontroller5,navigationcontroller1,navigationcontroller4,navigationcontroller3], animated: true)
        viewcontroller.tabBar.isTranslucent = false
        viewcontroller.setSelectIndex(from: 0, to: 2)
        
        self.window?.rootViewController = viewcontroller
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
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


//extension UIApplication {
//    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
//        if let navigationController = controller as? UINavigationController {
//            return topViewController(controller: navigationController.visibleViewController)
//        }
//        if let tabController = controller as? UITabBarController {
//            if let selected = tabController.selectedViewController {
//                return topViewController(controller: selected)
//            }
//        }
//        if let presented = controller?.presentedViewController {
//            return topViewController(controller: presented)
//        }
//        return controller
//    }
//}
