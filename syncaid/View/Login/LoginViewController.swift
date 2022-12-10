//
//  LoginVC.swift
//  syncaid
//
//  Created by AhmedFatma on 16/11/2022.
//

import UIKit
import SwiftUI
import Foundation
import Alamofire
import GoogleSignIn
import LocalAuthentication



class LoginViewController: UIViewController {
    
 
    let signInConfig = GIDConfiguration(clientID: "25150921340-3vtj2ukh0ll5u409hootf1p1rljdadcj.apps.googleusercontent.com")
   
    @IBAction func Google(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let Loading = storyboard.instantiateViewController(withIdentifier: "Loading")
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
            guard error == nil else { return}
            guard let user = user else { return }
            
            if let profiledata = user.profile {
                
              
                let email : String = profiledata.email
                
                self.userViewModel.GoogleLogin(Email: email, onSuccess: {
                    print("ok")
                    self.navigationController?.pushViewController(Loading, animated: false)
                    
                    },
                                    
                                    onFailure: {
                    (errorMessage) in
                        self.showToast(message: "Wrong information!", font: .systemFont(ofSize: 12))
                        print(errorMessage)
                        
                })
                
                
              
                
            }
        }}
    
    @IBAction func FaceId(_ sender: UIButton) {
        let context = LAContext()
                var error: NSError? = nil
                if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics
                                             , error: &error) {
                    
                    let reason = "Please authorise with touch id!"
                    context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, error in
                        DispatchQueue.main.async {
                            guard success , error == nil else {
                                //failed
                                let alert = UIAlertController(title: "Failed to Authentificate", message: "Please try again", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                                self?.present(alert, animated: true)
                                return
                            }
                            //show other screen success
                            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                            let Loading = storyboard.instantiateViewController(withIdentifier: "Loading")
                            self?.navigationController?.pushViewController(Loading, animated: false)
                        }
                    }
                }
                else {
                    let alert = UIAlertController(title: "Unavailable", message: "you can use this feature", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                    return
                }
    }
    
    @IBOutlet weak var PasswordField: UITextField!
   
    @IBOutlet weak var EmailField: UITextField!
    @ObservedObject var userViewModel = UserViewModel()
    
    
    @IBAction func ForgotPassword(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let ForgotPassword = storyboard.instantiateViewController(withIdentifier: "ForgotPassword")
        self.navigationController?.pushViewController(ForgotPassword, animated: true)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        PasswordField.text = nil
        EmailField.text = nil
        
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Logo")!)
       
        
    }
    

    

    @IBAction func LoginBtn(_ sender: UIButton) {
        let emailField = EmailField.text!;
        let passwordField = PasswordField.text!;
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let Loading = storyboard.instantiateViewController(withIdentifier: "Loading")
        let emailPattern = #"^\S+@\S+\.\S+$"#
         
        
        
     
        let isEmail = emailField.range(of: emailPattern,options: .regularExpression )
       
 
     //   if (emailField.isEmpty || passwordField.isEmpty || isEmail == nil){
          //  self.showToast(message: "Missing or invalid information", font: .systemFont(ofSize: 12))
            
     //       return;
     //   }
        
        
        
        userViewModel.Login(Email: "ahmed.kazez@esprit.tn"
                            , Password: "0000", onSuccess: {
            
            self.navigationController?.pushViewController(Loading, animated: false)
            
            },
                            
                            onFailure: {
            (errorMessage) in
                self.showToast(message: "Wrong information!", font: .systemFont(ofSize: 12))
                print(errorMessage)
                
        })
        
        
        
        
    }
 
    
    
    
    
    
    func showToast(message : String, font: UIFont) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 125, y: self.view.frame.size.height-140, width: 250, height: 35))
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










struct LoginRepresentable: View {
    var body: some View {
        LoginVCRepresentable()    }
}

struct LoginRepresentable_Previews: PreviewProvider {
    static var previews: some View {
        LoginRepresentable()
    }
}

struct LoginVCRepresentable : UIViewControllerRepresentable {

    func makeUIViewController(context: UIViewControllerRepresentableContext<LoginVCRepresentable>) -> UIViewController{
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(withIdentifier: "Login")
        return controller
    }
    
    func updateUIViewController(_ uiViewController:  UIViewController, context: UIViewControllerRepresentableContext<LoginVCRepresentable>) {
        
    }
}
