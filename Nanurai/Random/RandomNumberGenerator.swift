//
//  RandomNumberGenerator.swift
//  Nanurai
//
//  Created by Elliott Minns on 15/08/2018.
//  Copyright © 2018 Nanurai. All rights reserved.
//

import Foundation

protocol RandomNumberGenerator {
  static func generate(length: Int) -> Data?
}

struct SecureRandomNumberGenerator: RandomNumberGenerator {
  static func generate(length: Int) -> Data? {
    var data = Data(count: length)
    let count = data.count
    let result = data.withUnsafeMutableBytes {
      (mutableBytes: UnsafeMutablePointer<UInt8>) -> Int32 in
      SecRandomCopyBytes(kSecRandomDefault, count, mutableBytes)
    }
    if (result == errSecSuccess) {
      return data
    } else {
      return nil
    }
  }
}
