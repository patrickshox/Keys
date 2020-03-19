//
//  SafariExtensionHandler.swift
//  Keys Extension
//
//  Created by Patrick Botros on 10/21/19.
//  Copyright © 2019 Patrick Botros. All rights reserved.
//

import SafariServices

let defaults = UserDefaults.init(suiteName: SharedUserDefaults.suiteName)

class SafariExtensionHandler: SFSafariExtensionHandler {
    override func messageReceived(withName messageName: String, from page: SFSafariPage, userInfo: [String : Any]?) {
        if (messageName == "refreshPreferences") {
            page.dispatchMessageToScript(withName:"updateOfPreferences", userInfo: ["currentKey": defaults!.string(forKey: "activationKey") ?? "G", "shouldStealFocus": defaults!.bool(forKey: "shouldStealFocus")])
        }
    }
}
