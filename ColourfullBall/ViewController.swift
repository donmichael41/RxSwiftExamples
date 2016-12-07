//
//  ViewController.swift
//  ColourfullBall
//
//  Created by Hung Nguyen on 12/6/16.
//  Copyright © 2016 Hung Nguyen. All rights reserved.
//

import ChameleonFramework
import UIKit
import RxSwift
import RxCocoa


class ViewController: UIViewController {

    var circleView: UIView!
    var circleVieModel: CircleViewModel!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    
        
        let colors: [UIColor] = [
            UIColor.flatPurpleDark,
            UIColor.flatWhite
        ]
        
        view.backgroundColor = GradientColor(.topToBottom, frame: view.frame, colors: colors)
    }
    
    func setup() {
        
        circleView = UIView(frame: CGRect(origin: view.center, size: CGSize(width: 100.0, height: 100.0)))
        circleView.layer.cornerRadius = circleView.frame.width / 2.0
        circleView.center = view.center
        circleView.backgroundColor = UIColor.green
        view.addSubview(circleView)
        
        circleVieModel = CircleViewModel()
        
        // Bind the center point of the CircleView to the centerObservable
        circleView.rx.observe(CGPoint.self, "center")
        .bindTo(circleVieModel.centerVariable)
        .addDisposableTo(disposeBag)
        
        // Subscribe to backgroundObservable to get new colors from the ViewModel.
        circleVieModel.backgroundColorObservale
            .subscribe(onNext: { [weak self] (backgroundColor) in
                UIView.animate(withDuration: 0.1) {
                    self?.circleView.backgroundColor = backgroundColor
                    
                    let viewBackgroundColor = UIColor.init(complementaryFlatColorOf: backgroundColor)
                    
                    if viewBackgroundColor != backgroundColor {
                        self?.view.backgroundColor = viewBackgroundColor
                    }
                }
        }).addDisposableTo(disposeBag)
        
        
        
        // Add gesture recognizer
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(circleMoved(_:)))
        circleView.addGestureRecognizer(gestureRecognizer)
    }

    func circleMoved(_ recognizer: UIPanGestureRecognizer) {
        let location = recognizer.location(in: view)
        UIView.animate(withDuration: 0.1) {
            self.circleView.center = location
        }
    }

}

