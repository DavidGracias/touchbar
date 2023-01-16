//
//  AppDelegate.swift
//  touchbar
//
//  Created by David Garcia on 3/29/22.
//

import Cocoa

let touchbarWidth: Double   = 685.0
let touchbarHeight: Double  = 30.0

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var touchbarView: ViewController!
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        self.initMenu()
        self.initTouchBar()
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return false
    }
    
    
}
