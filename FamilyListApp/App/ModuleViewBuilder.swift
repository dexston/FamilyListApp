//
//  ModuleViewBuilder.swift
//  FamilyListApp
//
//  Created by Admin on 24.10.2022.
//

import Foundation
import UIKit


class ModuleViewBuilder {
    static func createMainListModule() -> UIViewController {
        let view = MainListViewController()
        let presenter = MainListViewPresenter(view: view)
        view.presenter = presenter
        return view
    }
}

extension UIView {
    @discardableResult func prepareForAutoLayout() -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}
