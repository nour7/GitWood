//
//  TrendingTableViewCell.swift
//  GitWood
//
//  Created by Nour on 25/02/2019.
//  Copyright © 2019 Nour Saffaf. All rights reserved.
//

import UIKit
import Kingfisher

protocol TrendingCellProtocol {
    func onToggleFavoriteButton()
}

class TrendingTableViewCell: UITableViewCell {
    var delegate: TrendingCellProtocol? = nil
    var favoriteState: Bool = false
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var detailedLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var starButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.avatarImageView?.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(model: TrendingCellModel) {
        self.detailedLabel.text = model.detailed
        self.nameLabel.text = model.name
        self.forksLabel.text = model.forks.forksFormatted
        self.avatarImageView.kf.setImage(with: model.avatarUrl)
        self.starButton.imageView?.image = (model.isFavorited) ? UIImage(named: "star_toggle_on"): UIImage(named: "star_toggle_off")
        self.favoriteState = model.isFavorited
    }
    
    
    @IBAction func toggleFavoriteButton(_ sender: UIButton) {
        delegate?.onToggleFavoriteButton()
        favoriteState = !favoriteState
        self.starButton.imageView?.image = (favoriteState) ? UIImage(named: "star_toggle_on"): UIImage(named: "star_toggle_off")
    }
    
}
