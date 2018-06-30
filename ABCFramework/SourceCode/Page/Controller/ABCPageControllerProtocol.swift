//
//  ABCPageControllerProtocol.swift
//  ABCFramework
//
//  Created by AKACoder on 2018/6/30.
//  Copyright © 2018年 AKACoder. All rights reserved.
//

import Foundation

public protocol ABCBasicPageControllerProtocol {
    var UserData: Any? {get set}
    mutating func SetData(data: Any?)
    func GetData() -> Any?
    
    init()
}

public protocol ABCPageControllerProtocol: ABCBasicPageControllerProtocol {
    static var PageName: String {get set}

    func DidLoad()
    
    func WillShow()
    func WillReShow()

    func WillHide()
    func WillRelease()
    
    func Shown()
    func ReShown()
    
    func Hidden()
    func Released()
    
    func Destroyed()
    func Refresh()
}

extension ABCPageControllerProtocol {
    mutating public func SetData(data: Any?) {
        UserData = data
    }
    public func GetData() -> Any? {
        return UserData
    }
}

public protocol ABCReusablePageControllerProtocol {}

