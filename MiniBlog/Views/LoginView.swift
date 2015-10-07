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
    func signOutButtonPressed()
    func continueButtonPressed()
}

class LoginView: BaseView {
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBOutlet weak var signOutButton: GIDSignInButton!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var delegate: LoginViewProtocol?
    
    @IBAction func signInButtonPressed(sender: AnyObject) {
        if self.delegate != nil && self.delegate?.signInButtonPressed != nil {
            self.delegate?.signInButtonPressed()
        }
    }
    
    @IBAction func signOutButtonPressed(sender: AnyObject) {
        if self.delegate != nil && self.delegate?.signOutButtonPressed != nil {
            self.delegate?.signOutButtonPressed()
        }
    }
    
    @IBAction func continueButtonPressed(sender: AnyObject) {
        if self.delegate != nil && self.delegate?.continueButtonPressed != nil {
            self.delegate?.continueButtonPressed()
        }
    }
}
