import RealmSwift

class Guest: Object {
    dynamic var name = ""
    dynamic var surname = ""
    
    dynamic var invited = false
    dynamic var acceptedInvitation = false
    dynamic var relationship = "mutual"
}
