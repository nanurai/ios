//
//  WordView.swift
//  Nanurai
//
//  Created by Elliott Minns on 26/08/2018.
//  Copyright © 2018 Nanurai. All rights reserved.
//

import UIKit
import Stevia

class MnemonicWordView: UIView {
  
  let word: String
  
  let number: Int
  
  let wordLabel = UILabel()
  
  let numberLabel = UILabel()
  
  init(word: String, number: Int) {
    self.word = word
    self.number = number
    super.init(frame: CGRect.zero)
    render()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
 
  func render() {
    sv(numberLabel, wordLabel)
    
    numberLabel.text = "\(number)"

    let attributedText = NSMutableAttributedString(string: word)
    let range = NSMakeRange(0, word.count)
    attributedText.addAttribute(NSAttributedStringKey.kern, value: 1.2, range: range)
    wordLabel.attributedText = attributedText
    
    numberLabel.font = UIFont.systemFont(ofSize: 28, weight: .light)
    numberLabel.textColor = StyleGuide.Color.white
    numberLabel.textAlignment = .center
    wordLabel.textColor = StyleGuide.Color.white
    wordLabel.font = UIFont.systemFont(ofSize: 64, weight: .light)
    wordLabel.textAlignment = .center
    wordLabel.minimumScaleFactor = 0.5
    
    
    wordLabel.centerInContainer()
    wordLabel.left(StyleGuide.Size.margin).right(StyleGuide.Size.margin)
    numberLabel.centerHorizontally()
    numberLabel.Left == wordLabel.Left
    numberLabel.Right == wordLabel.Right
    numberLabel.Bottom == wordLabel.Top - StyleGuide.Size.margin * 2
  }
  
}
