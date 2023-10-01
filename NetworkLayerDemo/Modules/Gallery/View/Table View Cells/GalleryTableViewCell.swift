//
//  GalleryTableViewCell.swift
//  NetworkLayerDemo
//
//  Created by Gaurav Bisht on 24/06/23.
//

import UIKit

class GalleryTableViewCell: UITableViewCell {
    
    //MARK: - Constants
    struct Constants {
        static let imageViewCornerRadius: CGFloat = 10.0
    }
    
    //MARK: - IBOutlets
    @IBOutlet private weak var loadedImageView: LoadedImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var rowLabel: UILabel!
    
    //MARK: - Static properties
    static let identifierOrNibName = "GalleryTableViewCell"
    
    //MARK: - View life cycle methods
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        loadedImageView.layer.cornerRadius = Constants.imageViewCornerRadius
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Public methods
    func configureCellWith(imageURLString: String, title: String, row: Int) {
        self.titleLabel.text = title
        self.rowLabel.text = "\(row)"
        guard let imageUrl = URL(string: imageURLString) else {return}
        loadedImageView.loadImage(imageURL: imageUrl, placeHolderImage: "")
    }
}
