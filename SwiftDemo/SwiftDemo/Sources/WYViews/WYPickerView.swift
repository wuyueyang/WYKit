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
        case dateAndTime
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
    
    public var pickerViewMode: PickerViewMode = .custom {
        willSet {
            switch newValue {
            case .systemTime:
                datePickerView?.datePickerMode = .time
            case .systemDate:
                datePickerView?.datePickerMode = .date
            case .systemDateAndTime:
                datePickerView?.datePickerMode = .dateAndTime
            default:
                datePickerView?.datePickerMode = .time
            }
        }
    }
    
    fileprivate let ButtonBarHeight: CGFloat = 35.0
    
    fileprivate let PickerViewHeight: CGFloat = 180.0
    
    fileprivate var selectIndexPath: IndexPath?
    
    fileprivate var titles: Array<String>
    
    fileprivate var titles2D: Array<Array<String>>
    
    public convenience init(titles: Array<String>?,
                            frame: CGRect) {
        self.init(frame: frame)
        if self.pickerViewMode == .custom {
            if let array = titles {
                self.titles = array
            }
        }
    }
    
    public convenience init(titles2D: Array<Array<String>>?,
                            frame: CGRect) {
        
        self.init(frame: frame)
        
        if self.pickerViewMode == .custom {
            if let array = titles2D {
                self.titles2D = array
            }
        }
    }
    
    fileprivate convenience init(titles: Array<String>?, titles2D: Array<Array<String>>?, frame: CGRect) {
        
        self.init(frame: frame)
        
        if self.pickerViewMode == .custom {
            if let array = titles {
                self.titles = array
            }
            if let array = titles2D {
                self.titles2D = array
            }
        }
    }
    
    override init(frame: CGRect) {
        
        self.bgButton = UIButton(type: .custom)
        self.buttonsView = UIView(frame: .zero)
        self.doneButton = UIButton(type: .custom)
        self.cancelButton = UIButton(type: .custom)
        self.titles = []
        self.titles2D = []
        
        super.init(frame: frame)
        
        self.settingViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func settingViews() {
        
        bgButton.backgroundColor = UIColor(white: 0, alpha: 0.3)
        self.addSubview(bgButton)
        bgButton.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        buttonsView.backgroundColor = UIColor.white
        self.addSubview(buttonsView)
        buttonsView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.bottom.equalTo(self).offset(-PickerViewHeight)
            make.height.equalTo(ButtonBarHeight)
        }
        
        doneButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        doneButton.setTitle("确认", for: .normal)
        doneButton.setTitleColor(UIColor.black, for: .normal)
        buttonsView.addSubview(doneButton)
        doneButton.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(buttonsView)
            make.right.equalTo(buttonsView.snp.right).offset(-17)
            make.width.equalTo(50)
        }
        
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        cancelButton.setTitle("取消", for: .normal)
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
        case .dateAndTime:
            self.addDatePickerView()
        case .systemTime:
            self.addDatePickerView()
        case .systemDate:
            self.addDatePickerView()
        case .systemDateAndTime:
            self.addCustomPickerView()
        }
    }
    
    fileprivate func addCustomPickerView() {
        if datePickerView != nil {
            datePickerView!.removeFromSuperview()
        }
        normalPickerView = UIPickerView(frame: .zero)
        normalPickerView!.delegate = self
        normalPickerView!.dataSource = self
        self.addSubview(normalPickerView!)
        normalPickerView!.snp.makeConstraints({ (make) in
            make.height.equalTo(PickerViewHeight)
            make.left.right.bottom.equalTo(self)
        })
    }
    
    fileprivate func addDatePickerView() {
        if normalPickerView != nil {
            normalPickerView!.removeFromSuperview()
        }
        datePickerView = UIDatePicker(frame: .zero)
        datePickerView!.addTarget(self, action: #selector(WYPickerView.datePickerAction(picker:)), for: .touchUpInside)
        self.addSubview(datePickerView!)
        datePickerView!.snp.makeConstraints({ (make) in
            make.height.equalTo(PickerViewHeight)
            make.left.right.bottom.equalTo(self)
        })
    }
    
    @objc fileprivate func datePickerAction(picker: UIDatePicker) {
        guard delegate != nil else {
            return
        }
        let date = datePickerView!.date
        delegate!.didSelectDate(date: date)
    }
    
    //MARK: - UIPickerViewDelegate, UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if !titles.isEmpty {
            return titles.count
        }
        if !titles2D.isEmpty {
            return titles2D.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if !titles2D.isEmpty {
            let array = titles2D[component]
            if !array.isEmpty {
                return array.count
            }
            return 0
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if !titles.isEmpty {
            return titles[row]
        }
        if !titles2D.isEmpty {
            return titles2D[component][row]
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        guard delegate != nil else {
            return
        }
        selectIndexPath = IndexPath(row: row, section: component)
        delegate!.didSelectRow(indexPath: selectIndexPath!)
    }
    
}
