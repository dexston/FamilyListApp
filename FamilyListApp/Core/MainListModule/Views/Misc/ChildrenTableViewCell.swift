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
        button.configuration = .plain()
        button.setImage(UIImage(systemName: K.Value.Button.trashcanIcon), for: .normal)
        button.configuration?.baseForegroundColor = .systemRed
        return button
    }()
    
    private let fieldStack: UIStackView = {
        let stack = UIStackView()
        stack.prepareForAutoLayout()
        stack.axis = .vertical
        stack.spacing = K.Value.halfBasicSpacing
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: K.Value.Margin.halfBasic,
                                           left: K.Value.Margin.basic,
                                           bottom: K.Value.Margin.halfBasic,
                                           right: .zero)
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
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -K.Value.basicSpacing),
            deleteButton.widthAnchor.constraint(equalToConstant: K.Value.Button.trashcanWidth)
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
