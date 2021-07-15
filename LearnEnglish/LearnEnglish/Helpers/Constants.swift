//
//  Constants.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 11.07.2021.
//

import Foundation

enum NetworkConstant {
    static let imageUrl = """
    https://firebasestorage.googleapis.com/v0/b/englishword-9caad.appspot.com
    /o/ava.jpg?alt=media&token=0135da8f-8a7d-4d95-9876-7c613d20d373
    """
    static let lessonUrl = """
    https://firestore.googleapis.com/
    v1/projects/englishword-9caad/databases/(default)/documents/Lessons
    """
}

enum UserDefaultKeys {
  static let  keyForName = "keyForName"
  static let  keyForAvaImage = "keyForAvaImage"
  static let  keyForAuthorImage = "keyForAuthorImage"
}

enum Constants {
    static let reply = 50
}
