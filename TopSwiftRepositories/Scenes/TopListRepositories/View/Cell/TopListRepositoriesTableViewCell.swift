//
//  TopListRepositoriesTableViewCell.swift
//  TopSwiftRepositories
//
//  Created by Natasha Marques on 28/05/22.
//

import UIKit
import SDWebImage

class TopListRepositoriesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var numberStarsLabel: UILabel!
    @IBOutlet weak var numberForksLabel: UILabel!
    
    func configureCell(repository: Repository?) {
        configureImageView()
        if let photoUrl = URL(string: repository?.owner.avatarUrl ?? "") {
            avatarImageView.sd_setImage(with: photoUrl)
        }
        repositoryNameLabel.text = repository?.name
        ownerNameLabel.text = repository?.owner.login
        descriptionLabel.text = repository?.description
        numberStarsLabel.text = String(repository?.stargazersCount ?? 0)
        numberForksLabel.text = String(repository?.forksCount ?? 0)
    }
    
    func configureImageView() {
        avatarImageView.layer.masksToBounds = false
        avatarImageView.layer.cornerRadius = 15
        avatarImageView.clipsToBounds = true
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
}
