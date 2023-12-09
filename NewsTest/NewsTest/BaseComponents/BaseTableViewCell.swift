import UIKit

class BaseTableViewCell: UITableViewCell {
    static var reuseId: String {
        return cellIdentifierForReg
    }

    static var cellIdentifierForReg: String {
        get {
            return String.init(describing: self)
        }
    }
}
