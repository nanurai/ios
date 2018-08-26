//
//  Appearance.swift
//  Nanurai
//
//  Created by Elliott Minns on 26/08/2018.
//  Copyright © 2018 Nanurai. All rights reserved.
//

import UIKit

struct Appearance {
  
  static func setup() {
    setupNavigationBar()
  }
  
  static func setupNavigationBar() {
    UINavigationBar.appearance().barTintColor = StyleGuide.Color.red
    UINavigationBar.appearance().tintColor = StyleGuide.Color.white
  }
  
}
