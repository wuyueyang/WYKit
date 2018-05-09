//
//  WYTextView.swift
//  SwiftDemo
//
//  Created by 武月洋 on 2018/5/9.
//  Copyright © 2018年 武月洋. All rights reserved.
//

import UIKit

class WYTextView: UITextView, UITextViewDelegate {
    
    var trueColor: UIColor?
    
    var placeholder: String? {
        willSet {
            guard newValue != nil && newValue != "" else {
                return
            }
            self.text = newValue
            self.trueColor = self.textColor
            self.textColor = UIColor.gray
        }
    }
    
    
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        self.text = ""
        self.textColor = UIColor.darkText
        return true
    }
}
