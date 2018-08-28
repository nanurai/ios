//
//  Utilities.swift
//  Nanurai
//
//  Created by Elliott Minns on 28/08/2018.
//  Copyright © 2018 Nanurai. All rights reserved.
//

import Foundation

struct Utilities {
  static func pad(_ string: String, to size: Int) -> String {
    let remaining = size - string.count
    let padding = (0 ..< remaining).map { _ in
      return "0"
      }.joined(separator: "")
    
    return padding + string
  }
}
