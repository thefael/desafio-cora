import UIKit

extension UIColor {
    convenience init(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        
        var rgbValue: UInt64 = 0
        guard Scanner(string: hexString).scanHexInt64(&rgbValue) else {
            self.init(red: 0, green: 0, blue: 0, alpha: 1.0)
            return
        }
        
        var alpha: CGFloat = 1.0
        var redValue: CGFloat = 0.0
        var greenValue: CGFloat = 0.0
        var blueValue: CGFloat = 0.0
        
        if hexString.count == 6 {
            redValue = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
            greenValue = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
            blueValue = CGFloat(rgbValue & 0x0000FF) / 255.0
        } else if hexString.count == 8 {
            redValue = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
            greenValue = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
            blueValue = CGFloat(rgbValue & 0x0000FF) / 255.0
            alpha = CGFloat((rgbValue & 0xFF000000) >> 24) / 255.0
        }
        
        self.init(red: redValue, green: greenValue, blue: blueValue, alpha: alpha)
    }
}
