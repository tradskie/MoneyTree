//
//  UIViewController+Extensions.swift
//  MoneyTree
//
//  Created by Jack Xiong Lim on 5/4/22.
//

import UIKit
extension UIViewController {
    func topMostPresentedViewController() -> UIViewController? {
        guard let presentedViewController = presentedViewController else {
            return isBeingPresented ? self : nil
        }
        return presentedViewController.topMostPresentedViewController()
    }
    func showMessagePrompt(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: false, completion: nil)
      }
}
