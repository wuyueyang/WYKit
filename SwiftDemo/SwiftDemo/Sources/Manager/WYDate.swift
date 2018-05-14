//
//  WYDate.swift
//  SwiftDemo
//
//  Created by 武月洋 on 2018/5/14.
//  Copyright © 2018年 武月洋. All rights reserved.
//

import UIKit

let WYDateShare = WYDate()

let format1 = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
let format2 = "yyyy-MM-dd'T'HH:mm:ss'Z'"
let format3 = "yyyy-MM-dd HH:mm"
/// 时区储存key
fileprivate let kSelectTimezoneKey = "select_timezone_key"

class WYDate: NSObject {
    
    /// 获取所选时区的指定格式的日期字符串
    ///
    /// - Parameters:
    ///   - date: 日期
    ///   - format: 日期格式
    /// - Returns: 日期字符串
    func dateString(date: Date, format: String, timezone: TimeZone) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = timezone
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    /// 获取所选时区的指定格式的日期字符串
    ///
    /// - Parameters:
    ///   - string: 当前的日期字符串
    ///   - format: 日期格式
    /// - Returns: 日期字符串
    func dateString(string: String,format: String, timezone: TimeZone) -> String {
        let date = self.date(string: string)
        guard date != nil else {
            return ""
        }
        let formatter = DateFormatter()
        formatter.timeZone = timezone
        formatter.dateFormat = format
        return formatter.string(from: date!)
    }
    
    /// 获取指定格式的日期字符串
    ///
    /// - Parameters:
    ///   - date: 日期
    ///   - format: 日期格式
    /// - Returns: 日期字符串
    func GMTDateString(date: Date, format: String) -> String {
        let timezone = TimeZone(secondsFromGMT: 0)
        return self.dateString(date: date, format: format, timezone: timezone!)
    }
    
    /// 获取指定格式的日期字符串
    ///
    /// - Parameters:
    ///   - string: 当前的日期字符串
    ///   - format: 日期格式
    /// - Returns: 日期字符串
    func GMTDateString(string: String,format: String) -> String {
        let timezone = TimeZone(secondsFromGMT: 0)
        return self.dateString(string: string, format: format, timezone: timezone!)
    }
    
    /// 获取指定格式的日期字符串
    ///
    /// - Parameters:
    ///   - date: 日期
    ///   - format: 日期格式
    /// - Returns: 日期字符串
    func nowTimezoneDateString(date: Date, format: String) -> String {
        let timezone = self.selectTimezone()
        return self.dateString(date: date, format: format, timezone: timezone)
    }
    
    /// 获取指定格式的日期字符串
    ///
    /// - Parameters:
    ///   - string: 当前的日期字符串
    ///   - format: 日期格式
    /// - Returns: 日期字符串
    func nowTimezoneDateString(string: String,format: String) -> String {
        let timezone = self.selectTimezone()
        return self.dateString(string: string, format: format, timezone: timezone)
    }
    
    /// 获取日期
    ///
    /// - Parameter string: 日期字符串
    /// - Returns: 日期
    func date(string: String) -> Date? {
        let format = DateFormatter()
        format.timeZone = TimeZone(abbreviation: "GMT")
        format.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        var date = format.date(from: string)
        if date == nil {
            format.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
            date = format.date(from: string)
        }
        if date == nil {
            format.dateFormat = "yyyy-MM-dd HH:mm"
            date = format.date(from: string)
        }
        return date
    }
    
    /// 获取当前选择的时区
    ///
    /// - Returns: 当前选择的时区
    func selectTimezone() -> TimeZone {
        let timezoneStr = UserDefaults.standard.object(forKey: kSelectTimezoneKey) as? String
        guard timezoneStr != nil else {
            UserDefaults.standard.set("GMT+0800", forKey: kSelectTimezoneKey)
            let timezone = TimeZone(abbreviation: "GMT+0800")
            guard timezone != nil else {
                return TimeZone.current
            }
            return timezone!
        }
        let timezone = TimeZone(abbreviation: timezoneStr!)
        guard timezone != nil else {
            return TimeZone.current
        }
        return timezone!
    }
    
