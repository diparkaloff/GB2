//
//  GalleryCollectionViewCell.swift
//  webinar 2
//
//  Created by Дмитрий Паркалов on 21.02.22.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var fotoImageView: UIImageView!
    
    
    
    func configure(image: UIImage?) {
        fotoImageView.image = image
    }
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        fotoImageView.image = nil
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
