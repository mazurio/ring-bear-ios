import UIKit

class Header: UIView {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func update(settings: Settings) {
        var text = ""
        
        if (settings.groomName == "" && settings.brideName == "") {
            text = "What's the name of the Bride?"
        } else if (settings.brideName == "" && settings.groomName != "") {
            text = "What's the name of the Bride?"
        } else if (settings.brideName != "" && settings.groomName == "") {
            text = "What's the name of the Groom?"
        } else {
            text = "\(settings.brideName) & \(settings.groomName)"
        }
        
        self.title.numberOfLines = 2
        self.title.text = text
        
        if let weddingDate = settings.weddingDate {
            let calendar = NSCalendar.current
            
            let date1 = calendar.startOfDay(for: Date())
            let date2 = calendar.startOfDay(for: weddingDate)
            
            let components = calendar.dateComponents([.day], from: date1, to: date2)
            
            if let numberOfDaysTillWedding = components.day {
                text = ""
                if numberOfDaysTillWedding == 1 {
                    text = "Tomorrow is the wedding day!"
                } else if numberOfDaysTillWedding <= 0 {
                    text = "Congratulations!"
                } else {
                    text = "\(numberOfDaysTillWedding) days to go"
                }
                
                self.date.text = text
            }
        } else {
            self.date.text = "Remember to set your wedding date below."
        }
    }
}
