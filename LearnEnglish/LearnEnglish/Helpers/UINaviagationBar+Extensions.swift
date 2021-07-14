//
//  UINaviagationBar+Extensions.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 13.07.2021.
//

import UIKit

extension UINavigationController {
    func setFontNavigationBar() {
        let attrs = [
              NSAttributedString.Key.foregroundColor: UIColor.white,
              NSAttributedString.Key.font: UIFont(name: "Rockwell-Bold", size: 30)
          ]
        UINavigationBar.appearance().titleTextAttributes = attrs as [NSAttributedString.Key : Any]
    }
}
