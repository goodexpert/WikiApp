//
//  Image+Extension.swift
//  WikiApp
//
//  Created by Seongwuk Park on 15/07/22.
//

import SwiftUI

extension Image {
    enum Assets: String {
        case splash = "Splash"
    }
    
    init(name: Assets) {
        self.init(name.rawValue)
    }
}
