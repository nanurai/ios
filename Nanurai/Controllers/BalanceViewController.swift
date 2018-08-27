//
//  BalanceViewController.swift
//  Nanurai
//
//  Created by Elliott Minns on 15/08/2018.
//  Copyright © 2018 Elliott Minns. All rights reserved.
//

import UIKit

class BalanceViewController: NanuraiViewController {
  override func render() {
    super.render()
    title = "Balances"
    tabBarItem.image = #imageLiteral(resourceName: "pie-chart")
  }
}
