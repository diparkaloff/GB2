//
//  InteractiveAnimator.swift
//  webinar 2
//
//  Created by Дмитрий Паркалов on 23.03.22.
//

import UIKit

class InteractiveAnimator: UIPercentDrivenInteractiveTransition {

    var isStartedInteractiveAnimation = false
    var isCompleteAnimation = false
    
    var viewController: UIViewController? {
        didSet {
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
            viewController?.view.addGestureRecognizer(panGestureRecognizer)
        }
    }
    
    @objc func onPan(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            isStartedInteractiveAnimation = true
            self.viewController?.navigationController?.popViewController(animated: true)
            self.pause()
        case .changed:
            guard let recognizerView = recognizer.view else {return}
            var translation = recognizer.translation(in: recognizer.view)
            if translation.x > 0 {return}
            
            translation.x = -translation.x
            let progress = translation.x / recognizerView.frame.width
            if progress > 0.3 {
                isCompleteAnimation = true
            }
            self.update(progress)
        case .ended:
            isStartedInteractiveAnimation = false
            if isCompleteAnimation {
                self.finish()
            }
            else {
                self.cancel()
            }
        default:
            isStartedInteractiveAnimation = false
        }
    }
    
    
}

