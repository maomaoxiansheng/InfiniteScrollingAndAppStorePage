//
//  InfiniteScrollingView.swift
//  AppStorePage
//
//  Created by MOMO on 16/5/25.
//  Copyright © 2016年 MOMO. All rights reserved.
//

import UIKit

class InfiniteScrollingView: UIView {

    var scrollingCollectionView:UICollectionView!
    var imagesUrlArray = [String]()
    var InfiniteScrollingCVCellIdentifier = "InfiniteScrollingCVCell"
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clearColor()
        
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .Horizontal
        self.scrollingCollectionView = UICollectionView.init(frame:CGRectMake(0, 0, frame.size.width, frame.size.height), collectionViewLayout: flowLayout)
        /* 分页 */
        self.scrollingCollectionView.pagingEnabled = true
        self.scrollingCollectionView.delegate = self;
        self.scrollingCollectionView.dataSource = self;
        self.scrollingCollectionView.showsHorizontalScrollIndicator = false
        self.scrollingCollectionView.backgroundColor = UIColor.clearColor()
        
        self.scrollingCollectionView.registerNib(UINib.init(nibName:"InfiniteScrollingCVCell", bundle: NSBundle.mainBundle()), forCellWithReuseIdentifier:InfiniteScrollingCVCellIdentifier)
        
        self.addSubview(self.scrollingCollectionView)
        
        //  若是只有两个图片，还想无限滚动，那么就是["1.jpg","2.jpg","1.jpg","2.jpg"]，数组的成员顺序拼接
        //  只有一张不会无限滚动的，也没必要
        imagesUrlArray = ["1.jpg","2.jpg","3.jpg","4.jpg"]
        
        
        //  开始的时候主动调用一次
        scrollViewDidEndDecelerating(self.scrollingCollectionView)
    
    }
    
    //MARK: Methods
    /**
     重新排列数组元素
     
     - parameter imagesArray: 数组
     - parameter startIndex:  开始的index
     - parameter endIndex:    结束的index
     */
    func refreshImagesArray(imagesArray:[String],startIndex:Int,endIndex:Int)
    {
        // 必须要判断是不是大于等于
        if startIndex >= endIndex {
            return
        }
        
        swap(&imagesUrlArray[startIndex], &imagesUrlArray[endIndex])
        
        // 一直进行交换，知道上面的判断return
        refreshImagesArray(imagesUrlArray, startIndex: startIndex + 1, endIndex: endIndex - 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
extension InfiniteScrollingView : UICollectionViewDelegateFlowLayout
{
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(self.frame.size.width, self.frame.size.height)
    }
}

extension InfiniteScrollingView : UICollectionViewDelegate
{
    
}
extension InfiniteScrollingView : UICollectionViewDataSource
{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.imagesUrlArray.count
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(InfiniteScrollingCVCellIdentifier, forIndexPath: indexPath) as! InfiniteScrollingCVCell
        cell.setImageWithName(self.imagesUrlArray[indexPath.row])
        
        return cell
    }
}

extension InfiniteScrollingView : UIScrollViewDelegate
{
    func scrollViewDidEndDecelerating(scrollView: UIScrollView)
    {
        // 这里要判断是第一个还是处于最后一个 
        let contentOffset:CGFloat = self.scrollingCollectionView.frame.size.width * CGFloat(imagesUrlArray.count - 1)
        if (scrollView.contentOffset.x >= contentOffset)
        {
            if imagesUrlArray.count > 2
            {
                refreshImagesArray(imagesUrlArray, startIndex: 0, endIndex: imagesUrlArray.count - 1)
                refreshImagesArray(imagesUrlArray, startIndex: 0, endIndex: 1)
                refreshImagesArray(imagesUrlArray, startIndex: 2, endIndex: imagesUrlArray.count - 1)
                let indexPath : NSIndexPath = NSIndexPath(forRow: 1, inSection: 0)
                self.scrollingCollectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Left, animated: false)
            }
        }
        else if (scrollView.contentOffset.x == 0)
        {
            if imagesUrlArray.count > 2
            {
                refreshImagesArray(imagesUrlArray, startIndex: 0, endIndex: imagesUrlArray.count - 1)
                refreshImagesArray(imagesUrlArray, startIndex: 0, endIndex: imagesUrlArray.count - 3)
                refreshImagesArray(imagesUrlArray, startIndex: imagesUrlArray.count - 2, endIndex: imagesUrlArray.count - 1)
                let indexPath : NSIndexPath = NSIndexPath(forRow: imagesUrlArray.count - 2, inSection: 0)
                self.scrollingCollectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Left, animated: false)
            }
        }

    }
}






