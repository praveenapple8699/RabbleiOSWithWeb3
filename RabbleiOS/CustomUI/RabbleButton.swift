//
//  RabbleButton.swift
//  RabbleiOS
//
//  Created by PraveenKumar on 08/10/24.
//

import UIKit

enum RabbleButtonState {
    case disabled
    case enabled
}

protocol RabbleButtonDelegate: AnyObject {
    func onClick()
}

class RabbleButton: UIButton {
    
    var buttonState = RabbleButtonState.disabled {
        didSet {
            stateChanged()
        }
    }
    
    init(state: RabbleButtonState = RabbleButtonState.disabled) {
        super.init(frame: CGRect.zero)
        self.buttonState = state
        stateChanged()
        translatesAutoresizingMaskIntoConstraints = false
        let title = "Continue"
        setTitle(title, for: UIControl.State.normal)
        setTitle(title, for: UIControl.State.disabled)
        setTitleColor(UIColor.init(hex: "#0C0E0D"), for: UIControl.State.normal)
        layer.cornerRadius = 7
    }
    
    private func stateChanged() {
        isEnabled = buttonState == RabbleButtonState.enabled
        backgroundColor = isEnabled ? UIColor.init(hex: "#08F7AF") : UIColor.init(hex: "#8C8A93")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
