//
//  BlackListWindow.swift
//  Keys
//
//  Created by Patrick Botros on 5/4/20.
//  Copyright © 2020 Patrick Botros. All rights reserved.
//

import Cocoa

class BlackListWindowController: NSWindowController {

    class func loadFromNib() -> BlackListWindowController {
        return NSStoryboard(
            name: "Onboarding",
            bundle: nil
        ).instantiateController(withIdentifier: "BlackListWindowController") as? BlackListWindowController
    }

    @IBOutlet weak var addBlacklistedSite: NSToolbarItem!

}
