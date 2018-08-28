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
  
  fileprivate func list() throws -> [String] {
    let bundle = Bundle.main
    guard let path = bundle.url(forResource: filename, withExtension: "txt") else {
      throw WordListError.notFound
    }
    
    let data = try Data(contentsOf: path)
    guard let list = String(data:data, encoding: .utf8)?.split(separator: "\n") else {
      throw WordListError.notFound
    }
    return list.map { String($0) }
  }
  
  func words(at indexes: [Int]) throws -> [String] {
    let words = try list()
    return indexes.map { (index) -> String in
      return String(words[index])
    }
  }
  
  func index(of words: [String]) throws -> [Int] {
    let list = try self.list()
    return try words.map { word -> Int in
      guard let i = list.index(of: word) else { throw WordListError.notFound }
      return i
    }
  }
}
