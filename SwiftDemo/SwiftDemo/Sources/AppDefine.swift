//
//  AppDefine.swift
//  SwiftDemo
//
//  Created by 武月洋 on 2018/5/8.
//  Copyright © 2018年 武月洋. All rights reserved.
//

import UIKit
import SnapKit
import DeviceKit
import Kingfisher

/// 是否是X系列手机 .iPhoneX, .iPhoneXs, .iPhoneXsMax, .iPhoneXr
var isIPhoneXSeries: Bool {
    get {
        let device = Device()
        if device.isOneOf([.iPhoneX, .iPhoneXs, .iPhoneXsMax, .iPhoneXr, Device.simulator(.iPhoneX), Device.simulator(.iPhoneXs), Device.simulator(.iPhoneXsMax), Device.simulator(.iPhoneXr)]) {
            return true
        }
        return false
    }
}
/// 屏幕宽度
let kScreenWidth = (UIScreen.main.bounds.size.width)
/// 屏幕高度
let kScreenHeight = (UIScreen.main.bounds.size.height)
/// NavagationBar高度
let kNavigationBarHeight: CGFloat = {
    if isIPhoneXSeries {
        return 88
    }
    return 64
}()
/// TabBar高度
let kTabBarHeight: CGFloat = {
    if isIPhoneXSeries {
        return 83
    }
    return 49
}()
/// 距离屏幕最下方的安全距离
let kSafeBottomSpacing: CGFloat = {
    if isIPhoneXSeries {
        return 74
    }
    return 40
}()
/// 主题蓝色调
let kMainColor: UIColor = {
    return UIColor("#48B6FE")
}()
/// 同一控制打印
func wyPrint(message: String) {
    #if DEBUG
    print("\(message)")
    #endif
}




