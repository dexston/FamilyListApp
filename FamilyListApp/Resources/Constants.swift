//
//  Constants.swift
//  FamilyListApp
//
//  Created by Admin on 27.10.2022.
//

import Foundation
import UIKit

enum K {
    enum String {
        enum Parent {
            static let blockTitle = "Personal data"
            static let nameTitle = "Name"
            static let ageTitle = "Age"
            static let namePlaceholder = "Short or Full name (max. 100)"
            static let agePlaceholder = "18 - 99"
        }
        enum Children {
            static let blockTitle = "Childrens (max. 5)"
            static let ageTitle = "Age"
            static let agePlaceholder = "0 - 18"
        }
        enum Buttons {
            static let addChild = "Add child"
            static let clearAll = "Clead all"
            static let trashCanIcon = "trash"
        }
        enum ClearAlert {
            static let title = "There is data entered"
            static let message = "Are you sure you want to delete everything?"
            static let destructiveButton = "Yes, delete all"
            static let cancelButton = "No, cancel"
        }
    }
    enum Value {
        static let textFieldFontSize = CGFloat(17)
        static let basicSpacing = CGFloat(20)
        static let halfBasicSpacing = CGFloat(10)
        static let reusableCellIdentifier = "cell"
        static let maxCharsName = 100
        static let maxCharsAge = 2
        static let maxChildCount = 5
        static let adulthood = 18
        enum Margin {
            static let textFieldHorizontal = CGFloat(15)
            static let textFieldVertical = CGFloat(10)
            static let basic = CGFloat(20)
            static let halfBasic = CGFloat(20)
        }
    }
}
