//
//  NanuraiTextField.swift
//  Nanurai
//
//  Created by Elliott Minns on 27/08/2018.
//  Copyright © 2018 Nanurai. All rights reserved.
//

import UIKit

class NanuraiTextField: UITextField {
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    return UIEdgeInsetsInsetRect(bounds, UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
  }
  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return UIEdgeInsetsInsetRect(bounds, UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
  }
  override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
    
    return UIEdgeInsetsInsetRect(bounds, UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
  }
}
