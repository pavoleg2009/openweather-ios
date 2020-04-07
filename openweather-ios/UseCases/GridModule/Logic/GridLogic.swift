//
//  GridLogic.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 07.04.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import Foundation

final class GridLogic {
    
    weak var view: GridViewInput!
    
}

extension GridLogic: GridViewOutput {
    
    func activate() {
        print("!!! \(type(of: self)).\(#function): ")
    }
}
