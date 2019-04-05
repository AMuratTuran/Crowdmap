//
//  LoginViewController.swift
//  Crowdmap
//
//  Created by Murat Turan on 5.03.2019.
//  Copyright © 2019 Murat Turan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import MBProgressHUD
import RAMAnimatedTabBarController
class LoginViewController: BaseViewController , UITextFieldDelegate, GIDSignInUIDelegate {
    
    @IBOutlet weak var emailTextField: LoginRegisterTextField!
    @IBOutlet weak var passwordTextField: LoginRegisterTextField!
    @IBOutlet weak var loginButton: UIImageView!
    @IBOutlet var content: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        loginButton.layer.cornerRadius = 10
        emailTextField.delegate = self
        passwordTextField.delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func loginAction(_ sender: Any) {
        showLoadingHUD()
        view.endEditing(true)
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error == nil{
                if (Auth.auth().currentUser?.isEmailVerified)! {
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let nextVC = storyBoard.instantiateViewController(withIdentifier: "TabBarController") as! RAMAnimatedTabBarController
                    self.present(nextVC, animated: true, completion: nil)
                    self.hideLoadingHUD()
                }else {
                    self.hideLoadingHUD()
                    let alertController = UIAlertController(title: "Error", message: "Please verifty your email", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                
            }
            else{
                self.hideLoadingHUD()
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
}


// Put this piece of code anywhere you like
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
