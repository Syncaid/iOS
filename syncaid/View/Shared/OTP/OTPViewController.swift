//
//  OTPViewController.swift
//  syncaid
//
//  Created by AhmedFatma on 22/11/2022.
//

import UIKit

class OTPViewController : UIViewController {

   
    @IBOutlet weak var VerifyButton: UIButton!
    @IBOutlet weak var Password1: UITextField!
    @IBOutlet weak var Password2: UITextField!
    @IBOutlet weak var OTP: UITextField!
    
    @IBOutlet weak var PasswordLabel: UILabel!
    
    @IBOutlet weak var Password2Label: UILabel!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        var pw1 = Password1.text!
        var pw2 = Password2.text!
        var otp = OTP.text!
        _=pw1
        _=pw2
        _=otp
        pw1 = ""
        pw2 = ""
        otp = ""
        
        Password2.isHidden = true
        Password1.isHidden = true
        PasswordLabel.isHidden = true
        Password2Label.isHidden = true
        VerifyButton.isHidden = true
 
        
    }
    
 
    @IBAction func OTPchanged(_ sender: Any) {
        let defaults = UserDefaults.standard
        let vString = defaults.object(forKey: "OTP")
        let otp = OTP.text!
         
    
       
        
        if(vString as! String == otp) {
            
            Password2.isHidden = false
            Password1.isHidden = false
            PasswordLabel.isHidden = false
            Password2Label.isHidden = false
            VerifyButton.isHidden = false
        }
        
    }
    
    

   // if(otp == vString as! String){
   //     Password2.isHidden = false
   //     Password1.isHidden = false
    //    PasswordLabel.isHidden = false
    //    Password2Label.isHidden = false
        
        
   // }else {
   //     self.showToast(message: "Invalid OTP", font: .systemFont(ofSize: 12))
        
    //}
    
    
    
    @IBAction func Verify(_ sender: Any) {
        
    
        let pw1 = Password1.text!
        let pw2 = Password2.text!
        let otp = OTP.text!
        
      
            
            
            
            
            //let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
          //  let Login = storyboard.instantiateViewController(withIdentifier: "Login")
            
            
            if (otp.isEmpty || pw1.isEmpty || pw2.isEmpty){
                self.showToast(message: "Missing or invalid information", font: .systemFont(ofSize: 12))
                
                return;
            }
            
            else {
                if(pw1 != pw2) {
                    self.showToast(message: "Passwords do not match", font: .systemFont(ofSize: 12))
                }
                else {
                    let Defaults = UserDefaults.standard
                    let defaultEmail = Defaults.object(forKey: "ForgotEmail")
                    
                    UserViewModel().VerifyOTP(Email:defaultEmail as! String ,Password : pw1,vString : otp, onSuccess: {
                        self.navigationController?.popToRootViewController(animated: true)
                        
                        
                    },
                                              onFailure: {        (errorMessage) in
                        self.showToast(message: "Invalid OTP", font: .systemFont(ofSize: 12))
                        print(errorMessage)
                        
                        
                    }
                    )
                
            }
        }
    }
  
    
    
    func showToast(message : String, font: UIFont) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 125, y: self.view.frame.size.height-75, width: 250, height: 35))
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
