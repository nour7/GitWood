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
    func onToggleFavoriteButton(at indexPath: IndexPath)
}

class TrendingTableViewCell: UITableViewCell {
    var delegate: TrendingCellProtocol? = nil
    var favoriteState: Bool = false
    var indexPath: IndexPath = IndexPath(item: -1, section: 0)
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
    
    func configure(model: TrendingCellModel, at indexPath: IndexPath) {
        self.detailedLabel.text = model.detailed
        self.nameLabel.text = model.name
        self.forksLabel.text = model.stars.numberFormatted
        self.avatarImageView.kf.setImage(with: model.avatarUrl)
        self.starButton.setImage((model.isFavorited) ? UIImage(named: "star_toggle_on"): UIImage(named: "star_toggle_off"), for: .normal)
        self.favoriteState = model.isFavorited
        self.indexPath = indexPath
    }
    
    
    @IBAction func toggleFavoriteButton(_ sender: UIButton) {
        delegate?.onToggleFavoriteButton(at: indexPath)
        favoriteState = !favoriteState
         self.starButton.setImage((favoriteState) ? UIImage(named: "star_toggle_on"): UIImage(named: "star_toggle_on"), for: .normal)
        
    }
    
}
