 

import UIKit

class RoundedButton: UIButton {

    // ----------------------------------
    //  MARK: - Init -
    //
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureCornerRadius()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.configureCornerRadius()
    }
    
    private func configureCornerRadius() {
        self.layer.cornerRadius  = 4.0
        self.layer.masksToBounds = true
    }
    
    // ----------------------------------
    //  MARK: - Selection -
    //
    override var isHighlighted: Bool {
        willSet(highlighted) {
            
            let scale: CGFloat
            if highlighted {
                scale = 0.9
            } else {
                scale = 1.0
            }
            
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [.beginFromCurrentState, .allowUserInteraction], animations: {
                self.layer.transform = CATransform3DMakeScale(scale, scale, scale)
            }, completion: nil)
        }
    }
}
