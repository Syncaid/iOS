//
//  ForgotPasswordViewController.swift
//  syncaid
//
//  Created by AhmedFatma on 22/11/2022.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var email = Email.text!
        _=email
        email = ""

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var Email: UITextField!
   
 
     @IBAction func SendOTP(_ sender: Any) {
         
         let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
         let OTP = storyboard.instantiateViewController(withIdentifier: "OTP")
         let emailPattern = #"^\S+@\S+\.\S+$"#
          
         let email = Email.text!
         let isEmail = email.range(of: emailPattern,options: .regularExpression )
         
         let Defaults = UserDefaults.standard
         Defaults.set(email, forKey: "ForgotEmail")
         
         
         
         Defaults.synchronize()
         if (email.isEmpty || isEmail == nil) {
             self.showToast(message: "Missing or invalid information", font: .systemFont(ofSize: 12))
         }
         else {
             UserViewModel().SendOTP(Email: email,onSuccess: {
                 
            
                 
                
                 self.navigationController?.pushViewController(OTP, animated: true)
                 
                 },
                                 
                                 onFailure: {
                 (errorMessage) in
                     self.showToast(message: "Wrong information!", font: .systemFont(ofSize: 12))
                     print(errorMessage)
                     
             })
                                
                 
             
                                     
                                     
                    
                         
                
         }
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
