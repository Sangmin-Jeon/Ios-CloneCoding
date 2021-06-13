//
//  MealModel.swift
//  Meal_Clone
//
//  Created by 전상민 on 2021/06/11.
//

import UIKit

// Model구성
class MealModel: NSObject, NSCoding, NSSecureCoding {
    static var supportsSecureCoding: Bool{
        return true
    }
    
    // 인코딩
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(photo, forKey: "photo")
        aCoder.encode(rating, forKey: "rating")
    }
    // 디코딩
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let photo = aDecoder.decodeObject(forKey: "photo") as? UIImage
        let rating = aDecoder.decodeInteger(forKey: "rating")
        // init 호출
        self.init(name: name, photo: photo, rating: rating)
    }
    
    
    var name: String
    var photo: UIImage? // 없어도 되는 형태이면 Optional
    var rating: Int // 기본값 0
    
    override init() { // 파라미터를 받지 않고 init을 해주고 싶으면 옵셔널이 아닌 변수들만 초기값을 준다.
        self.name = ""
        self.rating = 0
    }
    
    init(name: String, photo: UIImage?, rating: Int) { // Optional로 만든게 아니라면 init해야한다.
        self.name = name
        self.photo = photo
        self.rating = rating
    }

}
