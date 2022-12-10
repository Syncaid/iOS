//
//  GuardianProfileViewController.swift
//  syncaid
//
//  Created by AhmedFatma on 1/12/2022.
//

import UIKit

class GuardianSettingsViewController: UIViewController {



    @IBOutlet weak var GuardianImage: UIImageView!
    
    @IBOutlet weak var FullName: UILabel!
    
    @IBOutlet weak var EmailLabel: UILabel!
    
    
    @IBAction func QRcode(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let QRcode = storyboard.instantiateViewController(withIdentifier: "QR")
        self.navigationController?.pushViewController(QRcode, animated: true)
        
        
    }
    
    
    
    @IBAction func Switchbtn(_ sender: Any) {
    }
    
    
    @IBAction func EditProfile(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let EditGuardian = storyboard.instantiateViewController(withIdentifier: "EditGuardian")
        self.navigationController?.pushViewController(EditGuardian, animated: true)
        
    }
    
    
    @IBAction func ManagePatient(_ sender: Any) {
    }
    
    @IBAction func Logout(_ sender: Any) {
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        let Email = defaults.object(forKey: "EMAIL")
        let Firstname = defaults.object(forKey: "FIRSTNAME")!
       // var Lastname = defaults.object(forKey: "LASTNAME")!
       
        FullName.text = Firstname as? String
        EmailLabel.text = Email as? String
        
        

        // Do any additional setup after loading the view.
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
