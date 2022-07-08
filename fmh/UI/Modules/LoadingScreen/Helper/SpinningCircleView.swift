//
//  SpinningCircleView.swift
//  fmh
//
//  Created: 09.06.2022
//

import UIKit

class SpinningCircleView: UIView {
    
    let spinningCircle = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        
        let rect = self.bounds
        let circularPath = UIBezierPath(ovalIn: rect)
        
        spinningCircle.path = circularPath.cgPath
        spinningCircle.fillColor = UIColor.clear.cgColor
        spinningCircle.strokeColor = #colorLiteral(red: 0.8597510457, green: 0.9994370341, blue: 0.9968032241, alpha: 1)
        spinningCircle.lineWidth = 5
        spinningCircle.strokeEnd = 0.9
        spinningCircle.lineCap = .round
        self.layer.addSublayer(spinningCircle)
    }
    
    func animate(){
        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
            self.transform = CGAffineTransform(rotationAngle: .pi)
        }) { (complited) in
            
            UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
                self.transform = CGAffineTransform(rotationAngle: 0)
            }) { (completed) in
                self.animate()
            }
        }
    }
}
