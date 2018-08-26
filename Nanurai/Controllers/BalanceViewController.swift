//
//  BalanceViewController.swift
//  Nanurai
//
//  Created by Elliott Minns on 15/08/2018.
//  Copyright © 2018 Elliott Minns. All rights reserved.
//

import UIKit

class BalanceViewController: UIViewController {
  
  init() {
    super.init(nibName: nil, bundle: nil)
    render()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func render() {
    title = "Balances"
    tabBarItem.image = #imageLiteral(resourceName: "pie-chart")
    view.backgroundColor = UIColor.white
  }
}
