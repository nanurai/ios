//
//  Data+Base32.swift
//  Nanurai
//
//  Created by Elliott Minns on 28/08/2018.
//  Copyright © 2018 Nanurai. All rights reserved.
//

import Foundation

fileprivate class Base32 {
  
  let lookup: [UInt8: Character]
  
  init() {
    let values: String = "13456789abcdefghijkmnopqrstuwxyz"
    let dict = (0 ..< 32).reduce([:]) { (result: [UInt8: Character], value: UInt8) -> [UInt8: Character] in
      var res = result
      res[value] = values[values.index(values.startIndex, offsetBy: Int(value))]
      return res
    }
    
    lookup = dict
  }
  
  func encode(binary: Binary) -> String {
    let length = 5
    let count = binary.count / length
    return String((0 ..< count).compactMap { index -> Character? in
      let start = index * 5
      let value = UInt8(binary.bits(start, length))
      return lookup[value]
    })
  }
}

extension Binary {
  func toBase32() -> String {
    return Base32().encode(binary: self)
  }
}
