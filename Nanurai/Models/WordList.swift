//
//  WordList.swift
//  Nanurai
//
//  Created by Elliott Minns on 15/08/2018.
//  Copyright © 2018 Nanurai. All rights reserved.
//

import Foundation

enum WordListError: Error {
  case notFound
}

struct WordList {
  
  let filename: String
  
  init(locale: Locale = Locale.current) {
    guard let lang = locale.languageCode else {
      self.init(filename: "english")
      return
    }
    
    let filename: String
    switch lang {
    case "en": filename = "english"
    case "es": filename = "spanish"
    case "jp": filename = "japanese"
    case "it": filename = "italian"
    case "zh": filename = "chinese_simplified"
    case "zh-Hans": filename = "chinese_simplified"
    case "zh-Hant": filename = "chinese_traditional"
    case "ko": filename = "korean"
    case "fr": filename = "french"
    default: filename = "english"
    }
    
    self.init(filename: filename)
  }
  
  init(filename: String) {
    self.filename = filename
  }
  
  func words(at indexes: [Int]) throws -> [String] {
    let bundle = Bundle(identifier: "com.elliottminns.CoinKit")
    guard let path = bundle?.url(forResource: filename, withExtension: "txt") else {
      throw WordListError.notFound
    }
    
    let data = try Data(contentsOf: path)
    guard let words = String(data:data, encoding: .utf8)?.split(separator: "\n") else {
      throw WordListError.notFound
    }
    return indexes.map { (index) -> String in
      return String(words[index])
    }
  }
}
