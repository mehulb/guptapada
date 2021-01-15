//
//  ViewController.swift
//  Guptapada
//
//  Created by Mehul Bhavani on 13/01/21.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet var pwdTestField: NSTextField?
    
    @IBOutlet var passwordTypePopUpButton: NSPopUpButton?
    @IBOutlet var countTextField: NSTextField?
    @IBOutlet var countStepper: NSStepper?
    @IBOutlet var countLabel: NSTextField?
    @IBOutlet var letterCasePopUpButton: NSPopUpButton?
    
    @IBOutlet var separatorCheckBox: NSButton?
    @IBOutlet var separatorPopUpButton: NSPopUpButton?
    @IBOutlet var separatorCharCountTextField: NSTextField?
    @IBOutlet var separatorStepper: NSStepper?
    
    var passType: PasswordType = .Words

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateStates()
    }
    
    func updateStates() {
        if passType == .Words {
            countStepper?.minValue = 3
            countStepper?.maxValue = 8
            countStepper?.doubleValue = countStepper!.minValue
            countLabel?.stringValue = "words"
            countTextField?.intValue = countStepper!.intValue
            letterCasePopUpButton?.isHidden = true
            
            separatorCheckBox?.state = .on
            separatorStepper?.minValue = 1
            separatorStepper?.doubleValue = 1
            separatorCharCountTextField?.intValue = separatorStepper!.intValue
            separatorCheckBox?.isEnabled = false
            separatorStepper?.isEnabled = false
            separatorCharCountTextField?.isEnabled = false
        }
        else {
            countStepper?.minValue = 8
            countStepper?.maxValue = 32
            countStepper?.doubleValue = countStepper!.minValue
            countLabel?.stringValue = "characters"
            countTextField?.intValue = countStepper!.intValue
            
            separatorCheckBox?.state = .on
            separatorStepper?.minValue = 3
            separatorStepper?.doubleValue = 3
            separatorCharCountTextField?.intValue = separatorStepper!.intValue
            separatorCheckBox?.isEnabled = true
            separatorStepper?.isEnabled = true
            separatorCharCountTextField?.isEnabled = true
            
            if passType == .Numerics {
                letterCasePopUpButton?.isHidden = true
            }
            else {
                letterCasePopUpButton?.isHidden = false
            }
        }
    }
    
    @IBAction func passwordTypePopUpButton_SelectionChanged(_ button: NSPopUpButton) {
        passType = PasswordType(rawValue: button.selectedTag())!
        
        updateStates()
    }
    
    @IBAction func separatorCheckBox_StateChanged(_ button: NSButton) {
        separatorStepper?.isEnabled = button.state == .on
        separatorCharCountTextField?.isEnabled = button.state == .on
        separatorPopUpButton?.isEnabled = button.state == .on
    }
    
    @IBAction func generateButton_Clicked(_ button: NSButton) {
        let config = PasswordConfiguration()
        config.count = Int(countStepper!.intValue)
        config.type = PasswordType(rawValue: passwordTypePopUpButton!.selectedTag())!
        config.allowSymbols = false
        config.allowedSymbols = nil
        config.addSeparator = separatorCheckBox!.state == .on
        config.separator = separatorPopUpButton!.selectedItem!.title
        config.separatorCharCount = Int(separatorStepper!.intValue)
        config.letterCase = LetterCase(rawValue: letterCasePopUpButton!.selectedTag())!
        
        
        if let pwd = PasswordGenerator.default.generate(withConfiguration: config) {
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

