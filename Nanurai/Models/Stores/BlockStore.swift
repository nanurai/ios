//
//  BlockStore.swift
//  Nanurai
//
//  Created by Elliott Minns on 28/08/2018.
//  Copyright © 2018 Nanurai. All rights reserved.
//

import CoreStore

class BlockStore: CoreStoreObject {
  let account = Relationship.ToOne<AccountStore>("account")
}
