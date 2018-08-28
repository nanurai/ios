//
//  Database.swift
//  Nanurai
//
//  Created by Elliott Minns on 28/08/2018.
//  Copyright © 2018 Nanurai. All rights reserved.
//

import Foundation
import CoreStore

class Database {
  static let shared = Database()
  
  init() {
  }
  
  func load(callback: @escaping (Result<Void>) -> Void) {
    CoreStore.defaultStack = DataStack(
      CoreStoreSchema(
        modelVersion: "V1",
        entities: [
          Entity<AccountStore>("Account"),
          Entity<BlockStore>("Block")
        ]
      )
    )
    _ = CoreStore.addStorage(
      SQLiteStore(fileName: "Nanurai.sqlite"),
      completion: { (result) -> Void in
        if case let .failure(error) = result {
          callback(Result.failure(error))
        } else {
          callback(Result.success(Void()))
        }
      }
    )
  }
}
