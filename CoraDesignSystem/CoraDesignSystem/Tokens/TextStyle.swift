import UIKit

extension Token {
    public struct TextStyle {
        let fontFamily: String = "Avenir"
        let fontSize: CGFloat
        let lineHeight: CGFloat
        
        public static let header1: Self = .init(fontSize: 28, lineHeight: 38)
        public static let title3: Self = .init(fontSize: 22, lineHeight: 32)
        public static let body1: Self = .init(fontSize: 16, lineHeight: 24)
        public static let body2: Self = .init(fontSize: 14, lineHeight: 20)
        public static let caption: Self = .init(fontSize: 12, lineHeight: 20)
    }
}
