//
//  AppDelegate.swift
//  TrojanX
//
//  Created by RCD-Y on 6/11/19.
//  Copyright © 2019 RCD-Y. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var statusMenuController: StatusMenuController!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        statusMenuController.stopServices()
    }
}

