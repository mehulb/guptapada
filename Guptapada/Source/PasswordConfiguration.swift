//
//  PasswordConfiguration.swift
//  Guptapada
//
//  Created by Mehul Bhavani on 14/01/21.
//

import Cocoa

enum PasswordType: Int {
    case Alphabets = 0
    case Numerics = 1
    case AlphaNumerics = 2
    case Words = 3
}
enum LetterCase: Int {
    case Upper = 0
    case Lower = 1
    case Mixed = 2
}

class PasswordConfiguration: NSObject {
    var count: Int = 3
    var type: PasswordType = .Words
    var allowSymbols: Bool = false
    var allowedSymbols: String?
    var addSeparator: Bool = true
    var separator: String = "-"
    var separatorCharCount: Int = 1
    var letterCase: LetterCase = .Mixed
}
