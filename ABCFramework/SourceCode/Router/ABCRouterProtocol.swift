//
//  ABCRouterProtocol.swift
//  ABCFramework
//
//  Created by AKACoder on 2018/06/30.
//  Copyright © 2018年 AKACoder. All rights reserved.
//

import Foundation
import UIKit

public enum ABCRouteResult {
    case Success
    case NoSuchPageType
    case NotEngine
}

public enum ABCPageDisplayStyle {
    case PushWithoutAnimate
    case PushWithAnimate
    
    case PresentWithDefaultAnimate
    case PresentWithoutAnimate(UIColor?)
    case PresentWithAnimate(UIModalTransitionStyle, UIColor?)
}

protocol ABCRouterEngine {
    var PageTypeMap: [String: ABCPageControllerProtocol.Type] {get set}
    var ReusablePageMap: [String: ABCPageControllerProtocol] {get set}
    var ReusablePageMapStack: [[String: ABCPageControllerProtocol]] {get set}
    
    func Display(page: ABCPageControllerProtocol, displayBy style: ABCPageDisplayStyle)
    func GetStacksIdxForReusablePage(page: ABCPageController) -> (exist: Bool, stackIdx: Int)
}

extension ABCRouterEngine {
    func GetReusePage(named name: String) -> ABCPageControllerProtocol? {
        var ret:ABCPageControllerProtocol? = nil
        for map in ReusablePageMapStack {
            for (pageName, page) in map {
                if (pageName == name) {
                    ret = page
                    break
                }
            }
            
            if (nil != ret) {
                break
            }
        }
        
        return ret
    }
}

public protocol ABCRouterProtocol {
    @discardableResult
    mutating func To(page pageName: String, withData param: Any?, displayBy style: ABCPageDisplayStyle) -> ABCRouteResult
}

extension ABCRouterProtocol {
    func GetPage(named name: String) -> ABCPageControllerProtocol? {
        guard var engine = self as? ABCRouterEngine else {
            return nil
        }
        
        if let prev = engine.ReusablePageMap[name] {
            return prev
        }
        
        guard let targetType = engine.PageTypeMap[name] else {
            return nil
        }
        
        return targetType.init()
    }
    
    @discardableResult
    public mutating func To(page pageName: String, withData param: Any?,
                                 displayBy style: ABCPageDisplayStyle = .PushWithAnimate) -> ABCRouteResult {
        guard var engine = self as? ABCRouterEngine else {
            return .NotEngine
        }
        
        guard let targetType = engine.PageTypeMap[pageName] else {
            return .NoSuchPageType
        }
        
        if var prev = engine.GetReusePage(named: pageName) {
            prev.SetData(data: param)
            (self as? ABCRouterEngine)?.Display(page: prev, displayBy: style)
            return .Success
        }

        var target = targetType.init()
        target.SetData(data: param)
        if target is ABCReusablePageControllerProtocol {
            engine.ReusablePageMap[pageName] = target
        }
        
        (self as? ABCRouterEngine)?.Display(page: target, displayBy: style)
        
        return .Success
    }
}
