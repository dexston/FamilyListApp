//
//  ParentModel.swift
//  FamilyListApp
//
//  Created by Admin on 25.10.2022.
//

import Foundation

struct Parent {
    
    var name: String = ""
    var age: String = ""
    
    var isFilled: Bool {
        name != "" && age != ""
    }
}
