//
//  RabbleBaseVC.swift
//  RabbleiOS
//
//  Created by PraveenKumar on 08/10/24.
//

import UIKit

class RabbleBaseVC: UIViewController {
    
    private let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidesWhenStopped = true
        return view
    }()
    
    func showAlert(title: String? = nil,
                   message: String?,
                   actions: [UIAlertAction] = []) {
        var alertActions = actions
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        if alertActions.isEmpty {
            let action = UIAlertAction(title: StringConstants.OK, style: UIAlertAction.Style.default)
            alertActions.append(action)
        }
        alertActions.forEach { eachAction in
            alertVC.addAction(eachAction)
        }
        present(alertVC, animated: true)
    }
    
    func showActivityIndicator() {
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        view.bringSubviewToFront(activityIndicator)
    }
    
    func dismissActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
    
}
