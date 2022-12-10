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

class ManageGuardiansViewController: UIViewController,  UITableViewDataSource,UITableViewDelegate {
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
    
    @IBAction func CallGuardian(_ sender: UIButton) {
        let point = (sender as AnyObject).convert(CGPoint.zero, to:GuardianTable)
        guard let indexpath = GuardianTable.indexPathForRow(at: point) else { return }
        let phone = "tel://"
        var tel = self.userViewModel.UserGuardians[indexpath.row].Tel!
                        let phoneNumberformatted = phone + tel
                        guard let url = URL(string: phoneNumberformatted) else {
                            
                            return }
                       UIApplication.shared.open(url)
    }
    
    @IBAction func DeleteGuardian(_ sender: Any) {
        
        let alert = UIAlertController(title: "Are you sure ?", message: "Deleting this log is undoable", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler:{ action in
            let point = (sender as AnyObject).convert(CGPoint.zero, to:self.GuardianTable)
            guard let indexpath = self.GuardianTable.indexPathForRow(at: point) else { return }
            var guardianid = self.userViewModel.UserGuardians[indexpath.row]._id
            let defaults = UserDefaults.standard
            var userid = defaults.object(forKey: "ID")!
            print(guardianid)
            self.userViewModel.deleteGuardian(userId:userid as! String, guardianId: guardianid!, onSuccess: {
                self.userViewModel.UserGuardians.remove(at: indexpath.row)
                  self.GuardianTable.reloadData()
         },onFailure: {errorMessage in
              print("error")
                
            })
            
       
                                      }))
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        self.present(alert, animated: true)
        
        
        
        
        
        
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
