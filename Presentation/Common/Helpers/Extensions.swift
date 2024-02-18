import UIKit
public extension NSMutableAttributedString {
    @discardableResult func applyFont(_ font: UIFont) -> NSMutableAttributedString {
        addAttributes([ NSAttributedString.Key.font: UIFontMetrics.default.scaledFont(for: font)], range: NSRange(location: 0, length: string.count))
        return self
    }
}
