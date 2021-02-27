//
//  Concentration.swift
//  Concentration
//
//  Created by 전상민 on 2021/02/27.
//

import Foundation

/*
 API는 Application Programming Interface의 약자
 class안의 모든 메소드와 인스턴스변수의 리스트이다.
 */
class Concentartion{
    
    var cards = [Card]()
    
    func chooseCaed(at index: Int){ // 카드를 고르는 함수 , 인수는 카드(card 배열의 인데스사용)
        if cards[index].isFaceUp{ // 카드 뒤집기 
            cards[index].isFaceUp = false
        }else{
            cards[index].isFaceUp = true
        }
    
    }
    init(numberOfPairsOfCards: Int){
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
//            let matchingCard = card // 구조체를 다른 변수에 할당할때 복사함
                                    // matchingCard는 card의 복사본이 된다.
            cards += [card,card] // +=은 배열에서 쓰임 배열을 통째로 더한다. , 이 배열도 복사된다 배열도 구조체라서
//            cards.append(card) // 배열에 추가
//            cards.append(card) // 배열에 넣거나 뺄 때도 카드를 복사
//                               // 구조체를 주고 받을 때 복사한다.
            
        }
        // TODO: Shuffle the cards (카드를 섞어줌 항상 같은 순서가 되지 않게)
    }
}

