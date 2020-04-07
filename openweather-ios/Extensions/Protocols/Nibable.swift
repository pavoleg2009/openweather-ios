//
//  Nibable.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 07.04.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import UIKit

protocol Nibable {
    static var nib: UINib { get }
}

extension Nibable where Self: ReuseIdentifiable {
    static var nib: UINib {
        UINib(nibName: reuseIdentifier, bundle: nil)
    }
}
