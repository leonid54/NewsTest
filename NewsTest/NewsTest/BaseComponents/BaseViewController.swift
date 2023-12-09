import UIKit

class BaseViewController: UIViewController {
        
    init(usingNib: Bool = true) {
        super.init(nibName: usingNib ? "\(type(of: self))" : nil,
                   bundle: usingNib ?  Bundle.main : nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
