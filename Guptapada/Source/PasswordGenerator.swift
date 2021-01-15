//
//  PasswordGenerator.swift
//  Guptapada
//
//  Created by Mehul Bhavani on 14/01/21.
//

import Cocoa

let CAPITAL_LETTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
let SMALL_LETTERS = "abcdefghijklmnopqrstuvwxyz"
let NUMBERS = "0123456789"

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
            password = randomWords(withCount: configuration.count, separator: configuration.separator)
        } else {
            var letters = ""
            if configuration.type == .Numerics {
                letters.append(NUMBERS)
            } else {
                if configuration.letterCase == .Upper {
                    letters.append(CAPITAL_LETTERS)
                } else if configuration.letterCase == .Lower {
                    letters.append(SMALL_LETTERS)
                } else  {
                    letters.append(CAPITAL_LETTERS)
                    letters.append(SMALL_LETTERS)
                }
                if configuration.type == .AlphaNumerics {
                    letters.append(NUMBERS)
                }
            }
            
            password = randomString(withCharacters: letters, length: configuration.count)
            if configuration.addSeparator {
                password = password?.separate(every: configuration.separatorCharCount, with: configuration.separator[configuration.separator.startIndex] )
            }
        }
        
        return password
    }
    
    private func randomWords(withCount count: Int, separator: String) -> String {
        var words = [String]()
        for _ in 0..<count {
            words.append(DBManager.default.randomWord())
        }
        return words.joined(separator: separator)
    }
    private func randomString(withCharacters characters: String, length: Int) -> String {
        return String((0..<length).map{ _ in characters.randomElement()! })
    }
}

extension String {
    func separate(every stride: Int = 4, with separator: Character = " ") -> String {
        return String(enumerated().map { $0 > 0 && $0 % stride == 0 ? [separator, $1] : [$1]}.joined())
    }
}
