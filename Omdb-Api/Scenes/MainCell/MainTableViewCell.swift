//
//  MainTableViewCell.swift
//  Omdb-Api
//
//  Created by kadir on 30.10.2022.
//

import UIKit
import SDWebImage

class MainTableViewCell: UITableViewCell {
  
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
  static let identifier = "MainTableViewCell"
  
  static func nib()  -> UINib {
    return UINib(nibName: "MainTableViewCell", bundle: nil)
  }
  
    public func configure(with model: Movie) {
        movieNameLabel.text = model.title
        movieImage?.sd_setImage(
            with: URL(string: model.poster!),
            placeholderImage:  UIImage(named: "aaaa")
        )
        typeLabel.text = model.type?.rawValue.capitalizingFirstLetter()
        yearLabel.text = model.year
  }

    override func awakeFromNib() {
        super.awakeFromNib()
         setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setupUI() {
        self.movieNameLabel.font = UIFont.themeFont(ofSize: 16, weight: .medium)
        movieImage.layer.cornerRadius = 12
        movieImage.layer.masksToBounds = true
        self.yearLabel.font = UIFont.themeFont(ofSize: 14, weight: .light)
        self.typeLabel.font = UIFont.themeFont(ofSize: 14, weight: .light)
    }
    
}
