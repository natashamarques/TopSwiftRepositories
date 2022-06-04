//
//  ListPullRequestsTableViewCell.swift
//  TopSwiftRepositories
//
//  Created by Natasha Marques on 28/05/22.
//

import UIKit

class ListPullRequestsTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configureCell(pullRequest: PullRequest?) {
        if let photoUrl = URL(string: pullRequest?.user.avatarUrl ?? "") {
            avatarImageView.sd_setImage(with: photoUrl)
        }
        configureImageView()
        titleLabel.text = pullRequest?.title
        ownerLabel.text = pullRequest?.user.login
        descriptionLabel.text = pullRequest?.body
    }
    
    func configureImageView() {
        avatarImageView.layer.masksToBounds = false
        avatarImageView.layer.cornerRadius = 15
        avatarImageView.clipsToBounds = true
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
}
