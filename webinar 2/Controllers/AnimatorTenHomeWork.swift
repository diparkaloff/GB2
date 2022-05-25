//
//  AnimatorTenHomeWork.swift
//  webinar 2
//
//  Created by Дмитрий Паркалов on 23.03.22.
//

import UIKit

class AnimatorTenHomeWork: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let sourceViewController = transitionContext.viewController(forKey: .from),
              let destinationViewController = transitionContext.viewController(forKey: .to),
              let destinationView = destinationViewController.view,
              let sourceView = sourceViewController.view
        else {return}
        
        let containerView = transitionContext.containerView
        
        containerView.addSubview(destinationView)
        destinationView.frame = sourceView.frame
        
        destinationView.transform = CGAffineTransform(translationX: sourceView.frame.width, y: 0)
        
        UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext),
                                delay: 0,
                                options: []) {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                let transition = CGAffineTransform(translationX: -sourceView.frame.width / 2, y: 0)
                sourceView.transform = transition
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                destinationView.transform = .identity
            }
            
        }
    
    completion: { isSuccessfully in transitionContext.completeTransition(isSuccessfully)
        
        }
    }
}

