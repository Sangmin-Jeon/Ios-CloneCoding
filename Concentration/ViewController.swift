//
//  ViewController.swift
//  Concentration
//
//  Created by 전상민 on 2021/02/19.
//

import UIKit // UIKit은 버튼,슬라이더 등이 있는 ios프레임워크

class ViewController: UIViewController{
    /*
     var game = Concentartion()
     이렇게 초기화 할수 있는 이유는
     Concentration이 class이기 때문에, class는 모든 변수들이
     초기화되면 인수가 없는 init을 자동으로 가지게 된다.
    */
    lazy var game = Concentartion(numberOfPairsOfCards: (cardButtons.count+1) / 2)
    /*
     쌍으로 해서 2로 나눔
     만약 홀수 개의 카드가 있으면 반올림 해야함 (cardButtons.count+1)
     lazy로 하면 사용하기 전까지는 초기화하지 않음(lazy는 초기화 되었다고 해줌)
     lazy는 didSet은 가질수 없다.
    */
    
    var flipCount: Int = 0{ // 몇번 뒤집었는지
        // 모든 속성을 원한다면 didset(속성감시자) => 속성이 설정될 때마다 코드실행
        didSet{
            flipCountLabel.text = "Flip: \(flipCount)"
        }
    }

    // UI배열을 만들고 그 배열에서 찾아 사용하게 함
    @IBOutlet var cardButtons: [UIButton]! // outlet collection => UI에 있는 것들의 배열

    
    @IBAction func touchCard(_ sender: UIButton) { //유령 버튼 생성
        flipCount += 1
        // 옵셔널 푸는방법 : 조건문 사용 , !(강제추출)사용
        if let cardNumber = cardButtons.firstIndex(of: sender){  // firstIndex의 반환값은 옵셔널Int
            game.chooseCaed(at: cardNumber) // model에게 선택되었다고 알림
            updateViewFromModel()
        }else{
            print("chosen card was not in cardButtons") // 옵셔널 not set
        }
    }
    
    func updateViewFromModel(){
        for index in cardButtons.indices{ // indices는 배열의 메소드, 모든 인덱스의 계수 가능 범위를 배열로 리턴함
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{ // 카드를 매칭
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }else{
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 0) :#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)  // 배경색 color리터럴 사용
            }
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel! // 카운팅 메세지
    
//    func flipCard(withEmoji emoji: String, on button: UIButton){ // 카드 뒤집는 함수
//        if button.currentTitle == emoji{ // currentTitle = 현재 타이틀의 상태를 나타냄
//                                         // withEmoji , on 은 호출자가 사용
//            button.setTitle("", for: UIControl.State.normal)
//            button.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1) // 배경색 color리터럴 사용
//        }else{
//            button.setTitle(emoji, for: UIControl.State.normal)
//            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        }
//    }
    var emojiChoices = ["👻","🎃","🦁","🐳","👽","🤡","😈","🤠","🤖"]
    // 받은 cardNumber를 이모지 배열에서 찾기
    
    var emoji = [Int:String]() // 딕셔너리
    
    func emoji(for card: Card) -> String{
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
                let randomlndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                // arc4random_uniform은 유사(pseudo) 임의 번호 생성기이다 , 0을 받을수 없음
                // 0부터 상한 -1까지를 다루고 부호가 없는 정수형이다.
                emoji[card.identifier] = emojiChoices.remove(at: randomlndex) // 고른 이모지는 제거
        }
//        if emoji[card.identifier] != nil{ // emoji[찾고싶은 내용]
//        // 딕셔너리는 옵셔널을 리턴한다.
//            return emoji[card.identifier]! // nil이 아닌지 먼저 확인하고 아니면 !를 달아준다.
//        }else{
//            return "?"
//        }
        return emoji[card.identifier] ?? "?" // 위 코드를 이렇게 쓸수도 있음(연산자 사용)
        // nil이면 ?를 리턴
    }
}


