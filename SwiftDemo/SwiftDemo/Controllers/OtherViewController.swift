//
//  OtherViewController.swift
//  SwiftDemo
//
//  Created by 武月洋 on 2018/5/4.
//  Copyright © 2018年 武月洋. All rights reserved.
//

import UIKit
import Alamofire


class OtherViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request("123", method: .post, parameters: ["334":"123"], encoding: URLEncoding.methodDependent, headers: ["334":"123"]).responseJSON { (response) in
            
        }
        // Do any additional setup after loading the view.
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
