//
//  WYTextView.swift
//  SwiftDemo
//
//  Created by 武月洋 on 2018/5/9.
//  Copyright © 2018年 武月洋. All rights reserved.
//

import UIKit

class WYTextView: UITextView, UITextViewDelegate {
    
    fileprivate let toolBar: UIToolbar
    
    var placeholderColor: UIColor = UIColor.gray {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    var placeholder: NSString? {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override var font: UIFont? {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override var text: String! {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override var attributedText: NSAttributedString! {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        
        self.toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 35))
        
        super.init(frame: frame, textContainer: textContainer)
        self.delegate = self
        
        self.toolBar.barStyle = .default
        
        var items = [UIBarButtonItem]()
        
        items.append(UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: self, action: nil))
        items.append(UIBarButtonItem(title: "完成", style: .plain, target: self, action: #selector(WYTextView.dismissAction)))
        self.toolBar.items = items
        self.inputAccessoryView = self.toolBar
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.setNeedsDisplay()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        guard !self.hasText else {
            return
        }
        guard self.placeholder != nil else {
            return
        }
        let attr: Dictionary<NSAttributedStringKey, Any> = [NSAttributedStringKey.font: self.font as Any, NSAttributedStringKey.foregroundColor: self.placeholderColor]
        self.placeholder?.draw(in: CGRect(x: 5, y: 8, width: rect.size.width - 10, height: rect.size.height - 16), withAttributes: attr)
    }
    
    @objc fileprivate func dismissAction() {
        self.resignFirstResponder()
    }
}
