//
//  MainListViewPresenter.swift
//  FamilyListApp
//
//  Created by Admin on 25.10.2022.
//

import Foundation

protocol MainListViewPresenterProtocol: AnyObject {
    init(view: MainListViewProtocol)
    var parent: Parent { get set }
    var childrens: [Child] { get set }
    var isClearButtonEnabled: Bool { get }
    var isAddButtonEnabled: Bool { get }
    func updateParent(with value: String, for type: CustomTextField.TextFieldType)
    func addChild()
    func updateChild(at index: Int, with value: String, for type: CustomTextField.TextFieldType)
    func deleteChild(at: Int)
    func clearAll()
}

class MainListViewPresenter: MainListViewPresenterProtocol {
    
    weak var view: MainListViewProtocol?
    
    var parent: Parent {
        didSet {
            view?.updateButtons()
        }
    }
    var childrens: [Child] {
        didSet {
            view?.updateButtons()
        }
    }
    
    var isClearButtonEnabled: Bool {
        parent.name != "" || parent.age != "" || !childrens.isEmpty
    }
    
    var isAddButtonEnabled: Bool {
        guard parent.isFilled,
              childrens.count < K.Value.maxChildCount
        else { return false }
        for child in childrens {
            if !child.isFilled {
                return false
            }
        }
        return true
    }
    
    required init(view: MainListViewProtocol) {
        self.view = view
        parent = Parent()
        childrens = []
    }
    
    func updateParent(with value: String, for type: CustomTextField.TextFieldType) {
        switch type {
        case .name:
            parent.name = value
        case .olderAge:
            parent.age = value
        default:
            return
        }
    }
    
    func addChild() {
        childrens.insert(Child(), at: .zero)
        view?.updateTable()
        view?.scrollToTop()
    }
    
    func updateChild(at index: Int, with value: String, for type: CustomTextField.TextFieldType) {
        switch type {
        case .name:
            childrens[index].name = value
        case .yangerAge:
            childrens[index].age = value
        default:
            return
        }
    }
    
    func deleteChild(at index: Int) {
        childrens.remove(at: index)
        view?.updateTable()
    }
    
    func clearAll() {
        parent = Parent()
        childrens = []
        view?.updateTable()
    }
}
