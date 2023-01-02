//
//  ManageGuardianViewController.swift
//  syncaid
//
//  Created by AhmedFatma on 5/12/2022.
//

import UIKit
import SwiftUI
import Foundation
import Alamofire
import PopupDialog

class ManageGuardiansViewController: UIViewController,  UITableViewDataSource,UITableViewDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @ObservedObject var userViewModel = UserViewModel()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userViewModel.UserGuardians.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = GuardianTable.dequeueReusableCell(withIdentifier: "cell2",
                                                     for: indexPath) as! ManageGuardiansTableViewCell
        
        cell.FullName?.text = userViewModel.UserGuardians[indexPath.row].FirstName!+userViewModel.UserGuardians[indexPath.row].LastName!
      
        
        return cell
    }
    
    
    
    @IBAction func AddGuardian(_ sender: UIButton) {
      
        
        let title = "Assign a guardian"
        
        let message = "In order to assign a guardian you must scan his QR code. You guardian can find his QR code in Settings"
        
        let image = UIImage(named: "qrcode")

        // Create the dialog
        let popup = PopupDialog(title: title, message: message, image: image)

        // Create buttons
        let buttonOne = CancelButton(title: "Dismiss") {
            
        }

        // This button will not the dismiss the dialog
        let buttonTwo = DefaultButton(title: "Scan QR", dismissOnTap: false) {
            
          
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = .camera
            imagePickerController.showsCameraControls = true
            imagePickerController.showsCameraControls = true
            self.present(imagePickerController, animated: true, completion: nil)
                    
        }
        DefaultButton.appearance().titleColor = UIColor(named: "btncolor1")

      
        popup.addButtons([buttonOne, buttonTwo])

        // Present dialog
        self.present(popup, animated: true, completion: nil)
        
    }
    
    
    
    
    
    
    @IBAction func CallGuardian(_ sender: UIButton) {
        let point = (sender as AnyObject).convert(CGPoint.zero, to:GuardianTable)
        guard let indexpath = GuardianTable.indexPathForRow(at: point) else { return }
        let phone = "tel://"
        let tel = self.userViewModel.UserGuardians[indexpath.row].Tel!
                        let phoneNumberformatted = phone + tel
                        guard let url = URL(string: phoneNumberformatted) else {
                            
                            return }
                       UIApplication.shared.open(url)
    }
    
    @IBAction func DeleteGuardian(_ sender: Any) {
        
        
        let title = "Are you sure"
        
        let message = "Deleting this guardian is undoable"
        
       

        // Create the dialog
        let popup = PopupDialog(title: title, message: message)

        // Create buttons
        let buttonOne = CancelButton(title: "Dismiss") {
          
        }
        
        let buttonTwo = DefaultButton(title: "Delete") {
            let point = (sender as AnyObject).convert(CGPoint.zero, to:self.GuardianTable)
            guard let indexpath = self.GuardianTable.indexPathForRow(at: point) else { return }
            let guardianid = self.userViewModel.UserGuardians[indexpath.row]._id
            let defaults = UserDefaults.standard
            let userid = defaults.object(forKey: "ID")!
            
            self.userViewModel.deleteGuardian(userId:userid as! String, guardianId: guardianid!, onSuccess: {
                self.userViewModel.UserGuardians.remove(at: indexpath.row)
                  self.GuardianTable.reloadData()
         },onFailure: {errorMessage in
              print("error")
                
            })
        }
        
        CancelButton.appearance().titleColor = .systemRed
        
      
        popup.addButtons([buttonOne,buttonTwo])

        
        // Present dialog
        self.present(popup, animated: true, completion: nil)
    
    }
    

    
    @IBOutlet weak var GuardianTable: UITableView!
    
 
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let Defaults = UserDefaults.standard
        let id = Defaults.object(forKey: "ID")
        GuardianTable.dataSource = self
        GuardianTable.delegate = self
        userViewModel.getGuardians(ID: id as! String, onSuccess: {
            self.GuardianTable.reloadData()
            
        }, onFailure: {
           errorMessage in
            print("error")
            
        })

        // Do any additional setup after loading the view.
    }
    



}
