import UIKit

extension UIViewController {
    
    func showAlert(
        title: String?,
        message: String,
        actionTitle: String = "Закрыть",
        handler: ((UIAlertAction) -> Void)? = nil
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: handler))
        self.present(alert, animated: true, completion: nil)
    }
}
