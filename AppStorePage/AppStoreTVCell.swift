//
//  AppStoreTVCell.swift
//  AppStorePage
//
//  Created by MOMO on 16/5/23.
//  Copyright © 2016年 MOMO. All rights reserved.
//

import UIKit

class AppStoreTVCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBOutlet weak var headerView: AppStoreHeaderView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerNib(UINib.init(nibName: "AppStoreCVCell", bundle: NSBundle.mainBundle()), forCellWithReuseIdentifier: "AppStoreCVCell")
        collectionView.backgroundColor = UIColor.whiteColor()
        
        
        self.headerView = NSBundle.mainBundle().loadNibNamed("AppStoreHeaderView", owner: nil, options: nil).last as! AppStoreHeaderView
        
        self.contentView.addSubview(self.headerView)
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


extension AppStoreTVCell : UICollectionViewDataSource
{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 10
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cellIdentifier = "AppStoreCVCell"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        return cell
    }
}

extension AppStoreTVCell : UICollectionViewDelegate
{
    
}

extension AppStoreTVCell : UICollectionViewDelegateFlowLayout
{
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(100, 170)
    }
}


