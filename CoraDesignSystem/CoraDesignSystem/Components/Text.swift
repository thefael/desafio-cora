import UIKit

final public class Text: UILabel {
    public typealias Style = Token.TextStyle
    private var textStyle: Style = .body1 {
        didSet {
            guard text != nil else { return }
            configureText()
        }
    }
    private var isBold = false
    override public var text: String? {
        didSet {
            configureText()
        }
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @discardableResult
    public func style(_ style: Style) -> Self {
        self.textStyle = style
        return self
    }
    
    @discardableResult
    public func bold() -> Self {
        isBold = true
        return self
    }
    
    @discardableResult
    public func numberOfLines(_ number: Int) -> Self {
        numberOfLines = number
        return self
    }
}

extension Text {
    func configureText() {
        applyTextStyle()
        applyBoldIfNeeded()
    }
    
    func applyTextStyle() {
        font = UIFont(
            name: textStyle.fontFamily,
            size: textStyle.fontSize
        )
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = textStyle.lineHeight
        paragraphStyle.maximumLineHeight = textStyle.lineHeight
        
        let attributedText = NSMutableAttributedString(string: text ?? "")
        attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedText.length))
        
        self.attributedText = attributedText
    }
    
    func applyBoldIfNeeded() {
        guard let fontDescriptor = font?.fontDescriptor,
            let boldDescriptor = fontDescriptor.withSymbolicTraits(.traitBold),
            isBold
        else {
            return
        }
        let boldFont = UIFont(descriptor: boldDescriptor, size: textStyle.fontSize)
        self.font = boldFont
    }
}
