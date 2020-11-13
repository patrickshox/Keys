//
//  SafariExtensionHandler.swift
//  Keys Extension
//
//  Created by Patrick Botros on 10/21/19.
//  Copyright © 2019 Patrick Botros. All rights reserved.
//

import SafariServices

let defaults = UserDefaults.init(suiteName: "L27L4K8SQU.shockerella")

class SafariExtensionHandler: SFSafariExtensionHandler {
    override func messageReceived(withName messageName: String, from page: SFSafariPage, userInfo: [String: Any]?) {
        defaults!.register(defaults: ["activationKey": "G"])
        defaults!.register(defaults: ["shouldStealFocus": true])
        defaults!.register(defaults: ["enableModifier": false])
        defaults!.register(defaults: ["blacklist": [String]()])
        let defaultKey = defaults!.string(forKey: "activationKey") ?? "G"
        let defaultPreferenceForFocusStealing = defaults?.bool(forKey: "shouldStealFocus") as Any
        let defaultPreferenceForEnablingModifierKey = defaults?.bool(forKey: "enableModifier") as Any
        let blacklist = (defaults?.array(forKey: "blacklist") as? [String])?.filter({!$0.isEmpty}) ?? [String]()
        let preferences = [
            "currentKey": defaultKey,
            "shouldStealFocus": defaultPreferenceForFocusStealing,
            "enableModifier": defaultPreferenceForEnablingModifierKey,
            "blacklist": blacklist
        ]
        if messageName == "refreshPreferences" {
            page.dispatchMessageToScript(withName: "updateOfPreferences", userInfo: preferences)
        }
        if messageName == "metaOpen" {
            let value = userInfo!["url"]
            if let string = value as? String {
                let url = URL(string: string)!
                SFSafariApplication.getActiveWindow { activeWindow in
                    activeWindow?.openTab(with: url, makeActiveIfPossible: false)
                }
            }
        }
    }
}
