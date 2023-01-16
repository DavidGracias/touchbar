//
//  MenuDelegate.swift
//  touchbar
//
//  Created by David Garcia on 4/11/22.
//

import Cocoa

var menu_scene : Scene?
let menu_suffix = " Scene"

extension AppDelegate {
    
    func initMenu() {
        let menu = NSMenu()
        let touchbarMenu = NSMenuItem(title: "touchbar", action: nil, keyEquivalent: "")
        let scenes = NSMenu(title: "Change Scene")
                
        for key in sceneDict.keys {
            scenes.addItem(
                withTitle: key+menu_suffix,
                action: #selector(changeSceneTo(menuItem:)),
                keyEquivalent: ""
            )
        }
        
        touchbarMenu.submenu = scenes
        menu.addItem(touchbarMenu)
        NSApp.mainMenu = menu
    }
    
    
    @objc func changeSceneTo(menuItem: NSMenuItem) {
        var sceneKey: String = menuItem.title
        let range = sceneKey.range(of: menu_suffix)
        sceneKey = String(sceneKey[..<range!.lowerBound])

        menu_scene = sceneDict[sceneKey]
        touchbarView.view.awakeFromNib()
    }
    
    
    
    
    
}

