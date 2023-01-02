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
import PopupDialog
class PatientSettingsViewController: UIViewController {

    var IsDarkMode : Bool = false

    
    
    @IBAction func QRbutton(_ sender: Any) {
        self.performSegue(withIdentifier: "PatientQR", sender: self)
            
    }
    
    
    
    @IBAction func Switchbtn(_ sender: Any) {
        let appDelegate = UIApplication.shared.windows.first
       if( appDelegate?.overrideUserInterfaceStyle == .dark)
        {
           appDelegate?.overrideUserInterfaceStyle = .light
           overrideUserInterfaceStyle = .light
            IsDarkMode = false
        }
        else{ overrideUserInterfaceStyle = .dark
            appDelegate?.overrideUserInterfaceStyle = .dark
            IsDarkMode = true
       }
        
        
    
    }
    
    
    
    @IBOutlet weak var pic: UIImageView!
    
 
    @IBOutlet weak var fullname: UILabel!
    @IBOutlet weak var email: UILabel!
    @ObservedObject var userViewModel = UserViewModel()

    
    @IBAction func ManageGuardians(_ sender: UIButton) {
        self.performSegue(withIdentifier: "PatientManageGuardians", sender: self)
    }
    
    
    @IBAction func editprofile(_ sender: UIButton) {
        self.performSegue(withIdentifier: "PatientEditProfile", sender: self)
    }
    
    @IBAction func ChangePassword(_ sender: UIButton) {
        self.performSegue(withIdentifier: "PatientChangePassword", sender: self)
    }
    
    @IBAction func logout(_ sender: UIButton) {
        
        let defaults = UserDefaults.standard
        let userid = defaults.object(forKey: "ID")
        
        
        let title = "Are you sure"
        
        let message = "Do you really want to log out ?"
        
       

        // Create the dialog
        let popup = PopupDialog(title: title, message: message)

        // Create buttons
        let buttonOne = CancelButton(title: "Dismiss") {
          
        }
        let buttonTwo = DefaultButton(title: "Log out") {
            self.userViewModel.Logout(id: userid as! String, onSuccess: {
                
                let defaults = UserDefaults.standard
                defaults.set("", forKey: "ID")
                defaults.set("", forKey: "FIRSTNAME")
                defaults.set("", forKey: "LASTNAME")
                defaults.set("", forKey: "TEL")
                defaults.set("", forKey: "ROLE")
                defaults.set("" ,forKey: "VERIFIED")
                defaults.set("", forKey: "VSTRING")
                defaults.set(false, forKey:"LOGGEDIN")
                
                defaults.synchronize()
                self.performSegue(withIdentifier: "Logout", sender: self)
                
                
                
            },
                                 onFailure: {
                (errorMessage) in
                self.showToast(message: "Login failed", font: .systemFont(ofSize: 12))
                print(errorMessage)
                
            })
        }
        // This button will not the dismiss the dialog

        CancelButton.appearance().titleColor = .systemRed
        
      
        popup.addButtons([buttonOne,buttonTwo])

        // Present dialog
        self.present(popup, animated: true, completion: nil)
        
        
       
        
      
        
        
        
    }
    
    
    
    
    
    
    @IBOutlet weak var `switch`: UISwitch!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        let Email = defaults.object(forKey: "EMAIL")
        pic.layer.cornerRadius = pic.frame.width/2
       
        let Firstname = defaults.object(forKey: "FIRSTNAME")! as! String
        viewWillAppear(true)
        let Lastname = defaults.object(forKey: "LASTNAME")! as! String
       
        fullname.text = Firstname+" "+Lastname 
        email.text = Email as? String
        
        let profilephoto = defaults.object(forKey: "PROFILEPHOTO")
        let imageUrl = URL(string: profilephoto as! String)!
        let task = URLSession.shared.dataTask(with: imageUrl) {
            (data,response,error) in
            if let error = error {
                print(error)
                return
            }
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.pic.image = image
                }
            }
            
        }
        task.resume()
        
        
    }
    
    
    
    func showToast(message : String, font: UIFont) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 125, y: self.view.frame.size.height-130, width: 250, height: 35))
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
