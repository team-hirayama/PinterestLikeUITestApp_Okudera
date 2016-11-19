//
//  FetchData.swift
//  PinterestLikeUITestApp
//
//  Created by OkuderaYuki on 2016/11/19.
//  Copyright © 2016年 YukiOkudera. All rights reserved.
//

import UIKit

class FetchData: NSObject {
    class func plistData(plistName: String) -> PhotosModel {
        var photosModel = PhotosModel()
        
        guard let plistPath = Bundle.main.path(forResource: plistName, ofType: "plist"),
            let contentsOfFile = NSDictionary(contentsOfFile: plistPath),
            let photos = contentsOfFile.object(forKey: "photos") as? NSArray else {
                return photosModel
        }
        if photos.count == 0 {
            return photosModel
        }
        
        for photo in photos {
            var photoModel = PhotoModel()
            photoModel.caption = (photo as AnyObject)["caption"] as! String
            photoModel.comment = (photo as AnyObject)["comment"] as! String
            photoModel.image = (photo as AnyObject)["image"] as! String
            
            photosModel.photos.append(photoModel)
        }
        
        return photosModel
        
    }
}
