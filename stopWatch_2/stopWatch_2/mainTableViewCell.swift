//
//  mainTableViewCell.swift
//  stopWatch_2
//
//  Created by 전상민 on 2021/05/19.
//

import UIKit

class mainTableViewCell: UITableViewCell {

    @IBOutlet weak var lap: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lap.text = ""
    }
}
