//
//  GalleryViewController.swift
//  webinar 2
//
//  Created by Дмитрий Паркалов on 21.02.22.
//

import UIKit

class GalleryViewController: UIViewController {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    let reuseIdentifier = "reuseIdentifier"
    var fotoArray = [String]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "GalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
   
    }
   
    @objc func onTap() {
        self.navigationController?.popViewController(animated: true)
    }
    

}



extension GalleryViewController: UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fotoArray.count
    }
    
    

    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? GalleryCollectionViewCell else {return UICollectionViewCell()}
        cell.configure(image: UIImage(named: fotoArray[indexPath.item]))
        return cell
    }
    
    
    
}

extension GalleryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let view = UIView(frame: self.view.frame)
        view.backgroundColor = UIColor.white
        let imageView = UIImageView(frame: view.frame)
        self.view.addSubview(view)
        view.addSubview(imageView)
        imageView.image = UIImage(named: fotoArray[indexPath.item])
        imageView.contentMode = .scaleAspectFit
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(onTap))
        recognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(recognizer)
        
        
        
    }
}

extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 2 - 10, height: collectionView.bounds.height / 2 - 10)
    }
}
