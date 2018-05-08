//
//  WYButton.swift
//  SwiftDemo
//
//  Created by 武月洋 on 2018/5/7.
//  Copyright © 2018年 武月洋. All rights reserved.
//

import UIKit

/// 按钮布局类型
///
/// - imageLeft: 图片在左
/// - imageRight: 图片在右
/// - imageTop: 图片在上
/// - imageBottom: 图片在下
enum WYButtonLayoutType {
    case imageLeft, imageRight, imageTop, imageBottom
}

class WYButton: UIButton {
    
    // 图片尺寸
    var imageSize: CGSize
    // 选中的和未选中的图片
    // 标题样式
    // 标题
    var wyButtonType: WYButtonLayoutType
    
    init(type: WYButtonLayoutType, imageSize: CGSize) {
        
        self.wyButtonType = type
        self.imageSize = imageSize
        super.init(frame: .zero)
        self.imageView?.contentMode = UIViewContentMode.scaleAspectFit
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setBackgroundColor(color: UIColor, state: UIControlState) {
        
        let image = self.image(color: color)
        self.setBackgroundImage(image, for: state)
    }
    
    func image(color: UIColor) -> UIImage {
        let rect = CGRect(x:0,y:0,width:1,height:1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        
        switch wyButtonType {
            
        case .imageLeft:
            return contentRect
            
        case .imageRight:
            let x = contentRect.size.width - self.imageSize.width - 5
            let y = (contentRect.size.height - self.imageSize.height) / 2
            return CGRect(x: x, y: y, width: self.imageSize.width, height: self.imageSize.height)
            
        case .imageTop:
            let x = (contentRect.width - self.imageSize.width) / 2
            let y: CGFloat = 0.0
            return CGRect(x: x, y: y, width: self.imageSize.width, height: self.imageSize.height)
            
        case .imageBottom:
            return contentRect
        }
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        
        switch wyButtonType {
            
        case .imageLeft:
            return contentRect
            
        case .imageRight:
            let width = contentRect.size.width - self.imageSize.width - 10
            return CGRect(x: 5, y: 0, width: width, height: contentRect.size.height)
            
        case .imageTop:
            let x: CGFloat = 0
            let y: CGFloat = self.imageSize.height
            let width: CGFloat = contentRect.size.width
            let height: CGFloat = contentRect.size.height - self.imageSize.height
            return CGRect(x: x, y: y, width: width, height: height)
            
        case .imageBottom:
            return contentRect
        }
    }
}
