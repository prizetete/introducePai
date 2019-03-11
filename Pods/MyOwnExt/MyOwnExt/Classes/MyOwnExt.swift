
import UIKit

public class MyOwnExt {
    
    
    
    
}

public extension UIView {
    public func setYellowBorder(fBorderWidth: CGFloat) {
        self.layer.borderWidth = fBorderWidth
        self.layer.borderColor = UIColor.yellow.cgColor
    }
    
    public func setGreenBorder() {
        self.layer.borderColor = UIColor.green.cgColor
        self.layer.borderWidth = 5.0
    }
}
