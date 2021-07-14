//
//  SpinnerViewController.swift
//  LearnEnglish
//
//  Created by OUT-Shneyderman-MY on 2/7/21.
//

import UIKit

final class SpinnerViewController : UIViewController {
  
  // MARK: - UI
  
  private lazy var  spiner : UIActivityIndicatorView  = {
    let spinner = UIActivityIndicatorView(style: .large)
    spinner.color = .white
    spinner.translatesAutoresizingMaskIntoConstraints = false
    spinner.startAnimating()
    return spinner
  }()
  
  // MARK: - Life Circle
  override func loadView() {
    view = UIView()
    view.backgroundColor = UIColor(named: "backgroundFill")
    view.addSubview(spiner)
    spinnerLayout()
  }
  
  // MARK: - Layout
  
  func spinnerLayout() {
    NSLayoutConstraint.activate([
      spiner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      spiner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }
  
}
