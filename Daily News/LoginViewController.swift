//
//  ViewController.swift
//  Daily News
//
//  Created by Ece KARAÇANTA on 11/09/2017.
//  Copyright © 2017 Ece KARAÇANTA. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var txtField_email: UITextField!
    @IBOutlet weak var txtField_password: UITextField!
    @IBOutlet weak var btn_loginOutlet: UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btn_sing(_ sender: Any) {
        let vcId = self.storyboard?.instantiateViewController(withIdentifier: "SingUpVCID")
        self.present(vcId!, animated: true, completion: nil)
    }

    @IBAction func btn_login(_ sender: Any) {
        if (txtField_email.text != "" && txtField_password.text != "")  {
                Auth.auth().signIn(withEmail: txtField_email.text!, password: txtField_password.text!, completion: { (user, error) in
                    let isEmailAddressValid = isValidEmail(testStr:self.txtField_email.text!)
                    if isEmailAddressValid {
                        if user != nil {
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomePageVCID")
                            self.present(vc!, animated: true, completion: nil)
                            //Sign in successful
                            print("SUCCESS LOGIN")
                        }else {
                            if let myError = error?.localizedDescription {
                                print(myError)
                            } else {
                                print("ERROR")
                            }
                        }
                    }
                })
            }
        
        
        
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
        }
    }
}
