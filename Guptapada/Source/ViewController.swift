//
//  ViewController.swift
//  Guptapada
//
//  Created by Mehul Bhavani on 13/01/21.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet var pwdTestField: NSTextField?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func generateButton_Clicked(_ button: NSButton) {
        if let pwd = PasswordGenerator.default.generate(withConfiguration: nil) {
            pwdTestField?.stringValue = pwd
        }
    }
    @IBAction func copyButton_Clicked(_ button: NSButton) {
        if let pwd = pwdTestField?.stringValue {
            let pasteboardCopy = NSPasteboard.general
            pasteboardCopy.declareTypes([NSPasteboard.PasteboardType.string], owner: nil)
            pasteboardCopy.setString( pwd, forType: NSPasteboard.PasteboardType.string)
        }
    }
}

