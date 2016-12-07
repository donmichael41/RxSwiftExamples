//
//  CircleViewModel.swift
//  ColourfullBall
//
//  Created by Hung Nguyen on 12/6/16.
//  Copyright © 2016 Hung Nguyen. All rights reserved.
//

import Foundation
import ChameleonFramework
import RxCocoa
import RxSwift

class CircleViewModel {
    var centerVariable = Variable<CGPoint?>(CGPoint.zero)
    var backgroundColorObservale: Observable<UIColor>!
    
    init() {
        setup()
    }
    
    func setup() {
        backgroundColorObservale =
            centerVariable
            .asObservable()
            .map { center in
                guard let center = center else { return UIColor.flatBlack}
                
                let red: CGFloat = (center.x + center.y).truncatingRemainder(dividingBy: 255.0) / 255.0
                let green: CGFloat = 0.0
                let blue: CGFloat = 0.0
                
                return UIColor(red: red, green: green, blue: blue, alpha: 1.0).flatten()
            }
    }
}
