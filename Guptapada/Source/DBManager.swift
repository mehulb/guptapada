//
//  DBManager.swift
//  Guptapada
//
//  Created by Mehul Bhavani on 13/01/21.
//

import Cocoa
import SQLite

class DBManager: NSObject {
    static let `default`: DBManager = {
        let dbm = DBManager()
        dbm.setupDatabase()
        return dbm
    }()
    private override init() {}
    
    var database: Connection?
    
    func setupDatabase() -> Void {
        let searchPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let dir = searchPaths[0]
        let newPath = "\(dir)/words.sqlite3"
        print("\(newPath)")
        
        do {
            database = try Connection(newPath)
        }
        catch {
            print("\(error.localizedDescription)")
        }
        
        if FileManager.default.fileExists(atPath: newPath) {
            print("DB Exists. No need for setup")
            return
        }
        
        do {
            try FileManager.default.removeItem(atPath: newPath)
            print("Item Removed at \(newPath)")
        }
        catch {
            print("\(error.localizedDescription)")
        }
        
        do {
            if let db = database {
                let wordsTbl = Table("words")
                let wordCol = Expression<String>("word")
                try db.run(wordsTbl.create { t in
                    t.column(wordCol)
                })
                
                if let words = readWordsFromJSONFile() {
                    let stmt = try db.prepare("INSERT INTO words (word) VALUES (?)")
                    for w in words {
                        try stmt.run(w)
                    }
                }
            }
        }
        catch {
            print("\(error.localizedDescription)")
        }
    }
    func readWordsFromJSONFile() -> [String]? {
        if let path = Bundle.main.path(forResource: "words_dictionary", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? [String: Int] {
                    return Array(jsonResult.keys)
                }
            } catch {
                print("\(error.localizedDescription)")
            }
        }
        return nil
    }
    
    func randomWord() -> String {
        var word = ""
        do {
            if let db = database {
                for ele in try db.prepare("SELECT word FROM words ORDER BY RANDOM() LIMIT 1") {
                    if ele.count > 0 {
                        if let _word = ele[0] as? String {
                            word = _word
                        }
                    }
                }
            }
        } catch {
            print("\(error.localizedDescription)")
        }
        return word
    }
}
