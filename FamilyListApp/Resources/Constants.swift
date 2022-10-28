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
            static let blockTitle = "Персональные данные"
            static let nameTitle = "Имя"
            static let ageTitle = "Возраст"
            static let namePlaceholder = "Полное (макс. 100)"
            static let agePlaceholder = "18 - 99"
        }
        enum Children {
            static let blockTitle = "Дети (макс. 5)"
            static let ageTitle = "Возраст"
            static let agePlaceholder = "0 - 18"
        }
        enum Buttons {
            static let addChild = "Добавить ребёнка"
            static let clearAll = "Очистить"
        }
        enum ClearAlert {
            static let title = "Есть введённые данные"
            static let message = "Вы уверены, что хотите сбросить их?"
            static let destructiveButton = "Сбросить данные"
            static let cancelButton = "Отмена"
        }
    }
    enum Value {
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
            static let halfBasic = CGFloat(10)
        }
        enum Button {
            static let cornerRadius = CGFloat(25)
            static let height = CGFloat(50)
            static let width = CGFloat(200)
            static let strokeWidth = CGFloat(2)
            static let colorAlpha = CGFloat(0.7)
            static let trashcanWidth = CGFloat(80)
            static let trashcanIcon = "trash"
            static let plusIcon = "plus"
        }
        enum TextField {
            static let fontSize = CGFloat(17)
            static let cornerRadius = CGFloat(5)
            static let borderWidth = CGFloat(1)
        }
    }
}
