//
//  UITableView+Extensions.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 07.04.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import UIKit

extension UITableView {
    
    func owa_register<T: ReusableView>(_ cellType: T.Type) {
        
        self.register(T.nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func owa_dequeueReusableCell<T: ReusableView>(for indexPath: IndexPath) -> T {
        
        guard let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T
        else { fatalError("Can not dequeue cell with identifier: \(T.reuseIdentifier)") }
        return cell
    }
}
