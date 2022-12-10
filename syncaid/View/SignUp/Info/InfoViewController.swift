//
//  InfoViewController.swift
//  syncaid
//
//  Created by AhmedFatma on 21/11/2022.
//

import UIKit
import Foundation
import SwiftUI

class InfoViewController: UIViewController, UITextFieldDelegate{
  
    
    
    @IBOutlet weak var PhoneNumber: UITextField!
    
    @IBOutlet weak var Gender: UISegmentedControl!
    
    @IBOutlet weak var Role: UISegmentedControl!
    
    var SignupController = SignupViewController()
    @ObservedObject var userViewModel = UserViewModel()

    @IBOutlet weak var Age: UITextField!
    
    
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
        PhoneNumber.delegate=self
        Age.delegate=self
        var tel = PhoneNumber.text!
        _=tel
      
        var agef = Age.text
        _=agef
        agef = ""
        tel = ""
        self.navigationItem.setHidesBackButton(true, animated: true)
        // Do any additional setup after loading the view.
    }
    
    func textField(_ textField: UITextField,
      shouldChangeCharactersIn range: NSRange,
      replacementString string: String) -> Bool {
      
        let invalidCharacters =
        CharacterSet(charactersIn: "0123456789").inverted
        return (string.rangeOfCharacter(from: invalidCharacters) == nil) &&  range.location < 8    }
    

    
    @IBAction func NextBtn(_ sender: Any) {

        let tel = PhoneNumber.text!
        let age = Age.text!
        let gender = Gender.titleForSegment(at: Gender.selectedSegmentIndex)!
        let role = Role.titleForSegment(at: Role.selectedSegmentIndex)!
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let done = storyboard.instantiateViewController(withIdentifier: "done")
        
        
        if (tel.isEmpty || age.isEmpty ) {
            self.showToast(message: "Missing or invalid information", font: .systemFont(ofSize: 12))
      
        } 
        else {
            let Defaults = UserDefaults.standard
            let defaultID = Defaults.object(forKey: "ID")
       

 
            
            userViewModel.Register2(ID: defaultID as! String,Age:age, Gender: gender, Tel: tel, Role: role, onSuccess: {
           
                self.navigationController?.pushViewController(done, animated: true)
                
            }, onFailure: {
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
    


