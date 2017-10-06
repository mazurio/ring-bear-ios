import UIKit
import Eureka

class SettingsViewController : FormViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createForm()
        
        self.title = "Settings"
    }
}

extension SettingsViewController {
    func createForm() {
        
        form
            +++ Section("About")
            <<< TextRow() {
                $0.title = "Name"
                $0.value = "Ring Bear"
                $0.disabled = true
            }
            <<< TextRow() {
                $0.title = "Version"
                $0.value = "1.0.0"
                $0.disabled = true
            }
            +++ Section("Author")
            <<< TextRow() {
                $0.title = "Name"
                $0.value = "Damian Mazurkiewicz"
                $0.disabled = true
            }
            <<< TextRow() {
                $0.title = "GitHub"
                $0.value = "https://github.com/mazurio/"
                $0.disabled = true
            }
    }
}
