//
//  ABCPage.swift
//  ABCFramework
//
//  Created by AKACoder on 2018/6/30.
//  Copyright © 2018年 AKACoder. All rights reserved.
//

import Foundation
import Neon

public enum ABCPageLayoutType {
    case FullPage
    case NoFooter
    case NoHeader
    case BodyOnly
}

@objc public protocol ABCPageLayout {
    func PageLayout()
    @objc optional func FooterLayout()
    @objc optional func HeaderLayout()
    @objc optional func BodyLayout()
}

open class ABCPage: NSObject {
    public var PageData: Any? = nil
    
    var TimeIntervalList = [String:Timer]()
    var TimeoutList = [Timer]()
    
    let Header = UIView()
    let Footer = UIView()
    let Body = UIScrollView()
    let Background = UIView()
    
    weak var Parent: ABCPageController? = nil
    var ContentView: UIView = UIView()
    var LayoutType: ABCPageLayoutType
    var LastStatusBarRect: CGRect = CGRect.zero
    
    public init(beloneTo page: ABCPageController, drawIn view: UIView, layout type: ABCPageLayoutType, data: Any? = nil) {
        Parent = page
        LayoutType = type
        super.init()
        
        PageData = data
        LastStatusBarRect = StatusBarRect
        
        view.addSubview(ContentView)
        ContentView.fillSuperview()
        self.CommonInit()
        
        self.Layout()
    }
}

extension ABCPage: ABCPageProtocol {
    open func Layout() {}
    
    public func Release() {
        for (_, timer) in TimeIntervalList {
            timer.invalidate()
        }
        
        for timer in TimeoutList {
            timer.invalidate()
        }
    }
}

