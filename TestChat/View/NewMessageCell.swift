//
//  NewMessageCell.swift
//  TestChat
//
//  Created by Dmytro on 06.01.2022.
//

import UIKit

class NewMessageCell: UITableViewCell {
    
    @IBOutlet var textMessageLabel: UILabel!
    
    @IBOutlet var messageBubble: UIView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        messageBubble.layer.cornerRadius = (messageBubble.frame.height * 2) / 20
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
