//
//  BaseViewContoller.swift
//  LearnEnglish
//
//  Created by OUT-Shneyderman-MY on 2/7/21.
//

import UIKit

class BaseViewController: UIViewController {

  // MARK: - Child
  private let spinner = SpinnerViewController()

  // MARK: - On/Off Spinner
  var isLoading = false {
    didSet {
      guard oldValue != isLoading else { return }
        showSpinner(isShown: isLoading)
    }
  }

    // MARK: - show Spinner

    func showSpinner(isShown: Bool) {
        if isShown {
            addChild(spinner)
            spinner.view.frame = view.frame
            view.addSubview(spinner.view)
            spinner.didMove(toParent: self)
        } else {
            spinner.willMove(toParent: nil)
            spinner.view.removeFromSuperview()
            spinner.removeFromParent()
        }
    }
  }
