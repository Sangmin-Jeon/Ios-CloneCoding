//
//  MealCell.swift
//  Meal_Clone
//
//  Created by 전상민 on 2021/06/11.
//

import UIKit

class MealCell: UITableViewCell {


    @IBOutlet weak var mealImageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var ratingView: RatingView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
