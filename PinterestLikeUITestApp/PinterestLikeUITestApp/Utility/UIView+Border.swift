//
//  UIView+Border.swift
//  PinterestLikeUITestApp
//
//  Created by OkuderaYuki on 2016/11/19.
//  Copyright © 2016年 YukiOkudera. All rights reserved.
//

import UIKit

extension UIView {
    /// 角丸
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
