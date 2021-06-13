//
//  ViewController.swift
//  Meal_Clone
//
//  Created by 전상민 on 2021/06/11.
//

import UIKit

class ViewController: UIViewController { 
    
    var mealList: [MealModel] = [] // MealModel type의 배열 선언(MealModel은 구조체로 구현)

    @IBOutlet weak var mealTableView: UITableView!
    
    // 새로운 리스트를 추가/저장 하기위해 unwindToSegue를 사용(직접 만들어주어야 한다.)
    @IBAction func unwindToMealList(sender: UIStoryboardSegue){
        
        guard let detailVC = sender.source as? MealDetailViewController else{
            return
        }
        
        // 눌린 셀이 있는지
        if let selectedIndexPath = self.mealTableView.indexPathForSelectedRow{
            mealList[selectedIndexPath.row] = detailVC.mealModel
            // 화면에 갱신
            self.mealTableView.reloadRows(at: [selectedIndexPath], with: .automatic)
            // reload 한 순간 select된 것이 없어지기 때문에 deselect는 안해도 된다.
            // self.mealTableView.deselectRow(at: [selectedIndexPath], animated:true)
        }else{
            let insertIndexPath = IndexPath(row: mealList.count, section: 0)
            mealList.append(detailVC.mealModel) // 새로만든 데이터를 추가
//            self.mealTableView.reloadData() // 화면에 출력
            // insert를 사용하는 방법
            self.mealTableView.insertRows(at: [insertIndexPath], with: .automatic)
            
        }
        saveMeal()
    }
    
    func saveMeal(){
        // archive
        // 어디에 저장 할 것이진 path필요
        DispatchQueue.global().async { // background Thread로
            let documentDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first
            // 디렉토리 경로 추가
            guard let archiveURL = documentDirectory?.appendingPathComponent("meals") else{
                return
            }
    //        let isSuccessSave = NSKeyedArchiver.archiveRootObject(mealList, toFile: archiveURL.path)
            
            do{
                let archivedData = try NSKeyedArchiver.archivedData(withRootObject: self.mealList, requiringSecureCoding: true)
                try archivedData.write(to: archiveURL)
            }catch{
                print(error)
            }
        }
//        if isSuccessSave{
//            print("success saved")
//        }else{
//            print("failed save")
//        }
    }
    var isEditMode = false
    
    @IBAction func doEdit(_ sender: Any) {
        // 누를때마다 토클
        isEditing = !isEditing
        mealTableView.setEditing(isEditing, animated: true)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            // 모델에서 해당되는 셀을 지움
            mealList.remove(at: indexPath.row)
            // 화면에도 지워줌
            mealTableView.deleteRows(at: [indexPath], with: .automatic)
            saveMeal()
        }
    }
    
    func loadMeals() -> [MealModel]? {
        
        let documentDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first
        // 디렉토리 경로 추가
        guard let archiveURL = documentDirectory?.appendingPathComponent("meals") else{
            return nil
        }
        guard let codedData = try? Data(contentsOf: archiveURL) else{
            return nil
        }
        guard let unarchivedData =  try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(codedData)
        else{
            return nil
        }
        return unarchivedData as? [MealModel]
//        return NSKeyedUnarchiver.unarchiveObject(withFile:archiveURL.path ) as? [MealModel]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // 저장한 데이터 가져옴
        if let loadedMeals = loadMeals(){
            self.mealList = loadedMeals
        }
        // 없으면 기본 dummy 데이터 출력
        if mealList.count == 0{
            let dummy1 = MealModel.init(name: "스파게티", photo: UIImage(named: "meal1"), rating: 3)
            let dummy2 = MealModel.init(name: "피자", photo: UIImage(named: "meal2"), rating: 1)
            let dummy3 = MealModel.init(name: "티라미슈", photo: UIImage(named: "meal3"), rating: 5)
            mealList.append(dummy1)
            mealList.append(dummy2)
            mealList.append(dummy3)
        }
        
        
    }
    // 화면에 있는 세그워이를 씀
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "presentDetail"{ // 호출될때 identifier로 구분
            
        }else if segue.identifier == "showDetail"{
            let detailVC = segue.destination as! MealDetailViewController // 목적지에 있는 VC를 가져온다.
            
            // 선택한 index(음식의 데이터)를 가져오기
            let selectedCell = sender as! MealCell
            // 해당되는 셀의 indexPath값을 가져옴
            // Optional Type이라서 if let으로 unrapping
            if let selectedIndexPath = mealTableView.indexPath(for: selectedCell){
                detailVC.mealModel = mealList[selectedIndexPath.row]
            }
        }
    }

}


extension ViewController: UITabBarDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealList.count // 셀 개수는 meallist의 크기만큼
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let mealCell = tableView.dequeueReusableCell(withIdentifier: "mealCell", for: indexPath)
            as! MealCell // MealCell Type으로 Type casting
        
        mealCell.name.text = mealList[indexPath.row].name
        mealCell.ratingView.rating = mealList[indexPath.row].rating
        mealCell.ratingView.isUserInteractionEnabled = false
        mealCell.mealImageView.image = mealList[indexPath.row].photo ?? UIImage(named: "defaultPhoto")
        
        return mealCell
    }
    
    
}


