//
//  TouchBarDelegate.swift
//  touchbar
//
//  Created by David Garcia on 4/11/22.
//

import Cocoa

extension NSTouchBarItem.Identifier {
    static let touchbarIdentifier = NSTouchBarItem.Identifier("touchbarIdentifier")
}
extension AppDelegate: NSTouchBarDelegate, NSTouchBarProvider {
    var touchBar: NSTouchBar? {
        let bar = NSTouchBar()

        bar.delegate = self
        bar.defaultItemIdentifiers = [.touchbarIdentifier]

        return bar
    }

    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {
        switch identifier {
        case NSTouchBarItem.Identifier.touchbarIdentifier:
            let item = NSCustomTouchBarItem(identifier: .touchbarIdentifier)

            if self.touchbarView == nil {
                self.touchbarView = ViewController()
            }
            item.viewController = self.touchbarView
            
//            NSTouchBarItem.addSystemTrayItem(item)
            return item
        default: return nil
        }
    }
    
    func initTouchBar() {
        NSWorkspace.shared.notificationCenter.addObserver(self, selector: #selector(activeApplicationChanged), name: NSWorkspace.didLaunchApplicationNotification, object: nil)
        NSWorkspace.shared.notificationCenter.addObserver(self, selector: #selector(activeApplicationChanged), name: NSWorkspace.didTerminateApplicationNotification, object: nil)
        NSWorkspace.shared.notificationCenter.addObserver(self, selector: #selector(activeApplicationChanged), name: NSWorkspace.didActivateApplicationNotification, object: nil)
        
        if #available(OSX 10.14, *) {
            NSTouchBar.presentSystemModalTouchBar(self.touchBar, systemTrayItemIdentifier: .touchbarIdentifier)
        } else {
            NSTouchBar.presentSystemModalFunctionBar(self.touchBar, systemTrayItemIdentifier: .touchbarIdentifier)
        }
    }


    @objc func activeApplicationChanged(notification: Notification) {
        
        if let _ = notification.userInfo?["NSWorkspaceApplicationKey"] as? NSRunningApplication
        {
            // TODO: figure out how to make current touchbar the same as prev touchbar
//            if #available(OSX 10.14, *) {
//                NSTouchBar.presentSystemModalTouchBar(self.touchBar, systemTrayItemIdentifier: .touchbarIdentifier)
//            } else {
//                NSTouchBar.presentSystemModalFunctionBar(self.touchBar, systemTrayItemIdentifier: .touchbarIdentifier)
//            }
        }
    }

}
