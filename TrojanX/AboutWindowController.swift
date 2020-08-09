//
//  AboutWindowController.swift
//  TrojanX
//
//  Created by Richard Yan on 6/12/19.
//  Copyright © 2019 Richard. All rights reserved.
//

import Cocoa

class AboutWindowController: NSWindowController {

    override var windowNibName: String! {
        return "AboutWindow"
    }

    override func windowDidLoad() {
        super.windowDidLoad()
        self.window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }
    
    @IBAction func openSettings(_ sender: Any) {
        NSWorkspace.shared.openFile(FileManager().homeDirectoryForCurrentUser.path + "/Library/TrojanX/")
    }
}
