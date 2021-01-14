//
//  PasswordConfiguration.swift
//  Guptapada
//
//  Created by Mehul Bhavani on 14/01/21.
//

import Cocoa

enum PasswordType {
    case Alphabets
    case Numerics
    case AlphaNumerics
    case Words
}

class PasswordConfiguration: NSObject {
    var length: Int = 12
    var count: Int = 3
    var type: PasswordType = .Words
    var allowSymbols: Bool = false
    var allowedSymbols: String?
    var separator: String = "-"
}
