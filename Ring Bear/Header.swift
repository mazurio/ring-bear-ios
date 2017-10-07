import UIKit

class Header: UIView {
    @IBOutlet weak var title: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func update(settings: Settings) {
        var text = ""
        
        if (settings.groomName == "" && settings.brideName == "") {
            text = "Wedding Planner"
        } else if (settings.brideName == "" && settings.groomName != "") {
            text = "??? & \(settings.groomName)"
        } else if (settings.brideName != "" && settings.groomName == "") {
            text = "\(settings.brideName) & ???"
        } else {
            text = "\(settings.brideName) & \(settings.groomName)"
        }
        
        self.title.text = text
    }
}
