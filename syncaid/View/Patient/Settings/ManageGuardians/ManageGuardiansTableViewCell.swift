//
//  ManageGuardiansTableViewCell.swift
//  syncaid
//
//  Created by AhmedFatma on 5/12/2022.
//

import UIKit

class ManageGuardiansTableViewCell: UITableViewCell {

    
    @IBOutlet weak var ProfilePhoto: UIImageView!
    
    @IBOutlet weak var FullName: UILabel!
    
    @IBOutlet weak var profilephoto: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profilephoto.layer.cornerRadius = profilephoto.frame.width/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
