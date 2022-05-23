//
//  TopListRepositoriesTableViewCell.swift
//  TopJavaRepositories
//
//  Created by Usertqi on 22/05/22.
//

import UIKit
import SDWebImage

class TopListRepositoriesTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!    
    @IBOutlet weak var descriptionLabel: UILabel!

    func configure(repository: Repository?) {
        if let photoUrl = URL(string: repository?.owner.avatarUrl ?? "") {
            avatarImageView.sd_setImage(with: photoUrl)
        }
        ownerLabel.text = repository?.owner.login
        nameLabel.text = repository?.name
        descriptionLabel.text = repository?.description
    }
}
