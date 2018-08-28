//
//  Mnemonic.swift
//  Nanurai
//
//  Created by Elliott Minns on 15/08/2018.
//  Copyright © 2018 Elliott Minns. All rights reserved.
//

import Foundation
import Crypto

public enum MnemonicError: Error {
  case generate(String)
}

public struct Mnemonic {
  
  public let words: [String]
  
  public var formatted: String {
    return words.joined(separator: " ")
  }
  
  public init(locale: Locale = Locale.current) throws {
    try self.init(strength: 256, locale: locale)
  }
  
  public init(words: String) {
    self.words = words.components(separatedBy: " ")
  }
  
  public init(words: [String]) {
    self.words = words
  }
  
  init(entropy: String, locale: Locale = Locale.current) throws {
    guard let bytes = entropy.hexadecimal() else {
      throw MnemonicError.generate("Invalid entropic string")
    }
    
    self = try Mnemonic.generate(entropy: bytes)
  }
  
  init(
    strength: UInt = 128,
    rng: RandomNumberGenerator.Type = SecureRandomNumberGenerator.self,
    locale: Locale = Locale.current
  ) throws {
    self = try Mnemonic.generate(strength: strength, rng: rng, locale: locale)
  }
  
  public init(seed: String) {
    words = []
  }
  
  func salt(password: String) -> String {
    let pw = password
    return "mnemonic\(pw)"
  }
  
  public func seed(password: String = "") -> Data {
    let str = self.formatted.precomposedStringWithCompatibilityMapping
    let slt = salt(password: password).precomposedStringWithCompatibilityMapping.data(using: .utf8) ?? Data()
    let data = str.pbkdf2SHA512(salt: slt, keyByteCount: 64, rounds: 2048)
    return data!
  }
  
  public func seedHex(password: String = "") -> String {
    return seed(password: password).hexEncodedString()
  }

  public func entropy(locale: Locale = Locale.current) throws -> Data {
    let wordlist = WordList(locale: locale)
    let bits = try wordlist.index(of: words).map { index -> String in
      let str = String(index, radix: 2)
      return Utilities.pad(str, to: 11)
    }.joined()
    
    let divider = bits.count / 33 * 32
    let position = bits.index(bits.startIndex, offsetBy: divider)
    let entropyBits = bits[bits.startIndex ..< position]
    let checksumBits = bits[position ..< bits.endIndex]
    
    let byteSize = 8
    let numBytes = entropyBits.count / byteSize
    
    let bytes = (0 ..< numBytes).map { byteNum -> UInt8 in
      let index = byteSize * byteNum
      let start = entropyBits.index(bits.startIndex, offsetBy: index)
      let end = bits.index(start, offsetBy: byteSize)
      let bitString = bits[start ..<  end]
      return UInt8(bitString, radix: 2) ?? 0
    }
    
    return Data(bytes: bytes)
  }
}

extension Mnemonic {
  
  static func generate(strength: UInt = 128,
                       rng: RandomNumberGenerator.Type = SecureRandomNumberGenerator.self,
                       locale: Locale = Locale.current) throws -> Mnemonic {
    
    guard strength % 32 == 0 else {
      throw MnemonicError.generate("Incorrect strength")
    }
    guard let bytes = rng.generate(length: Int(strength / 8)) else {
      throw MnemonicError.generate("Could not generate a random number")
    }
    guard bytes.count == strength / 8 else {
      throw MnemonicError.generate("Not enough bytes in the random number")
    }
    
    return try generate(entropy: bytes)
  }
  
  static func generate(entropy bytes: Data, locale: Locale = Locale.current) throws -> Mnemonic {
    let wordlist = WordList(locale: locale)
    let checksum = deriveChecksumBits(buffer: bytes)
    let total = Binary(bytes: bytes.bytes + checksum)
    let numChunks = total.count / 11
    let chunks = (0 ..< numChunks).compactMap { (index) -> Int? in
      let start = index * 11
      let endIndex = start + 11
      let size = total.count
      let end = endIndex > size ? size : endIndex
      return total.bits(start ..< end)
    }
    
    let words = try wordlist.words(at: chunks)
    return Mnemonic(words: words)
  }
  
  static func deriveChecksumBits(buffer: Data) -> Data {
    let ent = buffer.count * 8
    let cs = ent / 32
    let hash = buffer.sha256
    let bin = Binary(data: hash)
    let bits = bin.bits(0 ..< cs)
    let shift = 8 - cs
    return Data([UInt8(bits << shift)])
  }
}
