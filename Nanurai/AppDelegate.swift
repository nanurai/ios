//
//  AppDelegate.swift
//  Nanurai
//
//  Created by Elliott Minns on 15/08/2018.
//  Copyright © 2018 Elliott Minns. All rights reserved.
//

import UIKit
import CoreStore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

    window = UIWindow(frame: UIScreen.main.bounds)
    
    Appearance.setup()

    window?.rootViewController = LoadingViewController()
    window?.makeKeyAndVisible()

    let controllers: [UIViewController] = [
      NanuraiNavigationController(rootViewController: BalanceViewController())
    ]
    
    Database.shared.load { result in
      switch result {
      case .success(_):
        print("Successfully added store")
      case .failure(let error):
        print("Failed adding sqlite store with error: \(error)")
      }
      guard let window = self.window else { return }
      
      let tab = TabBarController(controllers: controllers)
      
      let snapshot = window.snapshotView(afterScreenUpdates: false) ?? UIView()
      tab.view.addSubview(snapshot)
      snapshot.left(0).right(0).top(0).bottom(0)
      window.rootViewController = tab
      
      if !KeyManager.shared.hasKeys {
        let welcome = WelcomeViewController()
        let navigation = NanuraiNavigationController(rootViewController: welcome)
        tab.present(navigation, animated: false, completion: nil)
      }

      UIView.transition(
        with: window,
        duration: 0.3,
        options: [.transitionCrossDissolve],
        animations: {
          snapshot.layer.opacity = 0
      },
        completion: { _ in
          snapshot.removeFromSuperview()
      })
    }

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
    // Saves changes in the application's managed object context before the application terminates.
  }
}

