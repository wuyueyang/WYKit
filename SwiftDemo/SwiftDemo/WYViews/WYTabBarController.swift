//
//  WYTabBarController.swift
//  SwiftDemo
//
//  Created by 武月洋 on 2018/5/7.
//  Copyright © 2018年 武月洋. All rights reserved.
//

import UIKit

let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height

class WYTabBarController: UITabBarController {
    // 当前选中的位置
    var selectedButton: WYButton?
    // tab bar 高度
    var tabBarHeight: CGFloat = 49.0
    // 标题数组
    var titles = [String]()
    // 默认图片数组
    var normalImages = [String]()
    // 选中图片数组
    var selectedImages = [String]()
    // 控制器数组
    var controllers = [UIViewController]()
    // 懒加载
    private lazy var tabBarView: UIView = {
        
        let x = CGFloat(0)
        let y = 49.0 - self.tabBarHeight
        let width = kScreenWidth
        let height = self.tabBarHeight
        
        let view = UIView(frame:CGRect(x: x, y: y, width: width, height: height))
        view.backgroundColor = UIColor.white
        
        return view
    }()
    // 标题普通时样式
    var titleNormalColor: UIColor = UIColor.gray
    
    var titleSelectedColor: UIColor = UIColor.darkGray
    
    // 初始化方法
    init(controllers: [UIViewController], titles: [String], normalImages: [String], selectedImages:[String], tabBarHeight: CGFloat?) {
        self.controllers = controllers
        self.titles = titles
        self.normalImages = normalImages
        self.selectedImages = selectedImages
        
        if let height = tabBarHeight {
            self.tabBarHeight = height
        }
        if tabBarHeight! < 49.0 {
            self.tabBarHeight = 49.0
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addControllers()
        self.tabBar.addSubview(tabBarView)
        self.addButtons()
    }
    // 添加控制器
    private func addControllers() {
        guard controllers.count > 0 else {
            
            fatalError("添加的子控制器为空.")
        }
        self.viewControllers = controllers;
    }
    
    private func addButtons() {
        
        let number = controllers.count
        
        for i in 0 ..< number {
            
            let x = CGFloat(kScreenWidth / CGFloat(number) * CGFloat(i))
            let y: CGFloat = 0
            let width = kScreenWidth / CGFloat(number)
            let height = tabBarHeight
            
            let button = WYButton(type: .imageTop, imageSize: CGSize(width: 21.33, height: 21.33))
            button.frame = CGRect(x: x, y: y, width: width, height: height)
            button.titleLabel?.textAlignment = .center
            button.setTitleColor(titleNormalColor, for: .normal)
            button.setTitleColor(titleSelectedColor, for: .selected)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
            button.setImage(UIImage(named: normalImages[i]), for: .normal)
            button.setImage(UIImage(named: selectedImages[i]), for: .selected)
            button.setTitle(titles[i], for: .normal)
            button.addTarget(self, action: #selector(buttonAction(button:)), for: .touchUpInside)
            
            tabBarView.addSubview(button)
            
            if i == 0 {
                button.isSelected = true
                self.selectedButton = button
            }
            
            //添加角标
//            let numLabel = UILabel(frame: CGRect(x: button.frame.size.width / 2.0 + 6, y: 3, width: 20.0, height: 20.0))
//            numLabel.layer.masksToBounds = true
//            numLabel.layer.cornerRadius = 10
//            numLabel.backgroundColor = UIColor.red
//            numLabel.textColor = UIColor.white
//            numLabel.textAlignment = .center
//            numLabel.font = UIFont.systemFont(ofSize: 13)
//            numLabel.tag = 1020+i
//            numLabel.isHidden = true
//            button.addSubview(numLabel)
        }
    }
    
    //MARK: - TabBar Action
    
    @objc private func buttonAction(button: WYButton) {
        let index: Int = button.tag - 1000
        self.selectedIndex = index
        selectedButton?.isSelected = false
        button.isSelected = true
        selectedButton = button
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
