import UIKit

public extension Token {
    struct TextStyle {
        let fontFamily: String = "Avenir"
        let fontSize: CGFloat
        let lineHeight: CGFloat
        
        static let header1: Self = .init(fontSize: 28, lineHeight: 38)
        static let title3: Self = .init(fontSize: 22, lineHeight: 32)
        static let body1: Self = .init(fontSize: 16, lineHeight: 24)
        static let body2: Self = .init(fontSize: 14, lineHeight: 20)
        static let caption: Self = .init(fontSize: 12, lineHeight: 20)
    }
}
