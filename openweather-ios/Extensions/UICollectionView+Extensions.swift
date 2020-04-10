//
//  UICollectionView+Extensions.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 07.04.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func owa_register<T: ReuseableView>(cellType: T.Type) {
        
        self.register(T.nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func owa_dequeueReusableCell<T: ReuseableView>(for indexPath: IndexPath) -> T {
        
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T
        else { fatalError("Can not dequeue cell with identifier: \(T.reuseIdentifier)") }
        return cell
    }
}
