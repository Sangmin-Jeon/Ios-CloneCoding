//
//  RatingView.swift
//  Meal_Clone
//
//  Created by 전상민 on 2021/06/11.
//

import UIKit

protocol RatingViewDelegate {
    func ratingStatusChanged()
}

class RatingView: UIStackView {
    
    var delegate: RatingViewDelegate?
    
    // 내부에서 사용
    private var ratingButtons: [UIButton] = [] // 버튼 배열
    // 외부에서도 사용
    public var rating = 0{ // 0 ~ 5
        didSet{ // 설정한 값이 있다면 didSet이 호출됨
            delegate?.ratingStatusChanged() // 프로토콜 호출
            updateButtonSelectionState()
        }
    }
    override init(frame: CGRect) { // frame으로 init해야될때
        super.init(frame: frame)
        setupButtons()
    }

    required init(coder: NSCoder) { // init을 사용하려면 무조건 사용
        super.init(coder: coder)
        setupButtons()
    }
    
    
    private func setupButtons(){
        
        self.spacing = 5
        
        let filledStar = UIImage(named: "filledStar")
        let emptyStar = UIImage(named: "emptyStar")
        let highlightedStar = UIImage(named: "highlightedStar")
        
        for index in 0 ..< 5{ // 별개수(5개)
            
            let button = UIButton() // 별버튼 생성
            // 버튼 사이즈 강제설정
            button.widthAnchor.constraint(equalToConstant: 40).isActive = true
            button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
            // 별버튼의 순서를 tag로
            button.tag = index + 1 // for문이 0부터 시작이므로 +1해줌
            // #selector는 파라미터명 없이 호출가능
            button.addTarget(self, action: #selector(selectedStar), for: .touchUpInside)
            
            button.setImage(filledStar, for: .selected)
            button.setImage(emptyStar, for: .normal)
            button.setImage(highlightedStar, for: .highlighted)
            
            // 기본적으로는 self.subview이지만 stackView는 addArrangedSubview
            self.addArrangedSubview(button)
            // 화면에서만 버튼을 가지고 있으면 추적하기 어려움
            // ratingButtons(버튼들의 묶음)에 새로 만들어진 버튼을 추가
            ratingButtons.append(button)
            
        }
    }
    
    @objc func selectedStar(sender: UIButton){
        print("star \(sender.tag)")
        rating = sender.tag
    }
    
    // 버튼을 선택한 상태를 업데이트하는 함수
    func updateButtonSelectionState() {
        // enumerated를 사용하여 배열의 index와 버튼상태를 가져옴
        for (index, button) in  ratingButtons.enumerated(){
            button.isSelected = index < self.rating // 3점을 줬다고 하면 3보다 작은 상태일때 까지만 true
                                                    // 나머지는 false
        }
    }

}
