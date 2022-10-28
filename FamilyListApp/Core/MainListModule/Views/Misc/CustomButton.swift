//
//  CustomButton.swift
//  FamilyListApp
//
//  Created by Admin on 28.10.2022.
//

import UIKit

class CustomButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    var color: UIColor?
    
    init(title: String, color: UIColor) {
        super.init(frame: .zero)
        self.color = color
        setTitle(title, for: .normal)
        prepareForAutoLayout()
        configuration = .coloredOutline(with: color)
        heightAnchor.constraint(equalToConstant: K.Value.Button.height).isActive = true
        widthAnchor.constraint(greaterThanOrEqualToConstant: K.Value.Button.width).isActive = true
    }
}

extension CustomButton {
    override func updateConfiguration() {
        guard var configuration = configuration,
              let color = color
        else { return }
        
        var background = configuration.background
        
        let strokeColor: UIColor
        let foregroundColor: UIColor
        
        switch self.state {
        case .normal:
            strokeColor = color
            foregroundColor = color
        case .highlighted:
            strokeColor = color.withAlphaComponent(K.Value.Button.colorAlpha)
            foregroundColor = color.withAlphaComponent(K.Value.Button.colorAlpha)
        case .disabled:
            strokeColor = .systemGray
            foregroundColor = .systemGray
        default:
            strokeColor = color
            foregroundColor = color
        }
        
        background.strokeColor = strokeColor
        configuration.baseForegroundColor = foregroundColor
        configuration.background = background
        
        self.configuration = configuration
    }
}

extension UIButton.Configuration {
    public static func coloredOutline(with color: UIColor) -> UIButton.Configuration {
        var style = UIButton.Configuration.plain()
        var background = UIButton.Configuration.plain().background
        background.cornerRadius = K.Value.Button.cornerRadius
        background.strokeWidth = K.Value.Button.strokeWidth
        background.strokeColor = color
        style.baseForegroundColor = color
        style.background = background
        
        return style
    }
}
