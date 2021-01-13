//
//  WindowController.swift
//  Guptapada
//
//  Created by Mehul Bhavani on 13/01/21.
//

import Cocoa

class WindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
        
        self.window?.standardWindowButton(.zoomButton)?.isHidden = true
        self.window?.standardWindowButton(.miniaturizeButton)?.isHidden = true
    }

}
