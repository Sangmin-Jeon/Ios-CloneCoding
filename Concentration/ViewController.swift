//
//  ViewController.swift
//  Concentration
//
//  Created by 전상민 on 2021/02/19.
//

import UIKit // UIKit은 버튼,슬라이더 등이 있는 ios프레임워크

class ViewController: UIViewController{
    
    var flipCount: Int = 0{ // 몇번 뒤집었는지
        // 모든 속성을 원한다면 didset(속성감시자) => 속성이 설정될 때마다 코드실행
        didSet{
            flipCountLabel.text = "Flip: \(flipCount)"
        }
    }

    // UI배열을 만들고 그 배열에서 찾아 사용하게 함
    @IBOutlet var cardButtons: [UIButton]! // outlet collection => UI에 있는 것들의 배열

    var emojiChoice = ["👻","🎃","👻","🎃"] // 받은 cardNumber를 이모지 배열에서 찾기
    
    @IBAction func touchCard(_ sender: UIButton) { //유령 버튼 생성
        flipCount += 1
        // 옵셔널 푸는방법 : 조건문 사용 , !(강제추출)사용
        if let cardNumber = cardButtons.firstIndex(of: sender){  // firstIndex의 반환값은 옵셔널Int
            flipCard(withEmoji: emojiChoice[cardNumber], on: sender)// 옵셔널 set된 상태
        }else{
            print("chosen card was not in cardButtons") // 옵셔널 not set
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel! // 카운팅 메세지
    
    func flipCard(withEmoji emoji: String, on button: UIButton){ // 카드 뒤집는 함수
        if button.currentTitle == emoji{ // currentTitle = 현재 타이틀의 상태를 나타냄
                                         // withEmoji , on 은 호출자가 사용

            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1) // 배경색 color리터럴 사용
        }else{
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }

}

