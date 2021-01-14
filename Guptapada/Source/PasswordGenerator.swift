//
//  PasswordGenerator.swift
//  Guptapada
//
//  Created by Mehul Bhavani on 14/01/21.
//

import Cocoa

class PasswordGenerator: NSObject {
    static let `default` = PasswordGenerator()
    private override init() {}
    
    func generate(withConfiguration config: PasswordConfiguration?) ->String? {
        var password: String?
        var configuration = PasswordConfiguration()
        
        if let config = config {
            configuration = config
        }
        
        if configuration.type == .Words {
            var words = [String]()
            for _ in 0..<configuration.count {
                words.append(DBManager.default.randomWord())
            }
            password = words.joined(separator: configuration.separator)
        }
        
        return password
    }
}
