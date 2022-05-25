//
//  Galleryview.swift
//  webinar 2
//
//  Created by Дмитрий Паркалов on 3.03.22.
//

import UIKit

@IBDesignable class GalleryView: UIView {
         
    var view: UIView?
    
    var interactiveAnimator: UIViewPropertyAnimator!
    var mainImageView = UIImageView()
    var secondaryImageView = UIImageView()
    var images = [UIImage]()
    var isLeftSwipe = false
    var isRightSwipe = false
    var currentIndex = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
     
    func loadFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "GalleryView", bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {return UIView()}
        return view
    
    }
    
     
    func setup() {
        
         view = loadFromNib()
         guard let view = view else {return}
         view.frame = bounds
         view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
         addSubview(view)

         let recognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
         self.addGestureRecognizer(recognizer)
         
         mainImageView.backgroundColor = UIColor.white
         mainImageView.frame = self.bounds
        
         addSubview(mainImageView)
         
        
         secondaryImageView.backgroundColor = UIColor.white
         secondaryImageView.frame = self.bounds
         secondaryImageView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
         addSubview(secondaryImageView)
        
    
    }
    
    
     
    func onChange(isLeft: Bool) {
                 
        self.mainImageView.transform = .identity
        self.secondaryImageView.transform = .identity
        self.mainImageView.image = images[currentIndex]
 
        if isLeft {
            self.secondaryImageView.image = images[self.currentIndex + 1]
            self.secondaryImageView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
        }
        else {
            self.secondaryImageView.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
            self.secondaryImageView.image = images[currentIndex - 1]
        }
    
    }
    
    
    func onChangeCompletion(isLeft: Bool) {
        
        self.mainImageView.transform = .identity
        self.secondaryImageView.transform = .identity
        if isLeft {
            self.currentIndex += 1
        }
        else {
            self.currentIndex -= 1
        }
        self.mainImageView.image = self.images[self.currentIndex]
        self.bringSubviewToFront(self.mainImageView)
        
    }
    
    
    @objc func onPan(_ recognizer: UIPanGestureRecognizer) {
        if let animator = interactiveAnimator,
           animator.isRunning {
            return
        }
        
        switch recognizer.state {
        case .began:
            self.mainImageView.transform = .identity
            self.mainImageView.image = images[currentIndex]
            self.secondaryImageView.transform = .identity
            self.bringSubviewToFront(self.mainImageView)
            
            interactiveAnimator?.startAnimation()
            interactiveAnimator = UIViewPropertyAnimator(duration: 0.5,
                                                         curve: .easeInOut,
                                                         animations: { [weak self] in
                                                            self?.mainImageView.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
                                                         })
            interactiveAnimator.pauseAnimation()
            isLeftSwipe = false
            isRightSwipe = false
            
        case .changed:
            var translation = recognizer.translation(in: self.view)
            
            
            if translation.x < 0 && (!isLeftSwipe) {
                if self.currentIndex == (images.count - 1) {
                    interactiveAnimator.stopAnimation(true)
                    return
                }
                onChange(isLeft: true)
                
                
                interactiveAnimator.stopAnimation(true)
                interactiveAnimator.addAnimations { [weak self] in
                    self?.mainImageView.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
                    self?.secondaryImageView.transform = .identity
                }
                interactiveAnimator.addCompletion({ [weak self] _ in
                    self?.onChangeCompletion(isLeft: true)
                })
                
                interactiveAnimator.startAnimation()
                interactiveAnimator.pauseAnimation()
                isLeftSwipe = true
            }
            
            if translation.x > 0 && (!isRightSwipe) {
                if self.currentIndex == 0 {
                    interactiveAnimator.stopAnimation(true)
                    return
                }
             
                onChange(isLeft: false)
                interactiveAnimator.stopAnimation(true)
                interactiveAnimator.addAnimations { [weak self] in
                    self?.mainImageView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
                    self?.secondaryImageView.transform = .identity
                }
                interactiveAnimator.addCompletion({ [weak self] _ in
                    self?.onChangeCompletion(isLeft: false)
                })
                interactiveAnimator.startAnimation()
                interactiveAnimator.pauseAnimation()
                isRightSwipe = true
            }
            
            if isRightSwipe && (translation.x < 0) {return}
            if isLeftSwipe && (translation.x > 0) {return}
            
            if translation.x < 0 {
                translation.x = -translation.x
            }
            interactiveAnimator.fractionComplete = translation.x / (UIScreen.main.bounds.width)
            
        case .ended:
            if let animator = interactiveAnimator,
               animator.isRunning {
                return
            }
            var translation = recognizer.translation(in: self.view)
            
            if translation.x < 0 {translation.x = -translation.x}
            
            if (translation.x / (UIScreen.main.bounds.width)) > 0.5  {
                interactiveAnimator.startAnimation()
            }
            else {
                interactiveAnimator.stopAnimation(true)
                interactiveAnimator.finishAnimation(at: .start)
                interactiveAnimator.addAnimations { [weak self] in
                    self?.mainImageView.transform = .identity
                    guard let weakSelf = self else {return}
                    if weakSelf.isLeftSwipe {
                        self?.secondaryImageView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
                    }
                    if weakSelf.isRightSwipe {
                        self?.secondaryImageView.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
                    }
                }
                
                interactiveAnimator.addCompletion({ [weak self] _ in
                    self?.mainImageView.transform = .identity
                    self?.secondaryImageView.transform = .identity
                })
                
                interactiveAnimator.startAnimation()
            }
        default:
            return
        }
    }
    
    
    func setImages(images: [UIImage]) {
        self.images = images
        if self.images.count > 0 {
            self.mainImageView.image = self.images.first
        }
    }
    
}
