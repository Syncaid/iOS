//
//  AddGuardianViewController.swift
//  syncaid
//
//  Created by AhmedFatma on 5/12/2022.
//

import UIKit

class QRViewController: UIViewController {

    
  
    @IBOutlet weak var QRimage: UIImageView!
    
    
    
    
    @IBOutlet weak var background: UIView!
    
    
    
    @IBAction func DoneScan(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        let Email = defaults.object(forKey: "EMAIL")
        QRimage.image = generateQRCode(from: Email as! String)
        background.layer.cornerRadius = 20
        background.layer.shadowRadius = 10
        background.layer.shadowOpacity = 0.3
        
        
    }
    

    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }
}
