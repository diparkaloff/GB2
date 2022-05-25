//
//  Animator.swift
//  webinar 2
//
//  Created by Дмитрий Паркалов on 19.03.22.
//

import UIKit

class Animator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var popStyle: Bool = false

            func transitionDuration(
                using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
                return 1
            }

            func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

                if popStyle {

                    animatePop(using: transitionContext)
                    return
                }

                let tranzitionFrom = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
                let tranzitionTo = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!

                let finalFrameTo = transitionContext.finalFrame(for: tranzitionTo)

                let finalFrameToOff = finalFrameTo.offsetBy(dx: 0, dy: finalFrameTo.height)
                tranzitionTo.view.frame = finalFrameToOff

                transitionContext.containerView.insertSubview(tranzitionTo.view, aboveSubview: tranzitionFrom.view)

                UIView.animate(
                    withDuration: transitionDuration(using: transitionContext),
                    animations: {
                        tranzitionTo.view.frame = finalFrameTo
                }, completion: {_ in
                        transitionContext.completeTransition(true)
                })
            }

            func animatePop(using transitionContext: UIViewControllerContextTransitioning) {

                let tranzitionFrom = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
                let tranzitionTo = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!

                let intialFrameFrom = transitionContext.initialFrame(for: tranzitionFrom)
                let initialFrameFromOff = intialFrameFrom.offsetBy(dx: 0, dy: intialFrameFrom.height)

                transitionContext.containerView.insertSubview(tranzitionTo.view, belowSubview: tranzitionFrom.view)

                UIView.animate(
                    withDuration: transitionDuration(using: transitionContext),
                    animations: {
                        tranzitionFrom.view.frame = initialFrameFromOff
                }, completion: {_ in
                        transitionContext.completeTransition(true)
                })
            }
        }
