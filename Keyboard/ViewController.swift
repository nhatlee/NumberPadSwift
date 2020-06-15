//
//  ViewController.swift
//  Keyboard
//
//  Created by nhatle on 6/10/20.
//  Copyright © 2020 VNG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        textField.inputView = NumericKeyboard(target: textField)
        textField.becomeFirstResponder()
    }


}

