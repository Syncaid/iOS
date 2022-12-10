//
//  GuardianEditViewController.swift
//  syncaid
//
//  Created by AhmedFatma on 3/12/2022.
//

import UIKit
import SwiftUI
import Foundation
import Alamofire

class GuardianProfileViewController: UIViewController {

    
    
    @IBOutlet weak var Firstname: UITextField!
    
    @IBOutlet weak var LastName: UITextField!
    
    @IBOutlet weak var PhoneNumber: UITextField!
    
    @IBOutlet weak var Age: UITextField!
    @ObservedObject var userViewModel = UserViewModel()

    
    @IBAction func SaveChanges(_ sender: Any) {
        let defaults = UserDefaults.standard
        let userid = defaults.object(forKey: "ID")
        let Firstname = Firstname.text!
        let Lastname = LastName.text!
        let Age = Age.text!
        let Tel = PhoneNumber.text!
        
        if ( Firstname.isEmpty || Lastname.isEmpty || Age.isEmpty || Tel.isEmpty) {
            
            
            self.showToast(message: "Missing or invalid information", font: .systemFont(ofSize: 12))
           
        }
        else {
            if (Age.containsOnlyDigits && Tel.containsOnlyDigits) {
                userViewModel.editprofile(ID: userid as! String, Firstname: Firstname, Lastname: Lastname, Tel: Tel, Age: Age, onSuccess: {
                    defaults.set(Firstname, forKey: "FIRSTNAME")
                    defaults.set(Lastname, forKey: "LASTNAME")
                    defaults.set(Tel, forKey: "TEL")
                    defaults.set(Age, forKey: "AGE")
                    defaults.synchronize()
                    
                    self.navigationController?.popViewController(animated: true)
                    
                }, onFailure: {
                    (errorMessage) in
                    LoginViewController().showToast(message: "Wrong information!", font: .systemFont(ofSize: 12))
                    print(errorMessage)
                })
            }
            else {
          
                self.showToast(message: "Age and Telephone must be numbers", font: .systemFont(ofSize: 12))
        }
    }
    
   
        
        
        
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        let fn = defaults.object(forKey: "FIRSTNAME")
        let ln = defaults.object(forKey: "LASTNAME")
        let telnb = defaults.object(forKey: "TEL")
        let ag = defaults.object(forKey: "AGE")
        self.navigationController?.navigationItem.hidesBackButton = false
     
        Firstname.text = fn as? String
        LastName.text = ln as? String
        PhoneNumber.text = telnb as? String
        Age.text = ag as? String

        // Do any additional setup after loading the view.
    }
    func showToast(message : String, font: UIFont) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 80, y: self.view.frame.size.height-350, width: 160, height: 25))
        toastLabel.backgroundColor = UIColor.red.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
