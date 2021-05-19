//
//  ViewController.swift
//  stopWatch_2
//
//  Created by 전상민 on 2021/05/19.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet weak var timeLabel: UILabel!
//    @IBOutlet weak var test: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var lap: UIButton!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    var isStarting = false
    
    var timer = Timer() // Timer라는 Class가 있음
    var startTime = 0.0
    var elapsed = 0.0 // 경과된 시간값
    var lapTableviewData = [String]()
    
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
    
    @IBAction func lap(_ sender: Any) {
        let date = Date(timeIntervalSince1970: elapsed)
        let dateformat = DateFormatter()
        dateformat.dateFormat = "mm:ss:SS" // 전체
        timeLabel.text = dateformat.string(from: date)
        self.lapTableviewData.append(timeLabel.text!)
        let indexPath = IndexPath(row: self.lapTableviewData.count - 1, section: 0)
        self.tableView.insertRows(at: [indexPath], with: .automatic)
        self.tableView.scrollToRow(at: indexPath, at: .none, animated: true)
    }
    func resetDateLabel() {
        timeLabel.text = "00:00:00"
    }
    
    override func viewDidLoad() {  // viewDidLoad() : 초기셋팅을 여기서 함
        super.viewDidLoad()
        // 초기값 설정
        startStopButton.setTitle("Start", for: .normal ) // (이름 , .상태)
        resetButton.setTitle("Reset", for: .normal)
        lap.setTitle("Lap", for: .normal)
        resetDateLabel()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "mainTableViewCell", bundle: nil), forCellReuseIdentifier: "mainTableViewCell")
    }

    @objc func updateCounter() { // @objc: selector 호출할때 사용
        
        elapsed = Date().timeIntervalSince1970 - startTime // 경과시간이 계속 계산되게 함
        let date = Date(timeIntervalSince1970: elapsed)
        let dateformat = DateFormatter()
        
        dateformat.dateFormat = "mm:ss:SS"
        timeLabel.text = dateformat.string(from: date)
  
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lapTableviewData.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainTableViewCell",
                                                 for: indexPath) as! mainTableViewCell
        let item = self.lapTableviewData[indexPath.row]
        cell.lap.text = item
        return cell
    }


}


