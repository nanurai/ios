//
//  KeyPair.swift
//  Nanurai
//
//  Created by Elliott Minns on 27/08/2018.
//  Copyright © 2018 Nanurai. All rights reserved.
//

import Foundation

struct KeyPair {
  
  let privateKey: Data?
  
  let publicKey: Data
  
  init(privateKey: Data) throws {
    self.privateKey = privateKey
    self.publicKey = privateKey
  }
  
  init(publicKey: Data) {
    self.privateKey = nil
    self.publicKey = publicKey
  }
  
}
