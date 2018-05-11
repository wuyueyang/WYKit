//
//  WYPickerView.swift
//  SwiftDemo
//
//  Created by 武月洋 on 2018/5/10.
//  Copyright © 2018年 武月洋. All rights reserved.
//

import UIKit

public protocol WYPickerViewDelegate: class {
    
    func didSelectRow(indexPath: IndexPath)
    func didSelectDate(date: Date)
}

class WYPickerView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {

    weak var delegate: WYPickerViewDelegate?
    
    enum PickerViewMode: Int {
        case custom
        case systemTime
        case systemDate
        case systemDateAndTime
    }
    
    fileprivate var bgButton: UIButton
    // 普通的 PickerView
    fileprivate var normalPickerView: UIPickerView?
    // 系统的日期 PickerView
    fileprivate var datePickerView: UIDatePicker?
    // buttonsView
    public var buttonsView: UIView
    
    public var doneButton: UIButton
    
    public var cancelButton: UIButton
    
    fileprivate var pickerViewMode: PickerViewMode
    
    fileprivate let ButtonBarHeight: CGFloat = 35.0
    
    fileprivate let PickerViewHeight: CGFloat = 180.0
    
    fileprivate var selectIndexPath: IndexPath?
    
    fileprivate var titles: Array<String>
    
    fileprivate var titles2D: Array<Array<String>>
    
    init(mode: PickerViewMode, frame: CGRect) {
        
        self.pickerViewMode = mode
        self.bgButton = UIButton(type: .custom)
        self.buttonsView = UIView(frame: .zero)
        self.doneButton = UIButton(type: .custom)
        self.cancelButton = UIButton(type: .custom)
        self.titles = []
        self.titles2D = []
        
        super.init(frame: frame)
        
        self.settingViews()
    }
    
    public convenience init(titles: Array<String>?, frame: CGRect) {
        self.init(mode: .custom, frame: frame)
        
        if self.pickerViewMode == .custom {
            if let array = titles {
                self.titles = array
            }
        }
    }
    
    public convenience init(titles2D: Array<Array<String>>?, frame: CGRect) {
        
        self.init(mode: .custom, frame: frame)
        
        if self.pickerViewMode == .custom {
            if let array = titles2D {
                self.titles2D = array
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func settingViews() {
        
        bgButton.backgroundColor = UIColor(white: 0, alpha: 0)
        bgButton.addTarget(self, action: #selector(controlAction), for: .touchUpInside)
        self.addSubview(bgButton)
        bgButton.snp.makeConstraints { (make) in
            make.edges.equalTo(self).inset(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        
        buttonsView.backgroundColor = UIColor.white
        self.addSubview(buttonsView)
        buttonsView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(self.snp.bottom)
            make.height.equalTo(ButtonBarHeight)
        }
        
        doneButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        doneButton.setTitle("确认", for: .normal)
        doneButton.addTarget(self, action: #selector(WYPickerView.doneAction), for: .touchUpInside)
        doneButton.setTitleColor(UIColor.black, for: .normal)
        buttonsView.addSubview(doneButton)
        doneButton.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(buttonsView)
            make.right.equalTo(buttonsView.snp.right).offset(-17)
            make.width.equalTo(50)
        }
        
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        cancelButton.setTitle("取消", for: .normal)
        cancelButton.addTarget(self, action: #selector(controlAction), for: .touchUpInside)
        cancelButton.setTitleColor(UIColor.black, for: .normal)
        buttonsView.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(buttonsView)
            make.left.equalTo(buttonsView.snp.left).offset(17)
            make.width.equalTo(50)
        }
        switch pickerViewMode {
        case .custom:
            self.addCustomPickerView()
        case .systemTime, .systemDate, .systemDateAndTime:
            self.addDatePickerView(mode: pickerViewMode)
        }
    }
    
    fileprivate func addCustomPickerView() {
        normalPickerView = UIPickerView(frame: .zero)
        normalPickerView!.backgroundColor = UIColor.white
        normalPickerView!.delegate = self
        normalPickerView!.dataSource = self
        self.addSubview(normalPickerView!)
        normalPickerView!.snp.makeConstraints({ (make) in
            make.height.equalTo(PickerViewHeight)
            make.left.right.equalTo(self)
            make.top.equalTo(buttonsView.snp.bottom)
        })
    }
    
    fileprivate func addDatePickerView(mode: PickerViewMode) {
        datePickerView = UIDatePicker(frame: .zero)
        datePickerView!.backgroundColor = UIColor.white
        switch mode {
        case .systemTime:
            datePickerView!.datePickerMode = .time
        case .systemDate:
            datePickerView!.datePickerMode = .date
        case .systemDateAndTime:
            datePickerView!.datePickerMode = .dateAndTime
        case .custom:
            return
        }
        self.addSubview(datePickerView!)
        datePickerView!.snp.makeConstraints({ (make) in
            make.height.equalTo(PickerViewHeight)
            make.left.right.equalTo(self)
            make.top.equalTo(buttonsView.snp.bottom)
        })
    }
    
    public func show() {
        self.showAnimation()
    }
    
    public func hide() {
        self.hideAnimation()
    }
    
    @objc fileprivate func controlAction() {
        self.hide()
    }
    
    @objc fileprivate func doneAction() {
        
        if delegate != nil {
            switch pickerViewMode {
            case .custom:
                delegate!.didSelectRow(indexPath: selectIndexPath!)
            case .systemTime, .systemDate, .systemDateAndTime:
                let date = self.datePickerView!.date
                delegate!.didSelectDate(date: date)
            }
        }
        self.hide()
    }
    
    fileprivate func showAnimation() {
        
        buttonsView.snp.remakeConstraints { (make) in
            make.left.right.equalTo(self)
            make.bottom.equalTo(self).offset(-PickerViewHeight)
            make.height.equalTo(ButtonBarHeight)
        }
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
            self.bgButton.backgroundColor = UIColor(white: 0, alpha: 0.3)
        }
    }
    
    fileprivate func hideAnimation() {
        
        buttonsView.snp.remakeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(self.snp.bottom)
            make.height.equalTo(ButtonBarHeight)
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.layoutIfNeeded()
            self.bgButton.backgroundColor = UIColor(white: 1, alpha: 0)
        }) { (complet) in
            self.removeFromSuperview()
        }
    }
    
    //MARK: - UIPickerViewDelegate, UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        if titles2D.count > 0 {
            return titles2D.count
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if titles2D.count > 0 {
            let array = titles2D[component]
            if array.count > 0 {
                return array.count
            }
            return 0
        }
        if titles.count > 0 {
            return titles.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if titles.count > 0 {
            return titles[row]
        }
        if titles2D.count > 0 {
            return titles2D[component][row]
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectIndexPath = IndexPath(row: row, section: component)
    }
}
