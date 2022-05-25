//
//  CustomTableViewCell.swift
//  TableViewTest
//
//  Created by Дмитрий Паркалов on 16.02.22.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    
    @IBOutlet weak var fotoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    func configure(name: String?, description: String?, image: UIImage?) {
        fotoImageView.image = image
        nameLabel.text = name
        descriptionLabel.text = description
    }
    
    func configure(group: Group) {
        if let avatarPath = group.avatarImagePath {
            fotoImageView.image = UIImage(named: avatarPath)
        }
        nameLabel.text = group.name
        descriptionLabel.text = group.discription
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        fotoImageView.image = nil
        nameLabel.text = nil
        descriptionLabel.text = nil
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
