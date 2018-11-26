//
//  AppDelegate.swift
//  Challange
//
//  Created by Okan Yücel on 26.11.2018.
//  Copyright © 2018 Okan Yücel. All rights reserved.
//

import UIKit


let mAppDelegate = UIApplication.shared.delegate! as! AppDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var mNavigationController: UINavigationController?
    var mMainViewController: MainViewController?
    var mSplashViewController: SplashViewController?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.initialSlideNavigationController()
        self.window!.rootViewController = mNavigationController
        self.window!.makeKeyAndVisible()
        
        self.addSplashPage()
        
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
    
    func initialSlideNavigationController() {
        
        self.mMainViewController = MainViewController(nibName: "MainViewController",bundle:nil)
        mNavigationController = UINavigationController(rootViewController: mMainViewController!)
        mNavigationController?.isNavigationBarHidden = true
        
    }
    
    func addSplashPage() {
        
        mSplashViewController = SplashViewController(nibName: "SplashViewController", bundle: nil)
        mSplashViewController!.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.window!.rootViewController!.view.addSubview(mSplashViewController!.view)
        
        
        self.closeSplashPage()
    }
    
    func closeSplashPage(){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            
            UIView.animate(withDuration: 0.5, animations: {
                
                self.mSplashViewController!.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                self.mSplashViewController!.view!.layer.opacity = 1;
                self.mSplashViewController!.view!.layer.transform = CATransform3DMakeScale(2, 2, 2)
                
            }, completion: { (status) in
                
                self.mSplashViewController!.view.removeFromSuperview()
                
            })
            
        }
        
    }
    
    
}

