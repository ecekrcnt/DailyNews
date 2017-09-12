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
    @IBOutlet weak var txtField_confirmPass: UITextField!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var btn_loginOutlet: UIButton!
    @IBAction func segmentControl_Action(_ sender: Any) {
        if segmentControl.selectedSegmentIndex == 0 {
            btn_loginOutlet.setTitle("Login", for: .normal)
        }
        if segmentControl.selectedSegmentIndex == 1 {
            btn_loginOutlet.setTitle("Sign Up", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btn_login(_ sender: Any) {
        if txtField_email.text != "" && txtField_password.text != "" && txtField_confirmPass.text != "" {
            if segmentControl.selectedSegmentIndex == 0 {     //Login user
                Auth.auth().signIn(withEmail: txtField_email.text!, password: txtField_password.text!, completion: { (user, error) in
                    let isEmailAddressValid = self.isValidEmail(testStr:self.txtField_email.text!)
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
            } else { //Sign Up User
                Auth.auth().createUser(withEmail: txtField_email.text!, password: txtField_password.text!, completion: { (user, error) in
                    if(self.txtField_password.text! != self.txtField_confirmPass.text!) {
                        print("Error")
                    } else {
                        if user != nil {
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomePageVCID")
                            self.present(vc!, animated: true, completion: nil)
                            print("SUCCESS SIGN UP")
                            print(error?.localizedDescription)
                        } else {
                            if let myError = error?.localizedDescription {
                                print(myError)
                            } else {
                                print("ERROR SIGN UP")
                            }
                        }

                    }
                })
            }
        }
    }
    
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
}
