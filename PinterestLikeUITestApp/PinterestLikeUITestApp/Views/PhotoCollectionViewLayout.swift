//
//  PhotoCollectionViewLayout.swift
//  PinterestLikeUITestApp
//
//  Created by OkuderaYuki on 2016/11/19.
//  Copyright © 2016年 YukiOkudera. All rights reserved.
//

import UIKit

protocol PhotoCollectionViewLayoutDelegate {
    func heightForImageAtIndexPath(_ collectionView: UICollectionView,indexPath: IndexPath,width: CGFloat) -> CGFloat
    func heightForBodyAtIndexPath(_ collectionView: UICollectionView,indexPath: IndexPath,width: CGFloat) -> CGFloat
}

class PhotoCollectionViewLayout: UICollectionViewLayout {
    let numberOfColumns = 2
    let cellMargin: CGFloat = 10.0
    var delegate: PhotoCollectionViewLayoutDelegate! = nil
    var cachedAttributes: Array<UICollectionViewLayoutAttributes> = [];
    var contentHeight: CGFloat = 0.0
    
    fileprivate func contentWidth() -> CGFloat {
        guard let collectionView = collectionView else {
            return 0
            
        }
        return collectionView.bounds.width - (collectionView.contentInset.left + collectionView.contentInset.right)
    }
    
    // MARK: - UICollectionViewLayout
    override var collectionViewContentSize : CGSize {
        return CGSize(width: contentWidth(), height: contentHeight)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes: Array<UICollectionViewLayoutAttributes> = []
        
        for attribute in cachedAttributes {
            if (attribute.frame.intersects(rect)) {
                layoutAttributes.append(attribute)
            }
        }
        return layoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return self.cachedAttributes[(indexPath as NSIndexPath).item]
    }
    
    override func prepare() {

        // キャッシュ済みであれば、return
        if self.cachedAttributes.count > 0 {
            return;
        }
        
        var column = 0
        let totalHorizontalMargin: CGFloat = (cellMargin * (CGFloat(numberOfColumns - 1)))
        let cellWidth: CGFloat = (contentWidth() - totalHorizontalMargin) / CGFloat(numberOfColumns)
        
        var cellOriginXList = Array<CGFloat>()
        for i in 0..<numberOfColumns {
            let originX: CGFloat  = CGFloat(i)*(cellWidth + cellMargin)
            cellOriginXList.append(originX)
        }
        var currentCellOriginYList: Array<CGFloat> = Array<CGFloat>()
        for _ in 0..<numberOfColumns {
            currentCellOriginYList.append(0.0)
        }
        
        // サイズ,座標
        for item in 0..<self.collectionView!.numberOfItems(inSection: 0) {
            let indexPath : IndexPath = IndexPath(row: item, section: 0)
            
            // セルのイメージの高さ セルのテキストの高さ
            let imageHeight: CGFloat  = self.delegate.heightForImageAtIndexPath(
                self.collectionView!, indexPath: indexPath, width: cellWidth)
            
            let bodyHeight: CGFloat  = self.delegate.heightForBodyAtIndexPath(
                self.collectionView!, indexPath: indexPath, width: cellWidth)
            let cellHeight: CGFloat  = imageHeight + bodyHeight
            
            let cellFrame: CGRect = CGRect(x: cellOriginXList[column],
                                           y: currentCellOriginYList[column],
                                           width: cellWidth,
                                           height: cellHeight)
            
            let attributes = PhotoCollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.height = imageHeight
            attributes.frame = cellFrame;
            self.cachedAttributes.append(attributes)
            
            self.contentHeight = max(contentHeight, cellFrame.maxY)
            
            
            currentCellOriginYList[column] = currentCellOriginYList[column] + cellHeight + cellMargin
            var nextColumn: Int = 0
            var minOriginY: CGFloat = CGFloat.greatestFiniteMagnitude
            let currentCellOriginYList: NSArray = NSArray(array: currentCellOriginYList)
            currentCellOriginYList.enumerateObjects({ originY, index, stop in
                if (originY as! CGFloat) < minOriginY {
                    minOriginY = CGFloat(originY as! NSNumber)
                    nextColumn = index;
                }
            })
            
            column = nextColumn;
        }
    }
}
