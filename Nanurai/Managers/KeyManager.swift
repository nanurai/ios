//
//  KeyManager.swift
//  FriendshipCoin
//
//  Created by Elliott Minns on 23/03/2018.
//  Copyright © 2018 FriendshipCoin. All rights reserved.
//

import Foundation
import KeychainAccess

enum KeyManagerError: Error {
  case notFound
}

class KeyManager {
  static let shared: KeyManager = KeyManager()
  
  let privKeychain = Keychain(service: "org.nanurai.keychain.private")
    .accessibility(.whenPasscodeSetThisDeviceOnly, authenticationPolicy: .userPresence)
  let pubKeychain = Keychain(service: "org.nanurai.keychain.public")
    .accessibility(.whenUnlockedThisDeviceOnly)
  
  func accountPath(at index: Int) -> String {
    let base: String = "m/44'/165'"
    return "\(base)/\(index)'"
  }
  
  var hasKeys: Bool {
    return (try? pubKeychain.get("has-mnemonic-phrase") != nil) ?? false
  }
  
  private init() {
  }
  
  func store(mnemonic: Mnemonic) {
    /*
    let seed = mnemonic.seedHex()
    do {
      let node = try HDNode(seedHex: seed, network: NetworkType.friendshipcoin)
      let account = try node.derive(path: accountPath(at: 0))
      try privKeychain.set(seed, key: "seed")
      try privKeychain.set(mnemonic.formatted, key: "words")
      try pubKeychain.set(account.toBase58(isPrivate: false), key: base)
      try pubKeychain.set("true", key: "has-mnemonic-phrase")
    } catch let error {
      print(error)
    }
     */
  }
  /*
  func keyPair(for account: Account, address: Int) throws -> ECPair {
    guard let seed = try privKeychain.get("seed") else { throw KeyManagerError.notFound }
    let index = account.index
    let node = try HDNode(seedHex: seed, network: NetworkType.friendshipcoin)
    let accountNode = try node.derive(path: "m/44'/0'/\(index)'")
    let addressNode = try accountNode.derive(0).derive(address)
    return addressNode.keyPair
  }
  */
  func nuke() throws {
    try privKeychain.remove("seed")
    try privKeychain.remove("words")
    try pubKeychain.remove("m/44'/0'/0'")
    try pubKeychain.remove("has-mnemonic-phrase")
  }
  
  func getPublicBase58(account: Int) throws -> String {
    guard let acc = try pubKeychain.get("m/44'/0'/\(account)'") else {
      throw KeyManagerError.notFound
    }
    
    return acc
  }
}
