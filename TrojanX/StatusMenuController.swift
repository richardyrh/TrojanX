//
//  StatusMenuController.swift
//  TrojanX
//
//  Created by RCD-Y on 6/11/19.
//  Copyright © 2020 RCD-Y. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObject {
    @IBOutlet weak var statusMenu: NSMenu!
    @IBOutlet weak var toggleItem: NSMenuItem!
    
    let enabledIcon = NSImage(named: "statusIcon")
    let disabledIcon = NSImage(named: "statusIconDisabled")
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    var aboutWindow: AboutWindowController!
    var modifiersPressed = false
    
    let resourcePath = Bundle.main.resourceURL!.path
    let confPath = FileManager().homeDirectoryForCurrentUser.path + "/Library/TrojanX/"
    
    var configNames: [String: String] = [:]
    var currentConfig = ""
    
    override func awakeFromNib() {
        statusItem.menu = statusMenu
        statusItem.button!.image = disabledIcon
        aboutWindow = AboutWindowController()
        statusMenu.autoenablesItems = false
        
        NSEvent.addGlobalMonitorForEvents(matching: [.flagsChanged, .keyDown]) {
            if ($0.modifierFlags.intersection(.deviceIndependentFlagsMask) == [.control, .shift]) {
                if ($0.keyCode == 17) {
                    // ctrl + shift + T
                    print("Toggle state")
                    self.toggleClicked(self)
                }
            }
        }
        
        
        do {
            let configPaths = try FileManager.default.contentsOfDirectory(atPath: confPath)
            for path in configPaths {
                if (path.hasSuffix(".json")) {
                    configNames[String(path.prefix(upTo: path.lastIndex(of: ".")!))] = path
                }
            }
            if (configNames.count > 0) {
                statusMenu.item(at: 2)!.isHidden = true
                for key in configNames.keys.sorted().reversed() {
                    let newItem = NSMenuItem(title: key, action: #selector(setConfig), keyEquivalent: "")
                    newItem.target = self
                    statusMenu.insertItem(newItem, at: 2)
                }
                statusMenu.item(at: 2)!.state = .on
                currentConfig = statusMenu.item(at: 2)!.title
            }
        } catch {
            print(error)
            do {
                try FileManager.default.createDirectory(atPath: confPath, withIntermediateDirectories: true)
                NSWorkspace.shared.openFile(confPath)
            } catch {}
        }
    }
    
    @objc func setConfig(sender: NSMenuItem!) {
        statusMenu.item(withTitle: currentConfig)!.state = .off
        currentConfig = sender.title
        sender.state = .on
        if (toggleItem.title.starts(with: "Stop")) {
            toggleItem.title = "Start Trojan"
            toggleClicked(self);
        }
    }
    
    func stopServices() {
        do {
            try Process.run(URL(fileURLWithPath: "/bin/bash"), arguments: [resourcePath + "/stop.sh"])
        } catch {}
    }
    
    @IBAction func toggleClicked(_ sender: Any) {
        if (toggleItem.title.starts(with: "Start")) {
            if (configNames[currentConfig] != nil) {
                toggleItem.title = "Stop Trojan"
                statusItem.button!.image = enabledIcon
                do {
                    try Process.run(URL(fileURLWithPath: "/bin/bash"), arguments: [resourcePath + "/start.sh", confPath, configNames[currentConfig]!])
                } catch {}
            }
        } else {
            toggleItem.title = "Start Trojan"
            statusItem.button!.image = disabledIcon
            stopServices()
        }
    }
    
    @IBAction func aboutClicked(_ sender: Any) {
        aboutWindow = AboutWindowController()
        aboutWindow.showWindow(nil)
    }
    
    @IBAction func quitClicked(_ sender: Any) {
        NSApplication.shared.terminate(self)
    }
}
