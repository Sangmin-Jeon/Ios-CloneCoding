//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by 전상민 on 2021/02/12.
//

import Foundation // model은 UI와 분리되어있기에 UIKit사용x
/*
 Foundation은 Core Service계층이며,
 UI가 아닌 기본적인 것들이 들어있다.
 */

class CalculatorBrain{ // model은 상속받지 않는다, 부모class없음 기본Class임
    /*
     API = CalculatorBrain에서 프로그래밍할 인터페이스(메소드 프로퍼티 전부)
     GeneratedInterface: 어떤것이 public API인지 확인하는 방법
     internal은 public과 차이점이 있음
     internal은 module안에서 공개된 것
     public은 다른 module에 있는 모든 사람에게도 공개된 것
     internal은 public을 뜻한다고 보면 된다.
     */

    private var accumulator = 0.0
    
    func setOperand(operand: Double){ // CalculatorBrain을 사용하면 setOperand 하겠다.
        accumulator = operand // operand(피연산숫자)를 주면 operand로 들어오는 값으로
                              //  acculmulator를 다시 set함.
    }
    private  var operations: Dictionary<String,Operation> = [
        "π": Operation.Constant(Double.pi), //Double.pi
        "e": Operation.Constant(M_E), //M_E
        "√": Operation.UnaryOperation(sqrt), //sqrt가 Double을 받아서 Double을 반환하는 함수이기 때문에 가능
        "cos": Operation.UnaryOperation(cos), //cos
        "*": Operation.BinaryOperation({$0 * $1}), // 클로저 사용,({($0,$1) in return $0 * $1 }) = 원래 코드
        "+": Operation.BinaryOperation({$0 + $1}),
        "-": Operation.BinaryOperation({$0 - $1}),
        "/": Operation.BinaryOperation({$0 / $1}),
        "=": Operation.Equals
        
    
    ]
    private enum Operation{     // 다른것과 비슷하지만 변수를 가질수는 없다. 값으로 전달됨 ,상속 받을수도 없다.
        case Constant(Double)
        case UnaryOperation((Double) -> Double) // 단항연산의 연관값인 함수 , 함수가 다른 타입처럼 사용됨
                                                // Double을 받아서 Double을 반환하는 함수
        case BinaryOperation((Double,Double) -> Double)
        case Equals
    }
    func performOperation(symbol: String){ // 피연산자를 연산 하는 함수(실질적인 계산을 함)
                                           // 파라미터는 String타입의 수학기호로 사용
       
        if let operation = operations[symbol]{ // 딕셔너리에 있는것을 찾음
           
            switch operation {
            case .Constant(let value): accumulator = value // associatedConstantValue = value 연관값을 가져옴
                                                           // 그냥 .을 쓴것은 operation.Constant라고 알고있기 때문
                                                           // swift는 operation일것이라고 추론한다.
                                                           // 원래는 operation.Constant라고 씀
            case .UnaryOperation(let function): accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand:accumulator)
            case .Equals:
                executePendingBinaryOperation()
            // enum Operation에서는 4가지만 가능해서 default안해도 됨
            }
        }
    }
    
    private func executePendingBinaryOperation(){ // = 을 누르지 않고 연산자만 누르면 계속 계산되게끔 
        if pending != nil{
            accumulator = pending!.binaryFunction(pending!.firstOperand,accumulator)
            pending = nil
        }
    }
    
    private var pending: PendingBinaryOperationInfo? // 곱하기나 나누기 이외의 값은 nil이어야 해서
               
    struct PendingBinaryOperationInfo { // 구조체는 값으로 전달(복사) enum과 같음 , 상속x
        var binaryFunction: (Double,Double) -> Double //
        var firstOperand: Double
    }
    
    var result:Double{ // Double타입의 연산 결과가 담길 변수
        get{           // 읽기 전용(값을 읽어 올수만 있음 )
                       // "=="연산은 함수 이다. get은 "=="연산과 관계가 없다.(비교가 아니다)
            return accumulator // result는 항상 현재상태의 accumulator값이 된다.
        }
    }
    
}


// 들여쓰기 하는법 : control + i
