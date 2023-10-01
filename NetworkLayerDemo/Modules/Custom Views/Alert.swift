//
//  Alert.swift
//  NetworkLayerDemo
//
//  Created by Gaurav Bisht on 24/06/23.
//

import Foundation
import UIKit

protocol Alert {}

extension Alert where Self: UIViewController {
    
    func showAlertWithTryAgainButton(message: String, title: String? = nil, tryAgainAction: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let tryAgainAlertAction = UIAlertAction(title: TryAgain, style: .cancel) { action in
            tryAgainAction?()
        }
        
        alert.addAction(tryAgainAlertAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithOkButton(message: String, title: String? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: OK, style: .cancel)
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
}
