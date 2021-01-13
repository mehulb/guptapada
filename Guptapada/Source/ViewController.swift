//
//  ViewController.swift
//  Guptapada
//
//  Created by Mehul Bhavani on 13/01/21.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        DBManager.default.setupDatabase()
    }
}

