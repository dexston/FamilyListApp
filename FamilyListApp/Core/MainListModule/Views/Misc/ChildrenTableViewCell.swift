//
//  ChildrenTableViewCell.swift
//  FamilyListApp
//
//  Created by Admin on 26.10.2022.
//

import UIKit

class ChildrenTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    var child: Child = Child() {
        didSet {
            nameField.setValue(with: child.name)
            ageField.setValue(with: child.age)
        }
    }
    var updateAction: (UITableViewCell, String, CustomTextField.TextFieldType) -> () = { _, _, _ in return }
    
    private let nameField = CustomTextField(type: .name)
    private let ageField = CustomTextField(type: .yangerAge)
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.prepareForAutoLayout()
        button.setImage(UIImage(systemName: K.String.Buttons.trashCanIcon), for: .normal)
        return button
    }()
    
    private let fieldStack: UIStackView = {
        let stack = UIStackView()
        stack.prepareForAutoLayout()
        stack.axis = .vertical
        stack.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 0)
        stack.spacing = 10
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    private func setupView() {
        selectionStyle = .none
        contentView.addSubview(fieldStack)
        contentView.addSubview(deleteButton)
        fieldStack.addArrangedSubview(nameField)
        fieldStack.addArrangedSubview(ageField)
        setupConstraints()
        nameField.delegate = self
        ageField.delegate = self
    }
    
    
    private func setupConstraints() {
        let constraints = [
            fieldStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            fieldStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            fieldStack.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
            //
            deleteButton.leadingAnchor.constraint(equalTo: fieldStack.trailingAnchor),
            deleteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            deleteButton.widthAnchor.constraint(equalToConstant: 80)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func setDeleteAction(_ action: @escaping (UITableViewCell) -> ()) {
        deleteButton.addAction(UIAction {[weak self] _ in
            guard let self = self else { return }
            action(self)
        }, for: .touchUpInside)
    }
    
    func setUpdateAction(_ action: @escaping (UITableViewCell, String, CustomTextField.TextFieldType) -> ()) {
        updateAction = action
    }
}

extension ChildrenTableViewCell: CustomTextFieldDelegate {
    func update(value: String, for type: CustomTextField.TextFieldType) {
        updateAction(self, value, type)
    }
}
