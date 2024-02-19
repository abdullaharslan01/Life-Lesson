//
//  ViewController.swift
//  firebaseLearn
//
//  Created by abdullah on 18.02.2024.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    @IBOutlet weak var xTextfieldEmail: UITextField!
    
    @IBOutlet weak var xTextFieldPassword: UITextField!
    
    @IBOutlet weak var xButtonLogin: UIButton!
    @IBOutlet weak var xButtonRegister: UIButton!
    @IBOutlet weak var xLogoImageController: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        settings()
        
        
        
    }
    
    @objc func closeKeyboard() {
        
        view.endEditing(true)
    }
    
    
    func settings() {
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeKeyboard)))
        
        
        xLogoImageController.image = .mainLogo
        
    }

    
    @IBAction func login(_ sender: Any) {
        if xTextfieldEmail.text != "" && xTextFieldPassword.text != "" {
            
            Auth.auth().signIn(withEmail: xTextfieldEmail.text!, password: xTextFieldPassword.text!) { authDataResult, error in
                if error != nil {
                    
        self.warningMessages(title: "Login Fail", message: error?.localizedDescription ?? "Please try again")
                }
                else {
                    
                    print(authDataResult?.user.uid ?? "")
                    
print(authDataResult?.user.email ?? "")
                    
                   
                
      self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                    
                    
                }
                
            }
        }
        
        else {
                 
                 warningMessages(title: "Emty Field", message: "Please fill in all fields")
                 
             }
    }
    
    
    @IBAction func register(_ sender: Any) {
        
        
        if xTextfieldEmail.text != "" && xTextFieldPassword.text != "" {
            
            Auth.auth().createUser(withEmail: xTextfieldEmail.text!, password: xTextFieldPassword.text!) {
                (authDataResult , error) in
                
                if error != nil {
                    
                    self.warningMessages(title: "Register Fail", message: error?.localizedDescription ?? "Please try again")
                }
                else {
          
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)

                    
                }
                
            }
            
        }
        
        else {
            
            warningMessages(title: "Emty Field", message: "Please fill in all fields")
            
        }
        
        
    }
    
    func warningMessages(title: String , message: String) {
        
        let warningMessages = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "OK", style: .default)
        
        warningMessages.addAction(okButton)
        
        self.present(warningMessages, animated: true)
        
        
    }
    
}

