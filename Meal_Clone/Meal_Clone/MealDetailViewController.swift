//
//  MealDetailViewController.swift
//  Meal_Clone
//
//  Created by 전상민 on 2021/06/11.
//

import UIKit

extension MealDetailViewController: RatingViewDelegate{
    func ratingStatusChanged() {
        saveButtonStatus()
    }
}

class MealDetailViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {


    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var mealImageView: UIImageView!
    @IBOutlet weak var ratingView: RatingView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var mealModel = MealModel() // model 프로퍼티 생성
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ratingView.delegate = self
        
        nameField.text = mealModel.name
        ratingView.rating = mealModel.rating
        // mealModel.photo ?? UIImage(named: "defaultPhoto") :
        // mealModel.photo가 있으면 넣고 없으면 UIImage(name: "defaultPhoto")를 넣어라
        mealImageView.image = mealModel.photo ?? UIImage(named: "defaultPhoto")
        saveButton.isEnabled = false // 시작할때는 비활성화
        
        //  mealImageView에 touch event기능 추가(사진 불러오기)
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(imageTap))
        mealImageView.addGestureRecognizer(tapGesture) // 제스쳐 추가
        mealImageView.isUserInteractionEnabled = true // event를 받게 활성화 시킴
    }
    
    @objc func imageTap(){
        print("image tap")
        // 라이브러리에 접근
        // imagePickerController을 사용하려면 imagePickerControllerDelegate을 선언 해주어야 함
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        self.present(imagePickerController, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 사진이 아니라 동영상일 경우도 있기 때문에 as!로 강제하는것은 위험하다.
        // Any Type이기 때문에 UIImage로 casting해줌
        guard let selectedImage =  info[.originalImage] as? UIImage else{
            return
        }
        mealImageView.image = selectedImage // 선택한 이미지를 화면에 출력
        saveButtonStatus()
        // 선택후 화면 내림
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func didChanged(_ sender: UITextField) { // 텍스트 입력/삭제
        // 텍스트값 입력 유무에 따라 save버튼 활성화/비활성화 시킴
        saveButtonStatus()
    }
    
    func saveButtonStatus(){
        if nameField.text?.isEmpty ?? true{ // 값이 없을때
            saveButton.isEnabled = false // 사용할수 없게 함
        }else{ // 값이 있을때
            saveButton.isEnabled = true // 사용할수 있게 함
        }
    }
    
    @IBAction func saveMeal(_ sender: Any) {
        print("save meal")
        mealModel.rating = ratingView.rating
        mealModel.name = nameField.text ?? ""
        mealModel.photo = mealImageView.image // model에 출력
        // model save
        self.performSegue(withIdentifier: "toMealList", sender: self) // call
        
    }
    
    @IBAction func closeVC(_ sender: Any) {
        // self.navigationController.push
        // pop : push로 들어오면 pop으로 나감
        
        // self.present
        // dismiss : present로 들어오면 dismiss로 나감
        
        // presentingViewController가 UINavigationController이냐 맞으면 true 아니면 false
        let presentingVC = presentingViewController is UINavigationController
        
        if presentingVC == true{ // present일때
            self.dismiss(animated: true, completion: nil)
        }else{ // push일때
            self.navigationController?.popViewController(animated: true)
        }
    
    }
    
}
