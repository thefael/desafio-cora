import UIKit

public extension Token {
    enum Color {
        case accentPink
        case white
        case accentBlue
        
        case lightGray
        case mediumLightGray
        case mediumDarkGray
        case darkGray
        
        var uiColor: UIColor {
            switch self {
            case .accentPink:
                return UIColor(hex: "#FE3E6D")
            case .white:
                return UIColor(hex: "#FFFFFF")
            case .accentBlue:
                return UIColor(hex: "#1A93DA")
            case .lightGray:
                return UIColor(hex: "#F0F4F8")
            case .mediumLightGray:
                return UIColor(hex: "#DEE4E9")
            case .mediumDarkGray:
                return UIColor(hex: "#6B7076")
            case .darkGray:
                return UIColor(hex: "#3B3B3B")
            }
        }
    }
}
