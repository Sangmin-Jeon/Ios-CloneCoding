//
//  ViewController.swift
//  Calculator
//
//  Created by 전상민 on 2021/02/10.
//
// Controller 캠프

import UIKit

class ViewController: UIViewController {
    //프로퍼티는 무조건 초기화를 해줘야함
    @IBOutlet private weak var display: UILabel! // 옵셔널은 nil로 초기화 되어있다.
    /*
     code를 짤때 public으로 하고 priviate하는것 보다 priviate로 하고 나중에 public으로 하는게
     좋다. 문제가 생길수 있음 (public class는 아무나 접근가능)
     GeneratedInterface기능: 어떤것이 public API인지 보여줌
     */
    private var userIsInTheMiddleOfTyping = false

    @IBAction private func touchDigit(_ sender: UIButton){
        /*
         !은 개발자가 이 변수에는 Nil값이 들어갈 리가 없다고 확신할때
         ?는 여기에 Nil값이 포함 될 수 있다는 의로 사용함?
         */
        let digit = sender.currentTitle! // String 으로 하려고 옵셔널
       
        if userIsInTheMiddleOfTyping{ // 사용자가 입력중일때
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        }else{                        // 사용자가 입력중이 아닐때
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true
        // print("touched \(digit) digit")
    }
    
    private var displayValue: Double{
        get{ // displayValue의 값을 가져옴
            return Double(display.text!)! // 반환이 안될수도 있기 때문에 옵셔널 사용(강제추출)
        }set{ // 변수를 설정할때
            display.text = String(newValue)
        }
    }

    private var brain = CalculatorBrain()
    /*
        CalculatorBrain이 된다.
        여기서 module에 접근하고 모든 계산을 한다.
        새클래스의 객체를 생성할 때 마다 인자가 없는 initializer가 하나 자동을 생긴다.
        CalculatorBrain의 기본initializer를 사용하고 있다.
    */
    
    // Model과 Controller를 연결
    @IBAction private func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping{ // User가 숫자를 입력중이라면
            brain.setOperand(operand: displayValue) // brain의 setOperand에 디스플레이에 있는
                                                    // 값을 넘겨줌
            userIsInTheMiddleOfTyping = false // 이게 true가 아니면 false값을 또 set해 줄 필요
                                              // 없어서 안에 넣어줌
        }
        if  let mathematicaSymbol = sender.currentTitle{
            brain.performOperation(symbol: mathematicaSymbol)
        }
        displayValue = brain.result // displayValue에 brain의 결과를 넣음
    }
    
    
}
 



