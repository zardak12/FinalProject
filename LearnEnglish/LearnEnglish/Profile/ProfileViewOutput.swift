//
//  ProfileViewOutput.swift
//  LearnEnglish
//
//  Created by Марк Шнейдерман on 12.07.2021.
//

import UIKit

protocol ProfileViewOutput: AnyObject {
    init(view: ProfileViewInput)
    func checkImage()
    func checkName()
    func saveImage(with image: UIImage)
    func saveName(with name: String)
}
