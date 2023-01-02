//
//  AllDoneViewController.swift
//  syncaid
//
//  Created by AhmedFatma on 22/11/2022.
//

import UIKit
import SwiftUI
import Foundation
import Alamofire

class AllDoneViewController: UIViewController {
    @ObservedObject var userViewModel = UserViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        // Do any additional setup after loading the view.
    }
    

    @IBAction func Homepage(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let GuardianMenu = storyboard.instantiateViewController(withIdentifier: "GuardianMenu")
        let PatientMenu = storyboard.instantiateViewController(withIdentifier: "PatientMenu")
        let VerifyAccount = storyboard.instantiateViewController(withIdentifier: "VerifyAccount")
        let defaults = UserDefaults.standard
        
        let email = defaults.object(forKey: "RegisteredEmail")
        let password = defaults.object(forKey: "RegisteredPassword")
       
        userViewModel.Login(Email: email as! String, Password: password as! String, onSuccess: {
            
            
            let Role = defaults.object(forKey: "ROLE")
            let Verified = defaults.object(forKey: "VERIFIED")
         
            if (Verified != nil ) {
                if (Role as! String == "Patient") {
                    self.navigationController?.pushViewController(PatientMenu, animated: true)
                }
                else {
                    self.navigationController?.pushViewController(GuardianMenu, animated: true)
                }
            }
            else {
                self.navigationController?.pushViewController(VerifyAccount, animated: true)
                
            }
            
            },
                            
                            onFailure: {
            (errorMessage) in
                LoginViewController().showToast(message: "Wrong information!", font: .systemFont(ofSize: 12))
                print(errorMessage)
                
        })
        
    }
    
    
}
