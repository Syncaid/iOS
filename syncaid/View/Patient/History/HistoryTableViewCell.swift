//
//  HistoryTableViewCell.swift
//  syncaid
//
//  Created by AhmedFatma on 1/12/2022.
//

import UIKit
import Foundation

class HistoryTableViewCell: UITableViewCell {
   
  
    @IBOutlet weak var TimeLabel: UILabel!
    
    
    @IBOutlet weak var DurationLabel: UILabel!
    
  
    @IBOutlet weak var HistoryLogo: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      //  HistoryLogo.layer.cornerRadius = HistoryLogo.frame.width/2
    }

 
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
