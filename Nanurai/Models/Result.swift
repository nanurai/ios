//
//  Result.swift
//  Nanurai
//
//  Created by Elliott Minns on 28/08/2018.
//  Copyright © 2018 Nanurai. All rights reserved.
//

import Foundation

enum Result<T> {
  case success(T)
  case failure(Error)
}
