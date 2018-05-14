//
//  Https.swift
//  SwiftDemo
//
//  Created by 武月洋 on 2018/5/11.
//  Copyright © 2018年 武月洋. All rights reserved.
//

import UIKit
import Moya

enum MyAPP {
    case login(username: String, password: String)
    case uploadImage(image: Data)
}

extension MyAPP: TargetType {
    // 服务器地址
    var baseURL: URL {
        return URL(string: "https://sheep.coolhei.com/api/v1")!
    }
    // 各个请求的具体路径
    var path: String {
        switch self {
        case .login(_, _):
            return "/login"
        case .uploadImage(_):
            return "/upload"
        }
    }
    // 请求方式
    var method: Moya.Method {
        switch self {
        case .login(_, _):
            return .post
        case .uploadImage(_):
            return .post
        }
    }
    // 具体的请求事件
    var task: Task {
        switch self {
            
        case .login(let username, let password):
            let token: NSString = "\(username)\(password)" as NSString
            let sha256Token: NSString = token.sha256Hash()! as NSString
            return .requestParameters(parameters: ["username" : username, "password" : sha256Token], encoding: JSONEncoding.default)
            
        case .uploadImage(let imageData):
            return .requestCompositeData(bodyData: imageData, urlParameters: ["image" : "1"])
            
        }
    }
    // 请求头
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    // 单元测试的模拟数据, 暂不使用
    var sampleData: Data {
        return Data()
    }
}

// 关于 encoding 的解释
//public typealias ParameterEncoding = Alamofire.ParameterEncoding 该选项是自动根据 get, post, put, delete等请求方式, 选择把 parameters 根据何种方式传给服务器的选项.
//public typealias JSONEncoding = Alamofire.JSONEncoding 把 parameters 以JSON的格式放到请求体中参与请求.
//public typealias URLEncoding = Alamofire.URLEncoding 把 parameters 放到URL中参与请求.
//public typealias PropertyListEncoding = Alamofire.PropertyListEncoding 把 parameters 以Plist的格式放到请求体中参与请求.
