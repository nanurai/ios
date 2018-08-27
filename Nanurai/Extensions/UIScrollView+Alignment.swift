//
//  UIScrollView+Alignment.swift
//  Nanurai
//
//  Created by Elliott Minns on 27/08/2018.
//  Copyright © 2018 Nanurai. All rights reserved.
//

import UIKit
import Stevia

extension UIScrollView {
  
  func pageAlign(views: [UIView]) {
    isPagingEnabled = true
    sv(views)
    
    views.first?.left(0)
    views.last?.right(0)
    
    views.enumerated().forEach { (index, view) in
      if index > 0 {
        let last = views[index - 1]
        view.Left == last.Right
      }
    }
  }
  
}
