//
//  PhotosViewController.swift
//  PinterestLikeUITestApp
//
//  Created by OkuderaYuki on 2016/11/19.
//  Copyright © 2016年 YukiOkudera. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var photosModel = PhotosModel()
    
    let photoCollectionViewLayout = PhotoCollectionViewLayout()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        let plistName = "photos"
        photosModel = FetchData.plistData(plistName: plistName)
        
        collectionView.collectionViewLayout = photoCollectionViewLayout
        
        photoCollectionViewLayout.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosModel.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCollectionViewCell
        
        cell.imageView.image = UIImage(named: "\(photosModel.photos[indexPath.row].image)" + ".jpeg")
        cell.captionLabel.text = photosModel.photos[indexPath.row].caption
        cell.commentLabel.text = photosModel.photos[indexPath.row].comment
        return cell
    }
}

// MARK: - PhotoCollectionViewLayoutDelegate
extension PhotosViewController: PhotoCollectionViewLayoutDelegate {
    func heightForImageAtIndexPath(_ collectionView :UICollectionView,indexPath :IndexPath,width :CGFloat) -> CGFloat {
        if let image = UIImage(named: "\(photosModel.photos[indexPath.row].image)" + ".jpeg") {
            return PhotoCollectionViewCell.imageHeightWithImage(image, cellWidth: width)
        }
        return 0.0
    }
    
    func heightForBodyAtIndexPath(_ collectionView :UICollectionView,indexPath :IndexPath,width :CGFloat) -> CGFloat {
        return PhotoCollectionViewCell.bodyHeightWithText(photosModel.photos[indexPath.row].caption, commentText: photosModel.photos[indexPath.row].comment, cellWidth: width)
    }
}






