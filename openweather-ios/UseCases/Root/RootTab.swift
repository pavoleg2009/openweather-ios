//
//  RootTab.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 09.04.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import UIKit

enum RootTab: Int, CaseIterable {
    case list
    case grid
}

extension RootTab {
    
    var title: String {
        switch self {
        case .list: return "List View"
        case .grid: return "Grid View"
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .list: return UIImage(named: "list")
        case .grid: return UIImage(named: "grid")
        }
    }
}
