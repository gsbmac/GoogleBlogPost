//
//  LoginViewController.swift
//  MiniBlog
//
//  Created by Mac on 10/6/15.
//  Copyright © 2015 Seer Technologies, Inc. All rights reserved.
//

import UIKit
import CoreData

class LoginController: BaseController, LoginViewProtocol, GIDSignInUIDelegate {
    
    var loginView: LoginView?
    
    // MARK: Lifecycle method override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load Targeted Xibs
        self.loadXibName("LoginView")
        self.loginView = (self.view as! LoginView)
        self.loginView?.delegate = self
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        // Uncomment to automatically sign in the user.
        GIDSignIn.sharedInstance().signInSilently()
        
        // TODO(developer) Configure the sign-in button look/feel
        // [START_EXCLUDE]
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "receiveToggleAuthUINotification:",
            name: "ToggleAuthUINotification",
            object: nil)
        
        print("Initialized Swift app...")
        toggleAuthUI()
        // [END_EXCLUDE]
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func signInButtonPressed() {
        GIDSignIn.sharedInstance().signIn()
    }
    
    func signOutButtonPressed() {
        GIDSignIn.sharedInstance().signOut()
        // [START_EXCLUDE silent]
        self.loginView?.statusLabel.text = "Signed out."
        toggleAuthUI()
        // [END_EXCLUDE]
    }
    
    func continueButtonPressed() {
        self.performSegueWithIdentifier("loginToHomeSegue", sender: self)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self,
            name: "ToggleAuthUINotification",
            object: nil)
    }
    
    // [START toggle_auth]
    func toggleAuthUI() {
        if (GIDSignIn.sharedInstance().hasAuthInKeychain()){
            // Signed in
            self.loginView?.signInButton.hidden = true
            self.loginView?.signOutButton.hidden = false
            self.loginView?.continueButton.hidden = false
        } else {
            self.loginView?.signInButton.hidden = false
            self.loginView?.signOutButton.hidden = true
            self.loginView?.continueButton.hidden = true
            self.loginView?.statusLabel.text = "Google Sign In"
        }
    }
    // [END toggle_auth]
    
    @objc func receiveToggleAuthUINotification(notification: NSNotification) {
        if (notification.name == "ToggleAuthUINotification") {
            self.toggleAuthUI()
            if notification.userInfo != nil {
                let userInfo:Dictionary<String,String!> =
                notification.userInfo as! Dictionary<String,String!>
                self.loginView?.statusLabel.text = userInfo["statusText"]
            }
        }
    }
    
    // Implement these methods only if the GIDSignInUIDelegate is not a subclass of
    // UIViewController.
    
    // Stop the UIActivityIndicatorView animation that was started when the user
    // pressed the Sign In button
    func signInWillDispatch(signIn: GIDSignIn!, error: NSError!) {
        self.loginView?.activityIndicatorView.stopAnimating()
    }
    
    // Present a view that prompts the user to sign in with Google
    func signIn(signIn: GIDSignIn!,
        presentViewController viewController: UIViewController!) {
            self.presentViewController(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func signIn(signIn: GIDSignIn!,
        dismissViewController viewController: UIViewController!) {
            self.dismissViewControllerAnimated(true, completion: nil)
    }
}

