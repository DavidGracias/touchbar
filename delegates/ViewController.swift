//
//  ViewController.swift
//  touchbar
//
//  Created by David Garcia on 3/29/22.
//

import Cocoa

class ViewController: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    
    override func loadView() {
        view = Canvas()
        view.awakeFromNib()
    }
    
}
