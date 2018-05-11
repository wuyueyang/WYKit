//
//  Https.swift
//  SwiftDemo
//
//  Created by 武月洋 on 2018/5/11.
//  Copyright © 2018年 武月洋. All rights reserved.
//

import UIKit
import Moya

let pro = MoyaProvider<GitHub>()

public enum GitHub {
    case userProfile(String)
    case userRepositories
}

extension GitHub: TargetType {
    public var baseURL: URL {
        return URL(string: "http://httpbin.org")!
    }
    
    public var path: String {
        switch self {
        case .userProfile:
            return "123"
        case .userRepositories:
            return "12345"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .userProfile:
            return .post
        case .userRepositories:
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .userProfile:
            return .requestParameters(parameters: ["1232" : 11], encoding: URLEncoding.default)
        case .userRepositories:
            return .requestParameters(parameters: ["1232" : 11], encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
}
