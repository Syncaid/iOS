//
//  SignupViewController.swift
//  syncaid
//
//  Created by AhmedFatma on 22/11/2022.
//

import UIKit
import Foundation
import SwiftUI

class SignupViewController: UIViewController {

    @IBOutlet weak var Firstname: UITextField!
    @IBOutlet weak var Lastname: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password2: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var email = Email.text!
        var firstname = Firstname.text!
        var lastname = Lastname.text!
        var password = Password.text!
        var password2 = Password2.text!
        _ = email
        _ = firstname
        _ = lastname
        _ = password
        _ = password2
        email = ""
        firstname = ""
        lastname = ""
        password = ""
        password2 = ""

     
    }
    

    @IBAction func Signup(_ sender: Any) {
        let email = Email.text!
        let firstname = Firstname.text!
        let lastname = Lastname.text!
        let password = Password.text!
        let password2 = Password2.text!
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let Signup2 = storyboard.instantiateViewController(withIdentifier: "Signup2")
        let emailPattern = #"^\S+@\S+\.\S+$"#
        let isEmail = email.range(of: emailPattern,options: .regularExpression )
 
        if (email.isEmpty || password.isEmpty || isEmail == nil){
            self.showToast(message: "Missing or invalid information", font: .systemFont(ofSize: 12))
            
            return;
        }
        else {
            if (password != password2) {
                self.showToast(message: "Passwords don't match", font: .systemFont(ofSize: 12))
            }
            else {
                UserViewModel().Register(FirstName: firstname, LastName: lastname, Email: email, Password: password, onSuccess: {
                self.navigationController?.pushViewController(Signup2, animated: true)
            },
                             
                             onFailure: {
             (errorMessage) in
                 self.showToast(message: "Wrong information!", font: .systemFont(ofSize: 12))
                 print(errorMessage)
                 
         })}
           
            
        }
        
        
        
        
        
        
        
        
        
    }
    
    func showToast(message : String, font: UIFont) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 125, y: self.view.frame.size.height-145, width: 250, height: 35))
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










struct SignupRepresentable: View {
    var body: some View {
        SignupVCRepresentable()    }
}

struct SignupRepresentable_Previews: PreviewProvider {
    static var previews: some View {
        SignupRepresentable()
    }
}

struct SignupVCRepresentable : UIViewControllerRepresentable {

    func makeUIViewController(context: UIViewControllerRepresentableContext<SignupVCRepresentable>) -> UIViewController{
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(withIdentifier: "Signup")
        return controller
    }
    
    func updateUIViewController(_ uiViewController:  UIViewController, context: UIViewControllerRepresentableContext<SignupVCRepresentable>) {
        
    }
}
