//
//  MyPhotoController.swift
//  webinar 2
//
//  Created by Дмитрий Паркалов on 3.03.22.
//

import UIKit

class MyPhotoController: UIViewController {
    
    
    @IBOutlet weak var galleryView: GalleryView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let images = [UIImage(named: "15")!, UIImage(named: "2")!, UIImage(named: "3")!, UIImage(named: "4")!, UIImage(named: "5")!, UIImage(named: "13")!, UIImage(named: "12")!, UIImage(named: "16")!, UIImage(named: "13")!, UIImage(named: "11")!, UIImage(named: "17")!]
        galleryView.setImages(images: images)
        
    }
    
}
    
    
    
