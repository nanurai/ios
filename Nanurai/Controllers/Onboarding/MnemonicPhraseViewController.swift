//
//  MnemonicPhraseViewController.swift
//  Nanurai
//
//  Created by Elliott Minns on 26/08/2018.
//  Copyright © 2018 Nanurai. All rights reserved.
//

import UIKit
import Stevia

class MnemonicPhraseViewController: NanuraiViewController {
  
  let scrollView = UIScrollView()
  
  let nextButton = NanuraiButton(withType: .standard)
  
  let mnemonic: Mnemonic
  
  fileprivate var currentIndex: Int = 0
  
  init(mnemonic: Mnemonic) {
    self.mnemonic = mnemonic
    super.init()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func render() {
    super.render()

    let margin: CGFloat = 25
    view.sv(scrollView, nextButton)
    
    scrollView.isUserInteractionEnabled = false
    scrollView.left(0).right(0).top(0)
    scrollView.delegate = self

    nextButton.defaultHeight()
    nextButton.left(margin).right(margin).bottom(margin)
    nextButton.Top == scrollView.Bottom + margin
    nextButton.setAttributedTitle("Next Word")
    nextButton.addTarget(self, action: #selector(nextButtonPressed), for: UIControlEvents.touchUpInside)
    
    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height - (margin * 2 + StyleGuide.Size.Button.height)
    let words = mnemonic.words
    let views = words.enumerated().map { (index, word) -> UIView in
      let wordView = MnemonicWordView(word: word, number: index + 1)
      wordView.width(width)
      wordView.bottom(0).top(0).height(height)
      return wordView
    }
    
    scrollView.pageAlign(views: views)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: animated)
  }
  
  @objc
  func nextButtonPressed() {
    if currentIndex < mnemonic.words.count - 1 {
      currentIndex += 1
      let width = scrollView.frame.width
      let next = width * CGFloat(currentIndex)
      let offset = CGPoint(x: next, y: scrollView.contentOffset.y)
      scrollView.setContentOffset(offset, animated: true)
    } else {
      let alert = UIAlertController(
        title: "Are you ready?",
        message: "Have you written down all the words?",
        preferredStyle: .alert
      )
      alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
      alert.addAction(
        UIAlertAction(title: "Yes", style: .default, handler: { (action) in
          let controller = ConfirmMnemonicViewController(
            mnemonic: self.mnemonic
          )
          self.navigationController?.pushViewController(
            controller, animated: true
          )
        })
      )
    }
  }
}

extension MnemonicPhraseViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if currentIndex == mnemonic.words.count - 1 {
      nextButton.setAttributedTitle("Confirm")
    }
  }
}
