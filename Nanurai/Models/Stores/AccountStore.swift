//
//  Account.swift
//  Nanurai
//
//  Created by Elliott Minns on 27/08/2018.
//  Copyright © 2018 Nanurai. All rights reserved.
//

import Foundation
import CoreStore

class AccountStore: CoreStoreObject {
  let address = Value.Required<String>("address", initial: "")
  
  let balance = Value.Required<String>("balance", initial: "0.00")
  
  let blocks = Relationship.ToManyOrdered<BlockStore>("blocks", inverse: { $0.account })
  
  let index = Value.Required<Int32>("index", initial: 0)
}
