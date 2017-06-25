//
//  LoginVC.swift
//  Gourmai
//
//  Created by Zack Esm on 6/24/17.
//  Copyright © 2017 Zack Esm. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth

class LoginVC: UIViewController {
    
    var loginButton: FBSDKLoginButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.purple
        
        setupViews()
        loginButton.delegate = self
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func setupViews() {
        let margins = view.layoutMarginsGuide
        let navBarHeight = self.navigationController?.navigationBar.frame.height
        let topMargin = navBarHeight! + 8
        
        loginButton = FBSDKLoginButton()
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("Log in with Facebook", for: .normal)
        loginButton.backgroundColor = UIColor.blue
        loginButton.layer.cornerRadius = 15
        view.addSubview(loginButton)
        
        loginButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 35).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -35).isActive = true
//        loginButton.heightAnchor.constraint(equalToConstant: 300)
        loginButton.centerYAnchor.constraint(equalTo: margins.centerYAnchor, constant: 35).isActive = true
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
//            // ...
//        }
//    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        Auth.auth().removeStateDidChangeListener(handle!)
//    }
    
}

extension LoginVC: FBSDKLoginButtonDelegate {
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("didCompleteWith: \(result)")
        if error != nil {
            showErrorAlert(vc: self, title: "Error Logging In", msg: "Please try again.")
        }
        
        guard let result = result else {
            showErrorAlert(vc: self, title: "Error Logging In", msg: "Please try again.")
            return
        }
        
        if result.isCancelled {
            return
        } else {
            //Logged In
            let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            Auth.auth().signIn(with: credential) { [weak self] (user, error) in
                if let error = error {
                    showErrorAlert(vc: self!, title: "Error Logging In", msg: "Please try again.")
                    return
                }
                // User is signed in
                guard let user = user, let facebookID = result.token.userID else {
                    print("Unable to identify user")
                    showErrorAlert(vc: self!, title: "Error", msg: "Unable to identify user. Please try again.")
                    return
                }
                let userData = [
                    "provider": credential.provider,
                    "id": facebookID,
                    "name": user.displayName
                ]
                DataService.ds.createFirebaseUser(uid: user.uid, facebookID: facebookID, user: userData as! Dictionary<String, String>)
                UserDefaults.standard.setValue(user.uid, forKey: KEY_UID)
                UserDefaults.standard.setValue(facebookID, forKey: KEY_FACEBOOKID)
                self?.navigationController?.pushViewController(HomeVC(), animated: true)
            }
            

        }
        
        
    }
    
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        print("Will Login")
        return true
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("logout")
    }
}
