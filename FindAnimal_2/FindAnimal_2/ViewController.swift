//
//  ViewController.swift
//  FindAnimal_2
//
//  Created by 전상민 on 2021/05/22.
//

import UIKit
import Vision
import CoreML

class ViewController: UIViewController {
    
    @IBOutlet weak var animalImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    
    // take photo >
    var picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self // 사진을 찍거나 선택했을때 받을수 있음
        
    }
    
    // 카메라,앨범.. 에 접근하려면 info에서 접근허용을 해야한다.
    @IBAction func showCamera(_ sender: Any) {
        // camera 선택
        picker.sourceType = .camera
        self.present(picker, animated: true, completion: nil)
    }
    @IBAction func openPhotoLibrary(_ sender: Any) {
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
    
    
    // ML로 보냄 >

    func processImage(_ image: UIImage){
        // ML model
        // model에서 찾기
        // MLmodel 가져오기 >
        if let model = try? VNCoreMLModel(for: MyImageClassifier_1().model){
        
            // model에 맞게 반환 해줌 >
            let request = VNCoreMLRequest(model: model) { (request, error) in

                // 모든 list의 결과를 다 가져옴
                if let results = request.results as? [VNClassificationObservation]{
                    // 정렬를 사용 >

                    let firstValue = results.sorted(by: { (lh,rh) -> Bool in

                        return lh.confidence > rh.confidence // 오름차순
                    }).first // sort된것중 첫번째값

                    if let bestMatch = firstValue{
                        self.nameLabel.text = bestMatch.identifier
                        // "\(bestMatch.confidence * 100) %"
                        self.percentLabel.text = (bestMatch.confidence * 100).description + "%"
                    }
                }
            }
            // image data >
            if let imageData = image.jpegData(compressionQuality: 0.7){
                // image data를 가져올수 있으면
                let handler = VNImageRequestHandler(data: imageData, options: [:])
                // model을 array로 받음
                try? handler.perform([request])
            }

        }else{

        }
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    // 이미지를 선택하거나 사진찍었을때 선택한 이미지에 대한 처리 >
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 이미지를 가져옴(live photo..여러가지를 가져올수 있다.)
        // if let - as? UIImage : casting을 할 수 있는지 확인(UIImage형태로 가져올 수 있는지)
        if let image = info[.originalImage] as? UIImage{
            self.animalImageView.image = image
            // processImage() 호출 >
            processImage(image)
        }
        
        // 선택하면 화면 내림 >
        picker.dismiss(animated: true, completion: nil)
        
    }
}
