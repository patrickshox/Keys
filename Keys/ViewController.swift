import Cocoa
import SafariServices.SFSafariApplication

let defaults = UserDefaults.init(suiteName: SharedUserDefaults.suiteName)

class ViewController: NSViewController {
    @IBAction func reportPressed(_ sender: NSButton) {
        NSWorkspace.shared.open(NSURL(string: "https://github.com/patrickshox/Keys/issues")! as URL)
    }
    @IBOutlet var focusCheckbox: NSButton!
    @IBAction func focusCheckboxPressed(_ sender: Any) {
        if focusCheckbox!.state == .on {
            defaults?.set(true, forKey: "shouldStealFocus")
        }
        else {
            defaults?.set(false, forKey: "shouldStealFocus")
        }
    }
    override func viewDidAppear() {
        defaults!.register(defaults: ["activationKey" : "G"])
        // set the keycap's label and the label adjacent to the reset button to match the user's stored preference.
        customActivationKey.stringValue = defaults!.string(forKey: "activationKey")!
        secondaryLabelForCustomActivationKey.stringValue = customActivationKey.stringValue;
        // set the checkboxes state to match the user's stored preference.
        if (defaults?.bool(forKey: "shouldStealFocus"))! {
            focusCheckbox.state = .on
        }
        else {
            focusCheckbox.state = .off
        }
        self.customActivationKey.focusRingType = NSFocusRingType.none;
        customActivationKey.customizeCursorColor(NSColor.clear)
        customActivationKey.currentEditor()?.selectedRange = NSMakeRange(0, 0)
    }
    @IBOutlet weak var secondaryLabelForCustomActivationKey: NSTextField!
    @IBOutlet weak var customActivationKey: NSTextField!;
    @IBAction func openSafariExtensionPreferences(_ sender: AnyObject?) {
        SFSafariApplication.showPreferencesForExtension(withIdentifier: "shockerella.Keys.Extension") { error in
            if let _ = error {
                // Insert code to inform the user that something went wrong.
            }
        }
    }
    @IBAction func resetClicked(_ sender: Any) {
        customActivationKey.becomeFirstResponder()
        self.customActivationKey.selectAll(nil)
    }
}

extension String {
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
}

extension ViewController: NSTextFieldDelegate {
    func controlTextDidChange(_ obj: Notification) {
        if (self.customActivationKey.stringValue.count > 0 && String(self.customActivationKey.stringValue.last!).isAlphanumeric) {
            self.customActivationKey.stringValue = String(self.customActivationKey.stringValue.last!.uppercased())
        }
        else if (self.customActivationKey.stringValue.count == 0) {
            self.customActivationKey.stringValue = "G";
        }
        else if (String(self.customActivationKey.stringValue.first!).isAlphanumeric) {
            self.customActivationKey.stringValue = self.customActivationKey.stringValue.first!.uppercased()
        }
        else {
            self.customActivationKey.stringValue = "G"
        }
        secondaryLabelForCustomActivationKey.stringValue = self.customActivationKey.stringValue;
        defaults!.set(self.customActivationKey.stringValue, forKey: "activationKey");
        self.customActivationKey.moveToEndOfDocument(nil);
    }
}

extension NSTextField {
    public func customizeCursorColor(_ cursorColor: NSColor) {
        let fieldEditor = self.window?.fieldEditor(true, for: self) as! NSTextView
        fieldEditor.insertionPointColor = cursorColor
    }
}

