//
//  UIButton+Style.swift
//  Nanurai
//
//  Created by Elliott Minns on 25/08/2018.
//  Copyright © 2018 Nanurai. All rights reserved.
//

import UIKit

extension UIButton {
  
  func setBackgroundColor(color: UIColor, forState: UIControlState) {
    UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
    UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
    UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
    let colorImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    self.setBackgroundImage(colorImage, for: forState)
  }
  
  func underline() {
    guard let text = self.titleLabel?.text else { return }
    
    let attributedString = NSMutableAttributedString(string: text)
    attributedString.addAttribute(NSAttributedStringKey.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: NSRange(location: 0, length: text.count))
    
    self.setAttributedTitle(attributedString, for: .normal)
  }
  
}
