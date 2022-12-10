//
//  SettingsViewController.swift
//  syncaid
//
//  Created by AhmedFatma on 25/11/2022.
//

import UIKit
import SwiftUI
import Foundation
import Alamofire

class PatientSettingsViewController: UIViewController {

    var IsDarkMode : Bool = false

    
    
    @IBAction func QRbutton(_ sender: Any) {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let QRcode = storyboard.instantiateViewController(withIdentifier: "QR")
            self.navigationController?.pushViewController(QRcode, animated: true)
            
    }
    
    
    
    @IBAction func Switchbtn(_ sender: Any) {
        
        if( overrideUserInterfaceStyle == .dark)
        { overrideUserInterfaceStyle = .light
            IsDarkMode = false
        }
        else{ overrideUserInterfaceStyle = .dark
            IsDarkMode = true
        }
    }
    
    
    
    
    
    @IBOutlet weak var pic: UIImageView!{
        
        didSet {
            pic.image = UIImage(named: "ahmed4")
        }
    
 }
    @IBOutlet weak var fullname: UILabel!
    @IBOutlet weak var email: UILabel!
    @ObservedObject var userViewModel = UserViewModel()

    
    @IBAction func ManageGuardians(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let manageguardians = storyboard.instantiateViewController(withIdentifier: "ManageGuardians")
        self.navigationController?.pushViewController(manageguardians, animated: true)
    }
    
    
    @IBAction func editprofile(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let editprofile = storyboard.instantiateViewController(withIdentifier: "EditPatient")
        self.navigationController?.pushViewController(editprofile, animated: true)
    }
    
    
    @IBAction func logout(_ sender: UIButton) {
        
        let defaults = UserDefaults.standard
        let userid = defaults.object(forKey: "ID")
        
        let alert = UIAlertController(title: "Are you sure ?", message: "Are you sure you want to log out", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Log out", style: .destructive, handler:{ action in
         
            self.userViewModel.Logout(id: userid as! String, onSuccess: {
                
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
                self.showToast(message: "Login failed", font: .systemFont(ofSize: 12))
                print(errorMessage)
                
            })
       
                                      }))
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        self.present(alert, animated: true)
        
      
        
        
        
    }
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        var Email = defaults.object(forKey: "EMAIL")
        pic.layer.cornerRadius = pic.frame.width/2
        var Firstname = defaults.object(forKey: "FIRSTNAME")!
        var Lastname = defaults.object(forKey: "LASTNAME")!
       
        fullname.text = Firstname as! String
        email.text = Email as! String
    }
    
    
    
    func showToast(message : String, font: UIFont) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 125, y: self.view.frame.size.height-100, width: 250, height: 35))
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
