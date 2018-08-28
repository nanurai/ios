//
//  NanuraiNavigationController.swift
//  Nanurai
//
//  Created by Elliott Minns on 26/08/2018.
//  Copyright © 2018 Nanurai. All rights reserved.
//

import UIKit

class NanuraiNavigationController: UINavigationController {
  
  override init(rootViewController: UIViewController) {
    super.init(rootViewController: rootViewController)
    setup()
  }
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setup() {
    navigationBar.titleTextAttributes = [.foregroundColor: StyleGuide.Color.white]
    navigationBar.isTranslucent = false
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
}
