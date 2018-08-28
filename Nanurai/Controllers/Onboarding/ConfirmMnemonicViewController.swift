//
//  ConfirmMnemonicViewController.swift
//  Nanurai
//
//  Created by Elliott Minns on 26/08/2018.
//  Copyright © 2018 Nanurai. All rights reserved.
//

import UIKit
import Stevia

class ConfirmMnemonicViewController: NanuraiViewController {
 
  let mnemonic: Mnemonic
  
  static let challengeCount = 4
  
  let challenges: [Int]

  let scrollView = UIScrollView()
  
  let input = NanuraiTextField()
  
  let nextButton = NanuraiButton(withType: .standard)
  
  var currentChallenge: Int = 0 {
    didSet {
      let width = scrollView.frame.width
      let offset = CGPoint(
        x: scrollView.contentOffset.x + width, y: scrollView.contentOffset.y
      )
      scrollView.setContentOffset(offset, animated: true)
      input.text = nil

      if currentChallenge + 1 == challenges.count {
        nextButton.setAttributedTitle("Done")
      }
      
      nextButton.isEnabled = false
    }
  }
  
  var expected: String {
    return mnemonic.words[challenges[currentChallenge]]
  }

  init(mnemonic: Mnemonic) {
    self.mnemonic = mnemonic
    self.challenges = ConfirmMnemonicViewController.setupChallenges(for: mnemonic)
    super.init()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func render() {
    super.render()
    
    view.sv(scrollView, input, nextButton)
    
    scrollView.top(0).left(0).right(0).height(120)

    nextButton.isEnabled = false
    
    let margin = StyleGuide.Size.margin
    nextButton.bottom(margin).left(margin).right(margin)
    nextButton.defaultHeight()
    nextButton.setAttributedTitle("Next")
    nextButton.addTarget(
      self, action: #selector(nextButtonPressed(sender:)), for: .touchUpInside
    )

    let views = challenges.map { (object) -> UIView in
      return generateLabel(for: object)
    }
    
    scrollView.pageAlign(views: views)
    
    input.left(margin).right(margin).height(44)
    
    input.backgroundColor = UIColor.white
    input.layer.cornerRadius = StyleGuide.Size.Button.radius
    input.Top == scrollView.Bottom + margin
    input.textAlignment = .center
    input.font = UIFont.systemFont(ofSize: 24)
    input.autocapitalizationType = .none
    input.autocorrectionType = .no
    input.addTarget(
      self,
      action: #selector(onTextFieldUpdate(sender:)),
      for: UIControlEvents.editingChanged
    )
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: animated)
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillShow),
      name: NSNotification.Name.UIKeyboardWillShow,
      object: nil
    )
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    NotificationCenter.default.removeObserver(self)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    input.becomeFirstResponder()
  }
 
  static func setupChallenges(for mnemonic: Mnemonic) -> [Int] {
    var chosen = Set<Int>()
    
    var values: [Int] = []
    
    while chosen.count < challengeCount {
      let challenge = Int(arc4random_uniform(UInt32(mnemonic.words.count)))
      if !chosen.contains(challenge) {
        chosen.insert(challenge)
        values.append(challenge)
      }
    }
    
    return values
  }
  
  func generateLabel(for challenge: Int) -> UIView {
    let view = UIView()
    let descriptionLabel = UILabel()
    let width = UIScreen.main.bounds.width
    let margin = StyleGuide.Size.margin
    
    view.sv(descriptionLabel)
    
    descriptionLabel.numberOfLines = 0
    descriptionLabel.left(margin).right(margin)
    descriptionLabel.centerVertically()
    descriptionLabel.textAlignment = .center
    descriptionLabel.textColor = .white
    descriptionLabel.font = UIFont.systemFont(ofSize: 28, weight: .light)
    
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .ordinal
    let i = NSNumber(integerLiteral: challenge + 1)
    guard let num = numberFormatter.string(from: i) else { return view }
    descriptionLabel.text = "Please enter the \(num) word"
    
    view.height(120)
    view.width(width)
    
    return view
  }
  
  @objc
  func onTextFieldUpdate(sender: UITextField) {
    let word = mnemonic.words[challenges[currentChallenge]]
    nextButton.isEnabled = word.lowercased() == sender.text?.lowercased()
  }
  
  @objc
  func keyboardWillShow(_ notification: Notification) {
    if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
      let keyboardRectangle = keyboardFrame.cgRectValue
      let keyboardHeight = keyboardRectangle.height
      
      let curveValue = notification.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
      let durationValue = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber
      let duration = durationValue?.doubleValue ?? 0.5
      let animationCurveRaw = curveValue?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
      let animationCurve: UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
      
      nextButton.bottomConstraint?.constant = -(StyleGuide.Size.margin + keyboardHeight)
      self.view.setNeedsLayout()
      UIView.animate(
        withDuration: duration,
        delay: 0,
        options: animationCurve,
        animations: {
          self.view.layoutIfNeeded()
      }, completion: nil)
    }
  }
  
  @objc
  func nextButtonPressed(sender: NanuraiButton) {
    guard expected == input.text?.lowercased() else { return }
    if currentChallenge < challenges.count - 1 {
      currentChallenge += 1
    } else {
      nextButton.isEnabled = false
      KeyManager.shared.store(mnemonic: mnemonic)
      sender.isLoading = true
      AccountManager.shared.initial(loadFrom: mnemonic) {
        self.input.resignFirstResponder()
        self.navigationController?.dismiss(animated: true, completion: nil)
      }
    }
  }
}
