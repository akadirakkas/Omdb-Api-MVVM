//
//  MainTableViewCell.swift
//  Omdb-Api
//
//  Created by kadir on 30.10.2022.
//

import UIKit

class MainTableViewCell: UITableViewCell {
  
  @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
  static let identifier = "MainTableViewCell"
  
  static func nib()  -> UINib {
    return UINib(nibName: "MainTableViewCell", bundle: nil)
  }
  
//    public func configure(with model: Sarkilar) {
//        musicNameLabel.text = model.sarkiAdi
//  }

    override func awakeFromNib() {
        super.awakeFromNib()
//        movieNameLabel.font = UIFont.themeFont(ofSize: 16, weight: .medium)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
