//
//  CustomNavigationController.swift
//  webinar 2
//
//  Created by Дмитрий Паркалов on 23.03.22.
//

import UIKit

class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {

    let interactiveAnimator = InteractiveAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self

        // Do any additional setup after loading the view.
    }
    


}

extension CustomNavigationController {
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {

        if interactiveAnimator.isStartedInteractiveAnimation {
            return interactiveAnimator
        }
        else {
            return nil
        }

    }



    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == .push {
            interactiveAnimator.viewController = toVC
        }
        
        return AnimatorTenHomeWork()
        
    }
    
    
    
}
