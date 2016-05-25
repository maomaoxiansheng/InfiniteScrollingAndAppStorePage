//
//  AppStoreCVCell.swift
//  AppStorePage
//
//  Created by MOMO on 16/5/23.
//  Copyright © 2016年 MOMO. All rights reserved.
//

import UIKit

class AppStoreCVCell: UICollectionViewCell {

        /// 头像
    @IBOutlet weak var appIconImageView: UIImageView!
        /// 名称
    @IBOutlet weak var appNameLabel: UILabel!
        /// 类型
    @IBOutlet weak var appTypeLabel: UILabel!
        /// 价格
    @IBOutlet weak var appPriceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        appIconImageView.layer.cornerRadius = 3
        appIconImageView.clipsToBounds = true
        // Initialization code
    }

}
