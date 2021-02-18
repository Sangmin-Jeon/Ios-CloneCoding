//
//  FaceView.swift
//  Facelt
//
//  Created by 전상민 on 2021/02/18.
//

import UIKit

class FaceView: UIView {


    override func draw(_ rect: CGRect) { // Rect는 단지 뷰의 어떤 부분을 그릴 것인지를 말하는 최적화
        // frame은 슈퍼뷰 좌표계 안에서 나를 포함하는 직사각형이다. 슈퍼뷰 안에서 그릴수 없음, 내 좌표 시스템안에서 그려야 한다.(bounds)
        
        let skullRadius = min(bounds.size.width,bounds.size.height) / 2 // 얼굴의 가운데와 (반경)으로 시작하기 위한 두 변수
        /*
            center는 상위뷰 좌표의 center이다. 여기서는 나의 좌표를 알려줄수 있는것이 필요
            bounds의 실제 center를 얻는 방법
            1) convert()사용(convertPoint): convert(center, from: superview) => superview 좌표계의 center의 포인트를 나의 좌표계의 포인터로 바꿈
            2) CGPoint()사용
         */
        let skullCenter =  CGPoint(x: bounds.minX, y: bounds.midY) // midX,Y는 CGRect안에 있는 프로퍼티
        
        // 동그라미로 된 얼굴의 Bezierpath를 생성
        let skull = UIBezierPath(arcCenter: skullCenter, radius: skullRadius, startAngle: 0.0, endAngle: CGFloat(2*Double.pi), clockwise: false)
        /*
            arcCenter(호의 중심): skullCenter가 내가 그릴 호의 중심, 얼굴이 된다.
            radius: 얼굴을 그릴 반지름
            startAngle에서 endAngle은 radians(호도법)으로 되어있다.(0~2π사이값으로 표시)
            UIBezierPath에서는 double타입 사용하면 안됨 CGFloat타입이어야 한다.
            0.0은 리터럴(직접 값을 나타내는 형태)이기 때문에 수많은 타입으로 변환할 수 있다.(스위프트는 리터럴에 대해 자동으로 타입변환을 할수 있음)
            clockwise: false => 반시계 방향
        */
        // skull의 속성 설정
        skull.lineWidth = 5.0 // 선굵기
        UIColor.blue.set() // 컬러설정(블루) , set() => setFill과 setStroke모두 설정
        skull.stroke() // 얼굴을 그림
    }

}

