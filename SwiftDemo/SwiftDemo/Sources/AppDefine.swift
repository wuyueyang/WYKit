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

// 屏幕宽度
let kScreenWidth = (UIScreen.main.bounds.size.width)
// 屏幕高度
let kScreenHeight = (UIScreen.main.bounds.size.height)
// NavagationBar高度
let kNavigationBarHeight: CGFloat = {
    let device = Device()
    if device.isOneOf([.iPhoneX, Device.simulator(.iPhoneX)]) {
        return 88
    }
    return 64
}()

let kTabBarHeight: CGFloat = {
    let device = Device()
    if device.isOneOf([.iPhoneX, Device.simulator(.iPhoneX)]) {
        return 83
    }
    return 49
}()

// UserDefaults 新的方式
// UserDefaults.standard.set(2, forKey: "123")

extension UIDevice {
    var isIphoneX:Bool {
        get {
            let device = Device()
            if device.isOneOf([.iPhoneX, Device.simulator(.iPhoneX)]) {
                return true
            }
            return false
        }
    }
}





