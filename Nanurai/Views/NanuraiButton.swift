//
//  NanuraiButton.swift
//  Nanurai
//
//  Created by Elliott Minns on 25/08/2018.
//  Copyright © 2018 Nanurai. All rights reserved.
//

import UIKit
import Stevia

final class NanuraiButton: UIButton {
 
  enum ButtonType {
    case standard, info, warning, danger
    
    var textColor: UIColor {
      return StyleGuide.Color.white
    }
    
    var backgroundColor: UIColor {
      switch self {
      case .danger:
        return StyleGuide.Color.red
      default:
        return StyleGuide.Color.darkblue
      }
    }
  }
  
  override var isEnabled: Bool {
    didSet {
      titleLabel?.alpha = isEnabled ? 1.0 : 0.5
      super.isEnabled = isEnabled
    }
  }
  
  var title: NSAttributedString?
  let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
  
  var isLoading: Bool = false {
    didSet {
      guard oldValue != isLoading else { return }
      
      if isLoading {
        title = attributedTitle(for: .normal)
        setAttributedTitle("")
        activityIndicator.startAnimating()
      } else {
        setAttributedTitle(title, for: .normal)
        activityIndicator.stopAnimating()
      }
    }
  }
  
  init(withType type: ButtonType) {
    super.init(frame: .zero)
    
    layer.cornerRadius = StyleGuide.Size.Button.radius
    clipsToBounds = true
    
    titleLabel?.textColor = type.textColor
    titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)

    setBackgroundColor(color: type.backgroundColor, forState: .normal)
    setBackgroundColor(color: type.backgroundColor.darkerColor(percent: 0.2), forState: .highlighted)
    activityIndicator.hidesWhenStopped = true
    sv(activityIndicator)
    activityIndicator.centerInContainer()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setAttributedTitle(_ title: String?, withKerning kern: Double = 1.2) {
    guard let title = title else { return }
    let text = NSAttributedString(string: title, attributes: [.kern: kern])
    super.setAttributedTitle(text, for: .normal)
  }
  
}
