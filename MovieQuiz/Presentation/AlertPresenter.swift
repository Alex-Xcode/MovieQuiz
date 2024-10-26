//
//  AlertPresenter.swift
//  MovieQuiz
//

import Foundation
import UIKit

final class AlertPresenter {
    private weak var controller: UIViewController?
<<<<<<< HEAD

    init(controller: UIViewController) {
        self.controller = controller
    }

=======
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
>>>>>>> c4e6f38595fe571f5900ba578065e5cd2811bab8
    func showAlert(with model: AlertModel) {
        let alert = UIAlertController(
            title: model.title,
            message: model.message,
            preferredStyle: .alert
        )
<<<<<<< HEAD
=======
        alert.view.accessibilityIdentifier = "Alert"
        
>>>>>>> c4e6f38595fe571f5900ba578065e5cd2811bab8
        let action = UIAlertAction(title: model.buttonText, style: .default) { _ in
            model.completion?()
        }
        alert.addAction(action)
        controller?.present(alert, animated: true, completion: nil)
    }
}
