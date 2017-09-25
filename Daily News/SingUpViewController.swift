//
//  SingUpViewController.swift
//  Daily News
//
//  Created by Ece KARAÇANTA on 15/09/2017.
//  Copyright © 2017 Ece KARAÇANTA. All rights reserved.
//

import UIKit
import FirebaseAuth

class SingUpViewController: UIViewController {
    @IBOutlet weak var txtField_email: UITextField!
    @IBOutlet weak var txtField_pass: UITextField!
    @IBOutlet weak var txtField_confirmPass: UITextField!
    @IBAction func btn_singUp(_ sender: Any) {
        Auth.auth().createUser(withEmail: txtField_email.text!, password: txtField_pass.text!) { (user, error) in
            if (self.txtField_email.text! != "" && self.txtField_pass.text! != self.txtField_confirmPass.text!) {
                print("SİNG UP ERROR")
            }
            if (user != nil) {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomePageVCID")
                self.present(vc!, animated: true, completion: nil)
                print("SUCCESS")
            } else {
                if let myError = error?.localizedDescription {
                    print(myError)
                } else {
                    print("ERROR")
                }
            }
        }
    }
    
    @IBAction func btn_back(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVCID")
        self.present(vc!, animated: true, completion: nil)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
