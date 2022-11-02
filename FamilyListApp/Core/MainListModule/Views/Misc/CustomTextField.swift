//
//  TextField.swift
//  FamilyListApp
//
//  Created by Admin on 25.10.2022.
//

import UIKit

protocol CustomTextFieldDelegate: AnyObject {
    func update(value: String, for type: CustomTextField.TextFieldType)
}

class CustomTextField: UIStackView {
    
    enum TextFieldType: String {
        case name, olderAge, yangerAge
    }
    
    weak var delegate: CustomTextFieldDelegate?
    private var type: TextFieldType = .name
     
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(type: TextFieldType) {
        super.init(frame: .zero)
        self.type = type
        textField.delegate = self
        setupType()
        setupView()
    }
    
    private var labelTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: K.Value.TextField.fontSize, weight: .light)
        label.textColor = .systemGray
        return label
    }()
    
    private var textField: UITextField = {
        let field = UITextField()
        field.font = .systemFont(ofSize: K.Value.TextField.fontSize, weight: .light)
        return field
    }()
    
    private func setupView() {
        prepareForAutoLayout()
        addArrangedSubview(labelTitle)
        addArrangedSubview(textField)
        axis = .vertical
        layer.cornerRadius = K.Value.TextField.cornerRadius
        layer.borderWidth = K.Value.TextField.borderWidth
        layer.borderColor = UIColor.systemGray5.cgColor
        spacing = K.Value.halfBasicSpacing
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = UIEdgeInsets(top: K.Value.Margin.textFieldVertical,
                                     left: K.Value.Margin.textFieldHorizontal,
                                     bottom: K.Value.Margin.textFieldVertical,
                                     right: K.Value.Margin.textFieldHorizontal)
        textField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
    }
    
    private func setupType() {
        switch type {
        case .name:
            labelTitle.text = K.String.Parent.nameTitle
            textField.placeholder = K.String.Parent.namePlaceholder
        case .olderAge:
            labelTitle.text = K.String.Parent.ageTitle
            textField.placeholder = K.String.Parent.agePlaceholder
            textField.keyboardType = .numberPad
        case .yangerAge:
            labelTitle.text = K.String.Children.ageTitle
            textField.placeholder = K.String.Children.agePlaceholder
            textField.keyboardType = .numberPad
        }
    }
    
    func setValue(with string: String?) {
        textField.text = string
    }
    
    @objc private func textFieldDidChanged() {
        delegate?.update(value: textField.text ?? "", for: type)
    }
}

extension CustomTextField: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var maxNumberOfCharacters = K.Value.maxCharsName

        guard !string.isEmpty else { return true }
        
        if type == .name {
            if let _ = string.rangeOfCharacter(from: .decimalDigits) { return false }
        } else {
            maxNumberOfCharacters = K.Value.maxCharsAge
            if let _ = string.rangeOfCharacter(from: .decimalDigits.inverted) { return false }
        }
        
        if let text = textField.text, let range = Range(range, in: text) {
            let proposedText = text.replacingCharacters(in: range, with: string)
            guard proposedText.count <= maxNumberOfCharacters else { return false }
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if type != .name {
            if let enteredNumber = Int(textField.text!) {
                var validAge = enteredNumber
                switch type {
                case .olderAge:
                    if enteredNumber < K.Value.adulthood {
                        validAge = K.Value.adulthood
                    }
                case .yangerAge:
                    if enteredNumber > K.Value.adulthood {
                        validAge = K.Value.adulthood
                    }
                default:
                    break
                }
                textField.text = String(validAge)
            }
        }
        delegate?.update(value: textField.text ?? "", for: type)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
