//
//  LoadingViewController.swift
//  syncaid
//
//  Created by AhmedFatma on 26/11/2022.
//

import UIKit


class LoadingViewController: UIViewController {

    
    @IBOutlet weak var Loading: UIImageView!  {
        didSet {
            Loading.image = UIImage(named: "Logo")
        }
    }
    
    
    var timer: Timer?
    
    
      func startTimer() {
            self.Loading.isHidden = false
            if timer == nil {
                timer = Timer.scheduledTimer(timeInterval:0.0, target: self, selector: #selector(self.animateView), userInfo: nil, repeats: false)
            }
        }
    

    @objc func animateView() {
            UIView.animate(withDuration: 0.7, delay: 0.0, options: .curveLinear, animations: {
                self.Loading.transform = self.Loading.transform.rotated(by: CGFloat(Double.pi))
            }, completion: { (finished) in
                if self.timer != nil {
                    self.timer = Timer.scheduledTimer(timeInterval:0.0, target: self, selector: #selector(self.animateView), userInfo: nil, repeats: false)
                }
            })
        }
    
  
    func stopTimer() {
            timer?.invalidate()
            timer = nil
        }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Loading.layer.cornerRadius = Loading.frame.width/2
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.Loading.isHidden = false
        self.startTimer()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.Loading.isHidden = true
            self.stopTimer()
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let VerifyAccount = storyboard.instantiateViewController(withIdentifier: "VerifyAccount")
            let GuardianMenu = storyboard.instantiateViewController(withIdentifier: "GuardianMenu")
            let PatientMenu = storyboard.instantiateViewController(withIdentifier: "PatientMenu")
            self.Loading.isHidden = true
            let defaults = UserDefaults.standard
            let Role = defaults.object(forKey: "ROLE")
            let Verified = defaults.object(forKey: "VERIFIED")
           
            if (Verified as? Bool == true ) {
                if (Role as! String == "Patient") {
                  
                    //self.navigationController?.pushViewController(PatientMenu, animated: true)
                    self.navigationController?.pushViewController(PatientMenu, animated: false)
               
                    
                }
                   
                
                else {
                        self.navigationController?.pushViewController(GuardianMenu, animated: true)
                
                }
            }
            else {
                
                    self.navigationController?.pushViewController(VerifyAccount, animated: true)
            
                
                
            }

            
    
       }
        
    }

}
