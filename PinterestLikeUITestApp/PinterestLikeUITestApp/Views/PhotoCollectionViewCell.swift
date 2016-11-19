//
//  PhotoCollectionViewCell.swift
//  PinterestLikeUITestApp
//
//  Created by OkuderaYuki on 2016/11/19.
//  Copyright © 2016年 YukiOkudera. All rights reserved.
//

import UIKit
import AVFoundation

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    /// 画像の高さ算出
    class func imageHeightWithImage(_ image: UIImage, cellWidth: CGFloat) -> CGFloat {
        let boundingRect: CGRect  =  CGRect(x: 0, y: 0, width: cellWidth, height: CGFloat.greatestFiniteMagnitude)
        let rect: CGRect = AVMakeRect(aspectRatio: image.size, insideRect: boundingRect)
        
        return rect.size.height;
    }
    
    /// Labelの高さ算出 (captionLabel and commnetLabel)
    class func bodyHeightWithText(_ captionText: String, commentText: String, cellWidth: CGFloat) -> CGFloat {
        let padding: CGFloat = 4.0
        let width: CGFloat = (cellWidth - padding * 2)
        let font = UIFont.systemFont(ofSize: 17.0)
        let attributes = [NSFontAttributeName:font]
        
        let captionRect: CGRect = (captionText as NSString).boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude),
                                                                         options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                                         attributes: attributes,
                                                                         context: nil)
        
        let commentRect: CGRect = (commentText as NSString).boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude),
                                                                         options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                                         attributes: attributes,
                                                                         context: nil)
        
        return padding + ceil(captionRect.size.height) + ceil(commentRect.size.height)
    }
}
