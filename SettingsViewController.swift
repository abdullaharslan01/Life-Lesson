//
//  SettingsViewController.swift
//  firebaseLearn
//
//  Created by abdullah on 18.02.2024.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func exitApp(_ sender: Any) {
        
        do {
                try  Auth.auth().signOut()
            performSegue(withIdentifier: "toViewController", sender: nil)
        }
        catch{
            
        }
        
       
      
    }
    

}
