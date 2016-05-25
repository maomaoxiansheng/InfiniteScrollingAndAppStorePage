//
//  InfiniteScrollingCVCell.swift
//  AppStorePage
//
//  Created by MOMO on 16/5/25.
//  Copyright © 2016年 MOMO. All rights reserved.
//

import UIKit

class InfiniteScrollingCVCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setImageWithName(imageName:String)
    {
        self.imageView.image = UIImage.init(named: imageName)
    }
}
