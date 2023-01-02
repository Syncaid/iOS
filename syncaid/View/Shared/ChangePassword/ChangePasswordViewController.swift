//
//  ChangePasswordViewController.swift
//  syncaid
//
//  Created by AhmedFatma on 27/12/2022.
//

import UIKit
import SwiftUI

class ChangePasswordViewController: UIViewController{
   
    @ObservedObject var userViewModel = UserViewModel()
    
    
    @IBOutlet weak var Oldpass: UITextField!
    
    @IBOutlet weak var Newpass: UITextField!
    
    @IBOutlet weak var Confirmpass: UITextField!
    

    
    @IBAction func Resetpass(_ sender: Any) {
        let oldpasstext = Oldpass.text!
        let newpasstext = Newpass.text!
        let confirmpasstext = Confirmpass.text!
        
        
        if(oldpasstext.isEmpty||newpasstext.isEmpty||confirmpasstext.isEmpty) {
            showToast(message: "Missing or invalid information", font: .systemFont(ofSize: 12))
        }
        else{
            if (oldpasstext.count < 8 || newpasstext.count < 8 || confirmpasstext.count < 8 )
            {
                self.showToast(message: "Password should have min 8 characters", font: .systemFont(ofSize: 12))
            }
            else {
            if(newpasstext==confirmpasstext) {
                let defaults = UserDefaults.standard
                let id = defaults.object(forKey: "ID")
                userViewModel.changepassword(ID: id as! String , oldpassword: oldpasstext, newpassword: newpasstext, onSuccess: {
                    self.navigationController?.popViewController(animated: true)
                }, onFailure:  {
                    (errorMessage) in
                    self.showToast(message: "Incorrect old password", font: .systemFont(ofSize: 12))
                     })
                                             }
                else {
                showToast(message: "Passwords do not match", font: .systemFont(ofSize: 12))
            }
            }
        }
        
        
        
        
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func showToast(message : String, font: UIFont) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 125, y: self.view.frame.size.height-180, width: 250, height: 35))
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
