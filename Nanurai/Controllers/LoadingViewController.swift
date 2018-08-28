//
//  LoadingViewController.swift
//  Nanurai
//
//  Created by Elliott Minns on 28/08/2018.
//  Copyright © 2018 Nanurai. All rights reserved.
//

import UIKit
import Stevia

class LoadingViewController: NanuraiViewController {
  override func render() {
    let storyboard = UIStoryboard(name: "LaunchScreen", bundle: nil)
    guard let initial = storyboard.instantiateInitialViewController() else {
      return
    }
    
    view.addSubview(initial.view)
    initial.view.followEdges(view)
  }
}
