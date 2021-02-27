//
//  Card.swift
//  Concentration
//
//  Created by 전상민 on 2021/02/27.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0 // getUniqueIdentifier() 구현 ,이것은 타입과 저장됨
    
    static func getUniqueIdentifier() -> Int{ // 호출될때 마다 이 메소드는 유일한 식별자를 반환
    // static func getUniqueIdentifier(): 타입이 붙어있는 함수 Card에게 보낼수없다 Card에게 유일한 식별자를 달라고
    // 요청할 수도 없음 Card타입 자체에게 요청한다. 정적이란 것은 이런의미
    // 따라서 이 함수를 부르고 싶으면 타입에게 보낸다.
        Card.identifierFactory += 1 // 유일한 식별자를 만듬
        return identifierFactory // 불릴때마다 유일한 정수를 만들어 리턴한다.
                                 // 0에서 시작하여 매번 유일무이한 값을 만들기 때문
                                 // 정적 메소드 안이어서 Card.이 없어도 정적변수에 접근할수 있다.
    }
    
    init(){ // 초기화 init이 식별자를 받지 않도록했음(유일한 식별자를 줘야한다.)
//        self.identifier = identifier // self.identifier는 식별자 identifier는 init의 인수로 구분
        self.identifier = Card.getUniqueIdentifier() // Card타입으로 부터 받음
    }
    
}
