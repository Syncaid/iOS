//
//  ManageGuardianViewController.swift
//  syncaid
//
//  Created by AhmedFatma on 25/11/2022.
//

import UIKit

class ManageGuardiansViewController: UIViewController, UITableViewDataSource,UITableViewDelegate  {
    
    
    @IBOutlet weak var ManageGuardians: UITableView!
    
    
    
    
    
    
    @IBAction func Callbtn(_ sender: Any) {
    }
    
    @IBAction func Deletebtn(_ sender: Any) {
    }
    


    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
