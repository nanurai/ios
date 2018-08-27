//
//  WelcomeViewController.swift
//  Nanurai
//
//  Created by Elliott Minns on 25/08/2018.
//  Copyright © 2018 Nanurai. All rights reserved.
//

import UIKit
import Stevia

class WelcomeViewController: NanuraiViewController  {

  let imageView: UIImageView = UIImageView()
  
  let label: UILabel = UILabel()
  
  let newButton = NanuraiButton(withType: .standard)
  
  let restoreButton = NanuraiButton(withType: .standard)
  
  override func render() {
    super.render()
    view.sv(imageView,
            label,
            newButton,
            restoreButton)
    
    imageView.image = #imageLiteral(resourceName: "logo")
    imageView.centerHorizontally()
    imageView.heightEqualsWidth()
    imageView.height(120)
    imageView.contentMode = .scaleAspectFit
    
    label.text = "Nanurai Wallet"
    label.textColor = StyleGuide.Color.primary
    label.centerHorizontally()
    label.font = StyleGuide.Font.title()
   
    let buttonHeight: CGFloat = StyleGuide.Size.Button.height
    let margin = StyleGuide.Size.margin
    
    label.CenterY == view.CenterY
    imageView.Bottom == label.Top - margin

    newButton.centerHorizontally()
    newButton.height(buttonHeight)
    newButton.left(margin).right(margin)
    newButton.Top == label.Bottom + margin * 2
    newButton.setAttributedTitle("Create new Wallet")
    newButton.addTarget(
      self, action: #selector(newWalletPressed), for: .touchUpInside
    )

    restoreButton.centerHorizontally()
    restoreButton.height(buttonHeight)
    restoreButton.left(margin).right(margin)
    restoreButton.Top == newButton.Bottom + margin
    restoreButton.setAttributedTitle("Restore Wallet")
    restoreButton.addTarget(
      self, action: #selector(restorePressed), for: .touchUpInside
    )
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: animated)
  }
  
  @objc
  func newWalletPressed() {
    let controller = NewWalletController()
    navigationController?.pushViewController(controller, animated: true)
  }
  
  @objc
  func restorePressed() {
  }
}
