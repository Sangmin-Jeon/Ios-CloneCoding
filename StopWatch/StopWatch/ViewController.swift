//
//  ViewController.swift
//  StopWatch
//
//  Created by 전상민 on 2021/05/13.
//

/*
 view )
 label 5개 , button 2개 사용
 객체를 묶을때 embed in 사용하자 (간격 일정하게 하고 싶으면 stack view 사용)
*/

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelMillisecond: UILabel!
    @IBOutlet weak var labelsecond: UILabel!
    @IBOutlet weak var labelminute: UILabel!
    
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    var isStarting = false
    
    var timer = Timer() // Timer라는 Class가 있음
    var startTime = 0.0
    var elapsed = 0.0 // 경과된 시간값
    
    @IBAction func startStop(_ sender: Any) { // 기능으로서 연결
        
        if isStarting == true{ // 누를때 바뀌게
            // stop
            
            startStopButton.setTitle("Start", for: .normal)
            timer.invalidate() // invalidate(): timer를 stop시킴
        }else{
            // start 누른상태
            startTime = Date().timeIntervalSince1970 - elapsed
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
            // 0.01초마다 한번씩 호출, target은 자기자신, #selector(호출하려는 함수명),
            // userInfo: 실행할때 같이 보낼것 없으면 nil, repeats: 계속 반복하려면 true 한번만 보여주려면 false
            startStopButton.setTitle("Stop", for: .normal)
        }
        
    

//        dateformat.dateFormat = "mm:ss:SS"
//        let datePresent = dateformat.string(from: date)
//        labelMillisecond.text = datePresent
        
        print("start \(startTime)")
        print("elased \(elapsed)")
//        print("\(datePresent)")
        
        isStarting = !isStarting // 앞에 !붙이면 반대 값(여기서는 false)
    }
 
    @IBAction func reset(_ sender: Any) {
        
        elapsed = 0.0 // 초기값 줘서 리셋될때 0.0으로 되게함
        startTime = Date().timeIntervalSince1970 - elapsed
        resetDateLabel()
        
        
    }
    
    func resetDateLabel() {
        labelminute.text = "00"
        labelsecond.text = "00"
        labelMillisecond.text = "00"
    }
    
    override func viewDidLoad() {  // viewDidLoad() : 초기셋팅을 여기서 함
        super.viewDidLoad()
    
        
        
        // 초기값 설정
        startStopButton.setTitle("Start", for: .normal ) // (이름 , .상태)
        resetButton.setTitle("Reset", for: .normal)
        resetDateLabel()
        
    }

    @objc func updateCounter() { // @objc: selector 호출할때 사용
        
        elapsed = Date().timeIntervalSince1970 - startTime // 경과시간이 계속 계산되게 함
        
        let date = Date(timeIntervalSince1970: elapsed)
        let dateformat = DateFormatter()
  
        dateformat.dateFormat = "SS" // 밀리초
        labelMillisecond.text = dateformat.string(from: date)
        
        dateformat.dateFormat = "ss" // 초
        labelsecond.text = dateformat.string(from: date)
        
        dateformat.dateFormat = "mm" // 분
        labelminute.text = dateformat.string(from: date)
    }

}


