//
//  PatientProfileViewController.swift
//  syncaid
//
//  Created by AhmedFatma on 25/11/2022.
//

import UIKit
import SwiftUI

extension String {
    var containsOnlyDigits: Bool {
        let notDigits = NSCharacterSet.decimalDigits.inverted
        return rangeOfCharacter(from: notDigits, options: String.CompareOptions.literal, range: nil) == nil
    } }


class PatientProfileViewController: UIViewController {

    @IBOutlet weak var pic: UIImageView! {
        
           didSet {
               pic.image = UIImage(named: "ahmed4")
           }
       
    }
    @ObservedObject var userViewModel = UserViewModel()
    @IBOutlet weak var tel: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var lastname: UITextField!
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationItem.hidesBackButton = false
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pic.layer.cornerRadius = pic.frame.width/2
        let defaults = UserDefaults.standard
        let fn = defaults.object(forKey: "FIRSTNAME")
        let ln = defaults.object(forKey: "LASTNAME")
        let telnb = defaults.object(forKey: "TEL")
        let ag = defaults.object(forKey: "AGE")
        self.navigationController?.navigationItem.hidesBackButton = false
     
        firstname.text = fn as? String
        lastname.text = ln as? String
        tel.text = telnb as? String
        age.text = ag as? String
        
    }
    
    func textField(_ textField: UITextField,
      shouldChangeCharactersIn range: NSRange,
      replacementString string: String) -> Bool {
      
        let invalidCharacters =
        CharacterSet(charactersIn: "0123456789").inverted
        return (string.rangeOfCharacter(from: invalidCharacters) == nil) &&  range.location < 8    }
    
    @IBAction func save(_ sender: UIButton) {
        let defaults = UserDefaults.standard
        let userid = defaults.object(forKey: "ID")
        let Firstname = firstname.text!
        let Lastname = lastname.text!
        let Age = age.text!
        let Tel = tel.text!
        
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
    
    

    func showToast(message : String, font: UIFont) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 125, y: self.view.frame.size.height-205, width: 250, height: 35))
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

    
}
