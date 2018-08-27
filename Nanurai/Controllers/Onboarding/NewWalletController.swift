//
//  NewWalletController.swift
//  Nanurai
//
//  Created by Elliott Minns on 26/08/2018.
//  Copyright © 2018 Nanurai. All rights reserved.
//

import UIKit
import Stevia

class NewWalletController: NanuraiViewController {
  
  let scroll = UIScrollView()
  
  let descriptionLabel = UILabel()

  let understandButton = NanuraiButton(withType: .danger)
  
  override func render() {
    super.render()
    
    title = "New Wallet"
    
    view.sv(
      scroll.sv(
        descriptionLabel
      ),
      understandButton
    )
    
    scroll.top(0).left(0).right(0)
    descriptionLabel.textColor = StyleGuide.Color.white
    descriptionLabel.numberOfLines = 0
    descriptionLabel.textAlignment = .justified
    
    descriptionLabel.text = """
    
  Next we will show you 24 words, one at a time
    
  Please write down these words down carefully and in order.
    
  Do not store them electronically and make sure they are kept in a safe place.
    
  Do not show this seed to anyone.
    
  If you lose this phrase you will not be able to access your Nano.
    
  Noone, including Nanurai, can recover your funds for you.
  """
    
    let margin: CGFloat = StyleGuide.Size.margin
    descriptionLabel.Width == view.Width - margin * 2
    descriptionLabel.left(margin).right(margin)
    descriptionLabel.font = UIFont.systemFont(ofSize: 22)
    
    understandButton.setAttributedTitle("I Understand")
    understandButton.left(margin).right(margin).bottom(margin)
    understandButton.Top == scroll.Bottom + margin
    understandButton.height(StyleGuide.Size.Button.height)
    understandButton.addTarget(
      self, action: #selector(understandPressed), for: .touchUpInside
    )
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.setNavigationBarHidden(false, animated: animated)
  }
  
  @objc
  func understandPressed() {
    do {
      let mnemonic = try Mnemonic()
      let controller = MnemonicPhraseViewController(mnemonic: mnemonic)
      navigationController?.pushViewController(controller, animated: true)
    } catch (let error) {
      print(error)
    }
  }
}
