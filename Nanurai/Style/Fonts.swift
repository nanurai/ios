//
//  Fonts.swift
//  Nanurai
//
//  Created by Elliott Minns on 25/08/2018.
//  Copyright © 2018 Nanurai. All rights reserved.
//

import UIKit

extension StyleGuide {
  struct Font {
    static func title(ofSize size: CGFloat = 32) -> UIFont {
      return UIFont.systemFont(ofSize: size, weight: .thin)
    }
    
    static func standard(ofSize size: CGFloat = 12) -> UIFont {
      return UIFont.systemFont(ofSize: size, weight: .thin)
    }
  }
}
