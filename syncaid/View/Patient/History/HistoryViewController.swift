//
//  HistoryViewController.swift
//  syncaid
//
//  Created by AhmedFatma on 30/11/2022.
//

import UIKit
import SwiftUI
import Foundation
import Alamofire


class HistoryViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    @IBAction func CloseAddFaint(_ sender: UIButton) {
        viewpage.isHidden = true
        backgroundview.isHidden = true
    }
    
  var tapGesture = UITapGestureRecognizer()
    
    @objc func closepopup(_ sender: UITapGestureRecognizer? = nil) {
        print("Tapped")
    }

    
    
    
    
    @IBAction func DeleteFaint(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Are you sure ?", message: "Deleting this log is undoable", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler:{ action in
            let point = sender.convert(CGPoint.zero, to:self.HistoryTable)
            guard let indexpath = self.HistoryTable.indexPathForRow(at: point) else { return }
            var Id = self.faintViewModel.UserFaints[indexpath.row]._id
            self.faintViewModel.DeleteFaint(id: Id, onSuccess: {
              self.faintViewModel.UserFaints.remove(at: indexpath.row)
              self.HistoryTable.reloadData()
         },onFailure: {errorMessage in
              print("error")
                
            })
                                      }))
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        self.present(alert, animated: true)
        
       
  
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.faintViewModel.UserFaints.count
      
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = HistoryTable.dequeueReusableCell(withIdentifier: "cell",
                                                     for: indexPath) as! HistoryTableViewCell
        
        cell.DurationLabel?.text = self.faintViewModel.UserFaints[indexPath.row].Duration+" min"
       cell.TimeLabel?.text = self.faintViewModel.UserFaints[indexPath.row].Time
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedFaint = faintViewModel.UserFaints[indexPath.row]
    }
    
   
    
    @IBOutlet weak var DatePicker: UIDatePicker!
    
    @IBOutlet weak var backgroundview: UIView!
    
    @IBOutlet weak var viewpage: UIView!
    @IBOutlet weak var HistoryTable: UITableView!
    @ObservedObject var faintViewModel = FaintViewModel()
    @IBOutlet weak var FaintDuration: UITextField!
   
  
    @objc func handler(sender: UIDatePicker) {
       	
    }
    
    
    @IBAction func AddFaint(_ sender: Any) {
        FaintDuration.text=""
        
        animate(viewpage, animated: true)
        backgroundview.isHidden = false
        
    }
    
  

    
    @IBAction func DoneAdd(_ sender: UIButton) {
        let duration = FaintDuration.text!
        if(duration.containsOnlyDigits != true  || duration.isEmpty ){
            showToast(message: "Invalid information", font: .systemFont(ofSize: 10))
            return;
            }
        
        else {
            let Defaults = UserDefaults.standard
            let id = Defaults.object(forKey: "ID")
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm dd-MM-yyyy"
            let faintDate = formatter.string(from: DatePicker.date)
            
            
            faintViewModel.AddFaints(ID: id as! String, Duration: duration,Time:faintDate, onSuccess: {
                self.viewpage.isHidden = true
                self.backgroundview.isHidden = true
                self.HistoryTable.reloadData()
                
                
                
            }, onFailure: {errorMessage in
                print("error")
                
            
        })
                                     }
    }
    
    
    
   
    

    override func viewDidAppear(_ animated: Bool) {
        viewpage.isHidden = true
        backgroundview.isHidden = true
    }
 


    override func viewDidLoad() {
        super.viewDidLoad()
        viewpage.isHidden = true
        backgroundview.isHidden = true
        viewpage.layer.cornerRadius = 20
        viewpage.layer.shadowRadius = 5
        viewpage.layer.shadowOpacity = 0.3
        viewpage.isUserInteractionEnabled = true
        HistoryTable.dataSource = self
        HistoryTable.delegate = self
        
        let Defaults = UserDefaults.standard
        let id = Defaults.object(forKey: "ID")
        tapGesture=UITapGestureRecognizer(target: self, action: #selector(self.closepopup(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        viewpage.addGestureRecognizer(tapGesture)
        
        
    
        
        faintViewModel.getFaintsByUser(id: id as! String, onSuccess: {
            self.HistoryTable.reloadData()
            

             
        }, onFailure: {errorMessage in
          print("error")
            
        })
        // Do any additional setup after loading the view.
    }
    

    func showToast(message : String, font: UIFont) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 80, y: self.view.frame.size.height-350, width: 160, height: 25))
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
