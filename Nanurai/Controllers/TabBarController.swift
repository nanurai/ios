//
//  TabBarController.swift
//  Nanurai
//
//  Created by Elliott Minns on 15/08/2018.
//  Copyright © 2018 Elliott Minns. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
  init(controllers: [UIViewController]) {
    super.init(nibName: nil, bundle: nil)
    self.viewControllers = controllers
    tabBar.isTranslucent = false
    tabBar.barTintColor = StyleGuide.Color.dark
    tabBar.tintColor = StyleGuide.Color.blue
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
}
