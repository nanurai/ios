//
//  AccountManager.swift
//  Nanurai
//
//  Created by Elliott Minns on 27/08/2018.
//  Copyright © 2018 Nanurai. All rights reserved.
//

import Foundation
import Sodium
import CoreStore

enum AccountManagerError: Error {
  case hashIssue
}

class AccountManager {
  
  static let shared = AccountManager()
  
  private init() {}
  
  func account(from seed: Data, index: Int32) throws -> Account {
    let sodium = Sodium()
    let indexData = Data(bytes: index.bytes)
    guard let stream = sodium.genericHash.initStream(outputLength: 32),
      stream.update(input: seed.bytes),
      stream.update(input: indexData.bytes),
      let secret = stream.final(),
      let pair = sodium.sign.keyPair(secret: secret) else {
      throw AccountManagerError.hashIssue
    }

    let padding = Binary(bits: "0000")
    let pub = Binary(bytes: pair.publicKey)
    let bits = padding + pub
    let publicKeyEncoded = bits.toBase32()
    
    guard let pkHash = sodium.genericHash.hash(
      message: pair.publicKey, outputLength: 5
    ) else {
      throw AccountManagerError.hashIssue
    }
    let checksum = Binary(
      bytes: Data(pkHash).byteSwap().bytes
    )
    
    let checksumEncoded = checksum.toBase32()
    let address = "nano_\(publicKeyEncoded)\(checksumEncoded)"
    return Account(index: index, address: address)
  }
  
  func account(from mnemonic: Mnemonic, index: Int32) throws -> Account {
    let seed = try mnemonic.entropy()
    return try account(from: seed, index: index)
  }
  
  func initial(loadFrom mnemonic: Mnemonic, callback: @escaping () -> Void) {
    
    DispatchQueue.global().async {

      let number: Int32 = 50
      
      let accounts = (0 ..< number).compactMap { index in
        return try? self.account(from: mnemonic, index: index)
      }
      
      CoreStore.perform(asynchronous: { (transaction) -> Bool in
        accounts.forEach { account in
          let stored = transaction.create(Into<AccountStore>())
          stored.address.value = account.address
          stored.index.value = account.index
        }
        return true
      }) { (result) in
        DispatchQueue.main.async {
          callback()
        }
      }
    }
  }
}
