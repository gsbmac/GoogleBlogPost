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
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func signInButtonPressed() {
        // Initialize sign-in
//        var configureError: NSError?
//        GGLContext.sharedInstance().configureWithError(&configureError)
//        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        
//        GIDSignIn.sharedInstance().clientID = "226643800352-p8bveb0ebf5i5a72bi87ftdqib1cqfhn.apps.googleusercontent.com"
//        GIDSignIn.sharedInstance().delegate = self
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        // Uncomment to automatically sign in the user.
        //GIDSignIn.sharedInstance().signInSilently()
        
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
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self,
            name: "ToggleAuthUINotification",
            object: nil)
    }
    
    // [START toggle_auth]
    func toggleAuthUI() {
        if (GIDSignIn.sharedInstance().hasAuthInKeychain()){
            // Signed in
//            signInButton.hidden = true
//            signOutButton.hidden = false
//            disconnectButton.hidden = false
            self.performSegueWithIdentifier("loginToHomeSegue", sender: self)
        } else {
//            signInButton.hidden = false
//            signOutButton.hidden = true
//            disconnectButton.hidden = true
//            statusText.text = "Google Sign in\niOS Demo"
            self.performSegueWithIdentifier("loginToHomeSegue", sender: self)
        }
    }
    // [END toggle_auth]
    
    @objc func receiveToggleAuthUINotification(notification: NSNotification) {
        if (notification.name == "ToggleAuthUINotification") {
            self.toggleAuthUI()
            if notification.userInfo != nil {
//                let userInfo:Dictionary<String,String!> =
//                notification.userInfo as! Dictionary<String,String!>
//                self.statusText.text = userInfo["statusText"]
            }
        }
    }
}

