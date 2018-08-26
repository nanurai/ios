//
//  NanuraiViewController.swift
//  Nanurai
//
//  Created by Elliott Minns on 25/08/2018.
//  Copyright © 2018 Nanurai. All rights reserved.
//

import UIKit

class NanuraiViewController: UIViewController {
  init() {
    super.init(nibName: nil, bundle: nil)
    self.render()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func render() {
    view.backgroundColor = StyleGuide.Color.dark
  }

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
}
