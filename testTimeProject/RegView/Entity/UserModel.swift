import Foundation
import UIKit

struct User {
    var name: String?
    var birthday: Date?
    var gender: Gender?
    var photo: UIImage?
}

public enum Gender {
    case male
    case female
    case other
}
