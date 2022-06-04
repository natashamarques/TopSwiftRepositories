//
//  DefaultErrorViewController.swift
//  TopSwiftRepositories
//
//  Created by Natasha Marques on 28/05/22.
//

import UIKit

class DefaultErrorViewController: UIViewController {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    var model: DefaulErrorModel?
    
    init(model: DefaulErrorModel) {
        super.init(nibName: "DefaultErrorViewController", bundle: nil)
        self.model = model
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    func configureView() {
        iconImageView.image = model?.iconImage
        titleLabel.text = model?.title
        subTitleLabel.text = model?.subTitle
    }
}
