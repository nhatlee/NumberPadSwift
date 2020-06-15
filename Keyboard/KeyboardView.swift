//
//  KeyboardView.swift
//  Keyboard
//
//  Created by nhatle on 6/10/20.
//  Copyright © 2020 VNG. All rights reserved.
//

import Foundation
import UIKit

class DigitButton: UIButton {
    var digit: Int = 0
}

class NumericKeyboard: UIView {
    weak var target: (UIResponder & UIKeyInput)?

    var numericButtons: [DigitButton] = (0...9).map {
        let button = DigitButton(type: .system)
        button.digit = $0
        button.setTitle("\($0)", for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .largeTitle)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.lightGray.cgColor
//        button.layer.
        button.accessibilityTraits = [.keyboardKey]
        button.addTarget(self, action: #selector(didTapDigitButton(_:)), for: .touchUpInside)
        return button
    }
    
    var doneButton: UIButton = {
       let button = UIButton(type: .system)
        button.setTitle("Xong", for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .largeTitle)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.accessibilityTraits = [.keyboardKey]
        button.addTarget(self, action: #selector(didTabDoneButton(_:)), for: .touchUpInside)
        return button
    }()

    var hideKeyboardButton: UIButton = {
       let button = UIButton(type: .system)
        button.setImage(UIImage(named: "ic_keyboard"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.accessibilityTraits = [.keyboardKey]
        button.addTarget(self, action: #selector(didTabHiddenButton(_:)), for: .touchUpInside)
        return button
    }()

    var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("⌫", for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .largeTitle)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.accessibilityTraits = [.keyboardKey]
        button.accessibilityLabel = "Delete"
        button.addTarget(self, action: #selector(didTapDeleteButton(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var threeZeroButton: UIButton = {
           let button = UIButton(type: .system)
           button.setTitle("000", for: .normal)
           button.titleLabel?.font = .preferredFont(forTextStyle: .largeTitle)
           button.setTitleColor(.black, for: .normal)
           button.layer.borderWidth = 0.5
           button.layer.borderColor = UIColor.lightGray.cgColor
           button.accessibilityTraits = [.keyboardKey]
           button.addTarget(self, action: #selector(didTapThreeZeroButton(_:)), for: .touchUpInside)
           return button
       }()
       
       

    init(target: (UIResponder & UIKeyInput)) {
        self.target = target
        super.init(frame: .zero)
        self.backgroundColor = .white
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Actions

extension NumericKeyboard {
    @objc func didTabHiddenButton(_ sender: DigitButton) {
        target?.resignFirstResponder()
    }

    @objc func didTabDoneButton(_ sender: DigitButton) {
        target?.resignFirstResponder()
    }
    
    @objc func didTapDigitButton(_ sender: DigitButton) {
        target?.insertText("\(sender.digit)")
    }

    @objc func didTapThreeZeroButton(_ sender: DigitButton) {
        target?.insertText("000")
    }

    @objc func didTapDeleteButton(_ sender: DigitButton) {
        target?.deleteBackward()
    }
}

// MARK: - Private initial configuration methods

private extension NumericKeyboard {
    func configure() {
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addButtons()
    }

    func addButtons() {
//        Main stack view
        let mainStackView = createStackView(axis: .horizontal)
        mainStackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(mainStackView)

        // Number in the center
        let stackView = createStackView(axis: .vertical)
        stackView.frame = bounds
        stackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mainStackView.addArrangedSubview(stackView)

        for row in 0 ..< 3 {
            let subStackView = createStackView(axis: .horizontal)
            stackView.addArrangedSubview(subStackView)

            for column in 0 ..< 3 {
                subStackView.addArrangedSubview(numericButtons[row * 3 + column + 1])
            }
        }

        // Bottoms: 000, hide, 0
        let subStackView = createStackView(axis: .horizontal)
        subStackView.addArrangedSubview(threeZeroButton)
        stackView.addArrangedSubview(subStackView)
        subStackView.addArrangedSubview(numericButtons[0])
        subStackView.addArrangedSubview(hideKeyboardButton)

         // Right
                let stackActionView = createStackView(axis: .vertical)
                stackActionView.frame = bounds
                stackActionView.addArrangedSubview(deleteButton)
        stackActionView.addArrangedSubview(doneButton)
                stackActionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mainStackView.addArrangedSubview(stackActionView)
        
    }

    func createStackView(axis: NSLayoutConstraint.Axis) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }
}
