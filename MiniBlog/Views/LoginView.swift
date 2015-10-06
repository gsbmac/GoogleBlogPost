//
//  LoginView.swift
//  MiniBlog
//
//  Created by Mac on 10/6/15.
//  Copyright © 2015 Seer Technologies, Inc. All rights reserved.
//

import Foundation
import UIKit

protocol LoginViewProtocol {
    // class layered/connected to View Controller
    func signInButtonPressed()
}

class LoginView: BaseView {
    
    @IBOutlet weak var signInButton: UIButton!
    
    var delegate: LoginViewProtocol?
    
    @IBAction func signInButtonPressed(sender: AnyObject) {
        if self.delegate != nil && self.delegate?.signInButtonPressed != nil {
            self.delegate?.signInButtonPressed()
        }
    }
}
