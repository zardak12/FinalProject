//
//  ProfileViewInput.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 12.07.2021.
//

import UIKit

protocol ProfileViewInput: AnyObject {
//    func createAvaImage(with image: UIImage)
    func showAvaImage(with image: UIImage, with text: String)
    func showName(with name: String)
//    func createName(with name: String)
}
