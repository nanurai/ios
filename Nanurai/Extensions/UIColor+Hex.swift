//
//  UIColor+Hex.swift
//  Nanurai
//
//  Created by Elliott Minns on 15/08/2018.
//  Copyright © 2018 Elliott Minns. All rights reserved.
//

import UIKit

extension UIColor {
  convenience init(hex: String, alpha: CGFloat = 1.0) {
    var str = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    var rgbValue: UInt32 = 10066329 //color #999999 if string has wrong format
    
    if (str.hasPrefix("#")) {
      str.remove(at: str.startIndex)
    }
    
    if ((str.count) == 6) {
      Scanner(string: str).scanHexInt32(&rgbValue)
    }
    
    self.init(
      red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
      alpha: alpha
    )
  }
}
