//
//  AppDelegate.swift
//  WolfGoatCabbage
//
//  Created by Екатерина on 11/24/18.
//  Copyright © 2018 Екатерина. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var mainNavigationController = UINavigationController()
    var service = EntityService()
    var viewModel:ViewModel?
    let leftViewController = LeftViewController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        viewModel = ViewModel(service: self.service)
    
        self.mainNavigationController.isNavigationBarHidden = true
        leftViewController.viewModel = viewModel
        leftViewController.delegate = self
        

        mainNavigationController.viewControllers = [leftViewController]
        window?.rootViewController = mainNavigationController
        
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
    func startNewGame(){
        service = EntityService()
        viewModel = ViewModel(service: service)
        leftViewController.viewModel = viewModel
        self.mainNavigationController.popToRootViewController(animated: true)
    }
    
    
}

extension AppDelegate:LeftViewControllerDelegate{
    func moveToTheRightSide() {
        let arrToRight = service.entityArr.filter { (entity) -> Bool in
            return entity.state == EntityState.isInBoat
        }
        if(arrToRight.count > 1){
            print("Amount is incorrect")
            return
        }
        arrToRight.first?.state = EntityState.isOnTheRight
        
        let rvc = RightViewController()
        rvc.viewModel = self.viewModel
        rvc.delegate = self
        mainNavigationController.pushViewController(rvc, animated: true)
        
    }
}

extension AppDelegate:RightViewControllerDelegate{
    func moveToTheLeft() {
        let arrToRight = service.entityArr.filter { (entity) -> Bool in
            return entity.state == EntityState.isInBoat
        }
        if(arrToRight.count > 1){
            print("Amount is incorrect")
            return
        }
        arrToRight.first?.state = EntityState.isOnTheLeft
        self.mainNavigationController.popViewController(animated: true)
    }

}
