//
//  ViewController.swift
//  Gesture_1
//
//  Created by 전상민 on 2021/05/17.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var appleImageView: UIImageView!
    @IBOutlet weak var centerX: NSLayoutConstraint!
    @IBOutlet weak var centerY: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let left = UISwipeGestureRecognizer(target: self, action: #selector(move)) // 왼쪽 선언
        left.direction = .left
        
        let right = UISwipeGestureRecognizer(target: self, action: #selector(move)) // 오른쪽
        right.direction = .right
         
        let up = UISwipeGestureRecognizer(target: self, action: #selector(move)) // 위
        up.direction = .up
        
        let down = UISwipeGestureRecognizer(target: self, action: #selector(move)) // 아래
        down.direction = .down
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(move)) // tap
        
        // 움지이는 제스쳐 추가
        // appleImageView.addGestureRecognizer(left) // 이미지를 눌러 사용
        appleImageView.addGestureRecognizer(left) // 화면 어디서든지
        appleImageView.addGestureRecognizer(right)
        appleImageView.addGestureRecognizer(up)
        appleImageView.addGestureRecognizer(down)
        // tap 제스쳐 추가
        appleImageView.addGestureRecognizer(tap)
        // 이미지를 눌러 중앙으로 이동시키기
        appleImageView.isUserInteractionEnabled = true
       
    }

    
    @objc func move(sender: UIGestureRecognizer){ // sender로 받아옴
        // tap = center로 가기
        if sender is UITapGestureRecognizer{ // sender가 tap제스쳐가 맞으면 실행
            centerY.constant = 0
            centerX.constant = 0
            UIView.animate(withDuration: 0.3){ // 애니메이션 효과
                self.view.layoutIfNeeded()
            }
        }
        
        if let swipe = sender as? UISwipeGestureRecognizer{ // Type이 맞는지 확인
            //swipe.direction // swipe에는 direction이라고 하는 방향 값이 들어있음
            switch swipe.direction {
            // case UISwipeGestureRecognizer.Direction.up: // 원래 코드
            case .up: // UISwipeGestureRecognizer.Direction부분이 Type이고 그안에 들어있는 값은 그냥 이렇게 사용
                centerY.constant = centerY.constant - 50
            case .down:
                centerY.constant = centerY.constant + 50
            case .left:
                centerX.constant =  centerX.constant - 50
            case .right:
                centerX.constant =  centerX.constant + 50
            default: // case문에서 모든 case를 다 정해주면 default안써도 됨
                break
            }
            UIView.animate(withDuration: 0.3){ // 애니메이션 효과
                self.view.layoutIfNeeded()
            }
        }
        
    }
    
    
}

