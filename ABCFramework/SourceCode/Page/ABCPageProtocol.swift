//
//  ABCPageProtocol.swift
//  ABCFramework
//
//  Created by AKACoder on 2018/6/30.
//  Copyright © 2018年 AKACoder. All rights reserved.
//

import Foundation
import UIKit

public protocol ABCPageProtocol {
    var PageData: Any? {get set}
    var StatusBarRect: CGRect {get}
    mutating func SetPageData(data: Any?)
    func GetPageData() -> Any?
    
    func Layout()
    func Release()
    
    func Refresh()
}


extension ABCPageProtocol {
    public var StatusBarRect: CGRect {
        get {
            return UIApplication.shared.statusBarFrame
        }
    }
    public mutating func SetPageData(data: Any?) {
        PageData = data
    }
    
    public func Refresh() {}
    
    public func GetPageData() -> Any? {
        return PageData
    }
}
