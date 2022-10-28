//
//  ChildrenHeader.swift
//  FamilyListApp
//
//  Created by Admin on 27.10.2022.
//

import UIKit

class ChildrenHeader: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = K.String.Children.blockTitle
        return label
    }()
    
    private let addButton = CustomButton(title: K.String.Buttons.addChild,
                                         color: .systemBlue)
    
    var addButtonAction: () -> () = { return } {
        didSet {
            addButton.addAction(UIAction {[weak self] _ in
                self?.addButtonAction()
            }, for: .touchUpInside)
        }
    }
    
    var isAddButtonEnabled: Bool = false {
        didSet {
            addButton.isEnabled = isAddButtonEnabled
        }
    }

    private func setupView() {
        prepareForAutoLayout()
        addArrangedSubview(titleLabel)
        addArrangedSubview(addButton)
        distribution = .fillProportionally
        backgroundColor = .systemBackground
        addButton.setImage(UIImage(systemName: K.Value.Button.plusIcon), for: .normal)
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = UIEdgeInsets(top: K.Value.Margin.basic,
                                     left: K.Value.Margin.basic,
                                     bottom: K.Value.Margin.halfBasic,
                                     right: K.Value.Margin.basic)
    }
}
