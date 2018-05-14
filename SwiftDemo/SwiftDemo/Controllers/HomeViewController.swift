//
//  HomeViewController.swift
//  SwiftDemo
//
//  Created by 武月洋 on 2018/5/4.
//  Copyright © 2018年 武月洋. All rights reserved.
//

import UIKit
import Moya
import SwiftyJSON

class HomeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.groupTableViewBackground
        
        let textView = WYTextView(frame: .zero)
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.placeholder = "测试一下这个文字"
        self.view.addSubview(textView)
        
        textView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(80)
        }
        
        let button1 = UIButton(type: .custom)
        button1.setTitle("picker", for: .normal)
        button1.setTitleColor(UIColor.white, for: .normal)
        button1.backgroundColor = UIColor.red
        button1.addTarget(self, action: #selector(HomeViewController.showPickerView), for: .touchUpInside)
        self.view.addSubview(button1)
        button1.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(50)
            make.top.equalTo(textView.snp.bottom).offset(20)
        }
        
        
        let circle = CircleProgressView(frame: .zero)
        circle.progressWidth = 15.0
        circle.progressColor = UIColor.orange
        circle.progressBottomColor = UIColor.lightGray
        circle.progress = CGFloat(arc4random()%101) / 100.0
        self.view.addSubview(circle)
        circle.snp.makeConstraints { (make) in
            make.width.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(button1.snp.bottom).offset(20)
        }
        
        let line = LineProgressView(frame: .zero)
        line.progressWidth = 15.0
        line.progressColor = UIColor.orange
        line.progressBottomColor = UIColor.lightGray
        line.progress = CGFloat(arc4random()%101) / 100.0
        self.view.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.width.equalTo(150)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(circle.snp.bottom).offset(20)
        }
    }
    
    @objc fileprivate func showPickerView() {
        
        let http = MoyaProvider<MyAPP>()
        http.request(.login(username: "qqq", password: "qqq")) { result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data // Data, your JSON response is probably in here!
                let json = JSON(data)
                print(json)
                let statusCode = moyaResponse.statusCode // Int - 200, 401, 500, etc
                print(statusCode)
            case let .failure(error):
                print(error)
            }
        }
        
        http.request(.uploadImage(image: Data()), callbackQueue: nil, progress: { progress in
            <#code#>
        }) { result in
            <#code#>
        }
        
        let picker = WYPickerView(titles2D: [["1", "2", "2", "2", "2"],["1", "2", "2", "2", "2"]], frame: .zero)
        self.view.addSubview(picker)
        picker.show()
        picker.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(0, 0, kTabBarHeight, 0))
        }
        
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
