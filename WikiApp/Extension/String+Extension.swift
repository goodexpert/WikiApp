//
//  String+Extension.swift
//  WikiApp
//
//  Created by Seongwuk Park on 17/07/22.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
