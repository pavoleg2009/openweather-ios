//
//  NibInstantiatable.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 07.04.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import UIKit

protocol NibInstantiatable {
    static var nib: UINib { get }
}

extension NibInstantiatable {
    static var nib: UINib {
        UINib(nibName: String(describing: Self.self), bundle: nil)
    }
    
    static var nibName: String {
        return String(describing: Self.self)
    }
}
