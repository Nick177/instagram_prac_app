//
//  LoginViewController.swift
//  instagram_app
//
//  Created by Nicholas Rosas on 2/20/18.
//  Copyright © 2018 Nicholas Rosas. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("user log in failed: \(error.localizedDescription)")
            } else {
                print("user logged in sucessfully")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }

    @IBAction func onSignUp(_ sender: Any) {
        let newUser = PFUser()
        
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("created user")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }

}
