//
//  SignUpViewController.swift
//  Crowdmap
//
//  Created by Murat Turan on 5.03.2019.
//  Copyright © 2019 Murat Turan. All rights reserved.
//

import UIKit
import FirebaseAuth
import OnboardKit
import GoogleSignIn
import  NYAlertViewController

class SingUpViewController: BaseViewController {
    
    var onboardingPages:[OnboardPage] = []
    //  let onboardController = OnboardController()
    
    @IBOutlet weak var nameTextField: LoginRegisterTextField!
    @IBOutlet weak var emailTextField: LoginRegisterTextField!
    @IBOutlet weak var passwordTextField: LoginRegisterTextField!
    @IBOutlet weak var signupButton: LoginRegisterButton!
    
    
    @IBAction func signupAction(_ sender: Any) {
        
        showLoadingHUD()
        view.endEditing(true)
        var errorMessage: String?
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!){ (user, error) in
            if self.nameTextField.text == "" || self.emailTextField.text == "" || self.passwordTextField.text == "" {
                errorMessage = "Please fill all required areas!"
            }else if error == nil {
                let emailValid = self.checkEmailAddress(self.emailTextField.text!)
                if emailValid {
                    Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
                        if error != nil{
                            print(error!)
                        }else {
                            let alertController = UIAlertController(title: "Verify your email", message: "After verification you can login", preferredStyle: .alert)
                            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                let nextVC = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                                self.present(nextVC, animated: true, completion: nil)
                            })
                            alertController.addAction(defaultAction)
                            self.hideLoadingHUD()
                            self.present(alertController, animated: true, completion: nil)
                        }
                    })
                    
                    //  self.moveToOnboard()
                }else{
                    errorMessage = "Please enter your Koc University Email"
                    
                }
            }else{
                errorMessage = error?.localizedDescription
            }
            
            if errorMessage != nil{
                self.hideLoadingHUD()
                let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signupButton.layer.cornerRadius = 10
        
        configureUI()
        //        onboardingPages = onboardController.onboardingPages
        //
        //        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        //        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
    }
    
    //    @objc func keyboardWillShow(notification: NSNotification) {
    //        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
    //            if self.view.frame.origin.y == 0 {
    //                self.view.frame.origin.y -= keyboardSize.height / 2
    //            }
    //        }
    //    }
    //
    //    @objc func keyboardWillHide(notification: NSNotification) {
    //        if self.view.frame.origin.y != 0 {
    //            self.view.frame.origin.y = 0
    //        }
    //    }
    
    func moveToOnboard(){
        let onboardingVC = OnboardViewController(pageItems: onboardingPages)
        onboardingVC.modalPresentationStyle = .formSheet
        onboardingVC.presentFrom(self, animated: true)
    }
    
    func configureUI(){
        emailTextField.attributedPlaceholder = NSAttributedString(string: "  Enter your KU email address", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "  Enter password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        nameTextField.attributedPlaceholder = NSAttributedString(string: "  Enter your name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        passwordTextField.isSecureTextEntry = true
    }
    
    func checkEmailAddress(_ email: String) -> Bool {
        let delimiter = "@"
        var token = email.components(separatedBy: delimiter)
        let emailExtension = token[1]
        if emailExtension != "ku.edu.tr"{
            return false
        }else{
            return true
        }
    }
}

extension SingUpViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


