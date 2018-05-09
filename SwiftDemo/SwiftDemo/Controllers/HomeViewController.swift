//
//  HomeViewController.swift
//  SwiftDemo
//
//  Created by 武月洋 on 2018/5/4.
//  Copyright © 2018年 武月洋. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let wyButton = WYButton(type: .imageTop, imageSize: CGSize(width: 25, height: 25))
        wyButton.setImage(UIImage(named: "tab_bar_item1_select"), for: .normal)
        wyButton.setTitle("标题", for: .normal)
        wyButton.setTitleColor(UIColor.black, for: .normal)
        wyButton.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        wyButton.titleLabel?.textAlignment = .center
//        wyButton.frame = CGRect(x: 100, y: 200, width: 80, height: 30)
//        wyButton .setBackgroundColor(color: UIColor.orange, state: .normal)
        self.view.addSubview(wyButton)
        
        wyButton.snp.makeConstraints { (make) in
            make.left.equalTo(50)
            make.top.equalTo(50)
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        let a = "@313"
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
