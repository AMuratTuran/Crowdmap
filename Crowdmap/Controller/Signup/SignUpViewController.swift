//
//  SignUpViewController.swift
//  Crowdmap
//
//  Created by Murat Turan on 5.03.2019.
//  Copyright © 2019 Murat Turan. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import Firebase
import OnboardKit
import GoogleSignIn


class SingUpViewController: BaseViewController {
    
    var onboardingPages:[OnboardPage] = []
    var ref: DatabaseReference!
    
    //  let onboardController = OnboardController()
    
    @IBOutlet weak var nameTextField: LoginRegisterTextField!
    @IBOutlet weak var lastNameTextField: LoginRegisterTextField!
    @IBOutlet weak var emailTextField: LoginRegisterTextField!
    @IBOutlet weak var passwordTextField: LoginRegisterTextField!
    @IBOutlet weak var signupButton: LoginRegisterButton!
    let databaseManager = DatabaseManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        signupButton.layer.cornerRadius = 10
        self.hideKeyboardWhenTappedAround()
    }
    
    
    @IBAction func signupAction(_ sender: Any) {
        
        showLoadingHUD()
        view.endEditing(true)
        var errorMessage: String?
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!){ (user, error) in
            if self.nameTextField.text == "" || self.emailTextField.text == "" || self.passwordTextField.text == "" || self.lastNameTextField.text == "" {
                errorMessage = "Please fill all required areas!"
            }else if error == nil {
                let emailValid = self.checkEmailAddress(self.emailTextField.text!)
                let name = self.nameTextField.text
                let last = self.lastNameTextField.text
                self.ref.child("users").child(user?.user.uid ?? "").setValue(["first": name])
                self.ref.child("users").child(user?.user.uid ?? "").setValue(["last": last])
                
                if emailValid {
                    Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
                        if error != nil{
                            print(error!)
                        }else {
                            self.databaseManager.createUserAndSave(self.nameTextField.text!, self.lastNameTextField.text!, self.emailTextField.text! ) // save user to Firebase
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