    func allTimezones() -> Array<String> {
        return [
            "UTC -12（国际换日线）",
            "UTC -11（中途岛标准时间）",
            "UTC -10（夏威夷-阿留申标准时间）",
            "UTC -9:30（马克萨斯群岛标准时间）",
            "UTC -9（阿拉斯加标准时间）",
            "UTC -8（太平洋标准时间）",
            "UTC -7（北美山区标准时间）",
            "UTC -6（北美中部标准时间）",
            "UTC -5（北美东部标准时间）",
            "UTC -4（大西洋标准时间）",
            "UTC -3:30（纽芬兰岛标准时间）",
            "UTC -3（南美标准时间）",
            "UTC -2（巴西时间）",
            "UTC -1（佛得角标准时间）",
            "UTC +0（格林威治标准时间/欧洲西部时区）",
            "UTC +1（佛得角标准时间 ）",
            "UTC +2（欧洲东部时区）",
            "UTC +3（莫斯科时区）",
            "UTC +3:30（伊朗标准时间）",
            "UTC +4（中东时区A）",
            "UTC +4:30（阿富汗标准时间）",
            "UTC +5（中东时区B）",
            "UTC +5:30（印度标准时间）",
            "UTC +5:45（尼泊尔标准时间）",
            "UTC +6（孟加拉标准时间）",
            "UTC +6:30（缅甸标准时间）",
            "UTC +7（中南半岛标准时间）",
            "UTC +8（中国标准时间/东亚标准时间）",
            "UTC +8:30（朝鲜标准时间）",
            "UTC +9（远东标准时间）",
            "UTC +9:30（澳大利亚中部标准时间）",
            "UTC +10（澳大利亚东部标准时间）",
            "UTC +10:30（澳大利亚远东标准时间）",
            "UTC +11（努阿图标准时间）",
            "UTC +11:30（诺福克岛标准时间）",
            "UTC +12（太平洋标准时间B）",
            "UTC +12:45（查塔姆群岛标准时间）",
            "UTC +13（太平洋标准时间C）",
            "UTC +14（太平洋标准时间D）",
        ]
    }
    
    func allTimezoneDic() -> Dictionary<String, String> {
        return [
            "UTC -12（国际换日线）" : "GMT-1200",
            "UTC -11（中途岛标准时间）" : "GMT-1100",
            "UTC -10（夏威夷-阿留申标准时间）" : "GMT-1000",
            "UTC -9:30（马克萨斯群岛标准时间）" : "GMT-0930",
            "UTC -9（阿拉斯加标准时间）" : "GMT-0900",
            "UTC -8（太平洋标准时间）" : "GMT-0800",
            "UTC -7（北美山区标准时间）" : "GMT-0700",
            "UTC -6（北美中部标准时间）" : "GMT-0600",
            "UTC -5（北美东部标准时间）" : "GMT-0500",
            "UTC -4（大西洋标准时间）" : "GMT-0400",
            "UTC -3:30（纽芬兰岛标准时间）" : "GMT-0330",
            "UTC -3（南美标准时间）" : "GMT-0300",
            "UTC -2（巴西时间）" : "GMT-0200",
            "UTC -1（佛得角标准时间）" : "GMT-0100",
            "UTC +0（格林威治标准时间/欧洲西部时区）" : "GMT",
            "UTC +1（佛得角标准时间 ）" : "GMT+0100",
            "UTC +2（欧洲东部时区）" : "GMT+0200",
            "UTC +3（莫斯科时区）" : "GMT+0300",
            "UTC +3:30（伊朗标准时间）" : "GMT+0330",
            "UTC +4（中东时区A）" : "GMT+0400",
            "UTC +4:30（阿富汗标准时间）" : "GMT+0430",
            "UTC +5（中东时区B）" : "GMT+0500",
            "UTC +5:30（印度标准时间）" : "GMT+0530",
            "UTC +5:45（尼泊尔标准时间）" : "GMT+0545",
            "UTC +6（孟加拉标准时间）" : "GMT+0600",
            "UTC +6:30（缅甸标准时间）" : "GMT+0630",
            "UTC +7（中南半岛标准时间）" : "GMT+0700",
            "UTC +8（中国标准时间/东亚标准时间）" : "GMT+0800",
            "UTC +8:30（朝鲜标准时间）" : "GMT+0830",
            "UTC +9（远东标准时间）" : "GMT+0900",
            "UTC +9:30（澳大利亚中部标准时间）" : "GMT+0930",
            "UTC +10（澳大利亚东部标准时间）" : "GMT+1000",
            "UTC +10:30（澳大利亚远东标准时间）" : "GMT+1030",
            "UTC +11（努阿图标准时间）" : "GMT+1100",
            "UTC +11:30（诺福克岛标准时间）" : "GMT+1130",
            "UTC +12（太平洋标准时间B）" : "GMT+1200",
            "UTC +12:45（查塔姆群岛标准时间）" : "GMT+1245",
            "UTC +13（太平洋标准时间C）" : "GMT+1300",
            "UTC +14（太平洋标准时间D）" : "GMT+1400",
        ]
    }
}


