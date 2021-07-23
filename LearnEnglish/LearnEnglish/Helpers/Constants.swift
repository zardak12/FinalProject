//
//  Constants.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 11.07.2021.
//

import UIKit

enum NetworkConstant {
    static let imageUrl = """
        https://firebasestorage.googleapis.com/v0/b/englishword-9caad.appspot.com/o/av\
        a.jpg?alt=media&token=0135da8f-8a7d-4d95-9876-7c613d20d373
        """
    static let lessonURL = "https://englishword-9caad-default-rtdb.firebaseio.com/lessons.json"
}

enum UserDefaultKeys {
  static let  keyForName = "keyForName"
  static let  keyForAvaImage = "keyForAvaImage"
  static let  keyForAuthorImage = "keyForAuthorImage"
}

enum Constants {
    static let cornerRadius = CGFloat(8)
    static let reply = 50
}

  // MARK: - UIFont
enum Font {
    static let boldSystemFont = UIFont.boldSystemFont(ofSize: 25)
    static let helveticaBoldFont = UIFont(name: "Helvetica-Bold", size: 23)
    static let helveticaFont = UIFont(name: "Helvetica", size: 23)
    static let helveticaButtonFont = UIFont(name: "Helvetica", size: 20)
    static let profileImageFont = UIFont.boldSystemFont(ofSize: 20)
    static let profileNameFont = UIFont.boldSystemFont(ofSize: 30)
}

enum Colors {
    static let backgoundFill = UIColor(named: "backgroundFill")
    static let foregroundFill = UIColor(named: "foregroundFill")
    static let placeholderFill = UIColor(named: "placeholderFill")
    static let buttonFill = UIColor(named: "buttonFill")
}
