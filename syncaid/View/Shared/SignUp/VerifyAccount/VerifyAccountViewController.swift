//
//  VerifyAccountViewController.swift
//  syncaid
//
//  Created by AhmedFatma on 21/11/2022.
//

import UIKit
import Alamofire
import Foundation
import SwiftUI

class VerifyAccountViewController: UIViewController {

    @ObservedObject var userViewModel = UserViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func Leave(_ sender: UIButton) {
        let defaults = UserDefaults.standard
        let id = defaults.object(forKey: "ID")
        self.userViewModel.Logout(id: id as! String, onSuccess: {
            let defaults = UserDefaults.standard
            defaults.set("", forKey: "ID")
            defaults.set("", forKey: "FIRSTNAME")
            defaults.set("", forKey: "LASTNAME")
            defaults.set("", forKey: "TEL")
            defaults.set("", forKey: "ROLE")
            defaults.set("" ,forKey: "VERIFIED")
            defaults.set("", forKey: "VSTRING")
            defaults.synchronize()
            self.navigationController?.popToRootViewController(animated: true)
        },
                             onFailure: {
            (errorMessage) in
            
            print(errorMessage)
            
        })
    }
    
    @IBAction func gohomepage(_ sender: Any) {
        let defaults = UserDefaults.standard
        let email = defaults.object(forKey: "EMAIL")
        let id = defaults.object(forKey: "ID")
        AF.request(Variables.DEVURL+"/user/verificationemail", method: .post, parameters: ["Email":email!] , encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: EmailToken.self) {
                (response) in
                switch response.result {
                case .success(_):
                    print("Verification email sent")
                    let alert = UIAlertController(title: "Email sent", message: "A new verificaiton email has been sent", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Done", style: .default, handler:{ action in
                        self.userViewModel.Logout(id: id as! String, onSuccess: {
                            
                            defaults.set("", forKey: "ID")
                            defaults.set("", forKey: "FIRSTNAME")
                            defaults.set("", forKey: "LASTNAME")
                            defaults.set("", forKey: "TEL")
                            defaults.set("", forKey: "ROLE")
                            defaults.set("" ,forKey: "VERIFIED")
                            defaults.set("", forKey: "VSTRING")
                            defaults.synchronize()
                            self.navigationController?.popToRootViewController(animated: true)
                        },
                                             onFailure: {
                            (errorMessage) in
                            
                            print(errorMessage)
                            
                        })
                        self.navigationController?.popToRootViewController(animated: true)
                      
                                                  }))
                    
                    self.present(alert, animated: true)
                case .failure(let err):
                    print("Email sending failed",err)
                }
            }
        
        
        
      

    }
    
    
    
    }
   


