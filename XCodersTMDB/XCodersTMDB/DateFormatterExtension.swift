//
//  DateFormatterExtension.swift
//  XCodersTMDB
//
//  Created by Alberto Alegre Bravo on 8/8/23.
//

import Foundation

extension DateFormatter {
    static let dateFormat = {
        let date = DateFormatter()
        date.dateFormat = "yyyy-MM-dd"
        return date
    }()
}
