//
//  ABCPageLayout.swift
//  ABCFramework
//
//  Created by AKACoder on 2018/6/30.
//  Copyright © 2018年 AKACoder. All rights reserved.
//

import Foundation
import Neon

extension ABCPage {
    func CommonInit() {
        PageBasicLayout()
        
        Layout()
        if let selfInstance = self as? ABCPageLayout {
            selfInstance.PageLayout()
            selfInstance.FooterLayout?()
            selfInstance.HeaderLayout?()
            selfInstance.BodyLayout?()
        }
    }
    
    open func PageBasicLayout() {
        ContentView.addSubview(Background)
        ContentView.addSubview(Body)
        ContentView.addSubview(Header)
        ContentView.addSubview(Footer)
        
        Background.fillSuperview()
        
        if #available(iOS 11.0, *) {
            Body.insetsLayoutMarginsFromSafeArea = false
        }
        
        Body.alwaysBounceVertical = false
        
        switch LayoutType {
        case .FullPage:
            Header.anchorAndFillEdge(Edge.top, xPad: 0, yPad: 0, otherSize: ABCSizes.PageHeaderHeight)
            Footer.anchorAndFillEdge(Edge.bottom, xPad: 0, yPad: 0, otherSize: ABCSizes.PageFooterHeight)
            Body.align(Align.underMatchingLeft, relativeTo: Header, padding: 0, width: ABCSizes.ScreenWidth, height: ABCSizes.PageBodyHeight)
            
        case .NoFooter:
            Header.anchorAndFillEdge(Edge.top, xPad: 0, yPad: 0, otherSize: ABCSizes.PageHeaderHeight)
            Footer.removeFromSuperview()
            Body.alignAndFill(align: Align.underCentered, relativeTo: Header, padding: 0)
            
        case .NoHeader:
            Header.removeFromSuperview()
            Footer.anchorAndFillEdge(Edge.bottom, xPad: 0, yPad: 0, otherSize: ABCSizes.PageFooterHeight)
            Body.anchorAndFillEdge(Edge.top, xPad: 0, yPad: 0, otherSize: ABCSizes.PageNoHeaderBodyHeight)
            
        case .BodyOnly:
            Header.removeFromSuperview()
            Footer.removeFromSuperview()
            Body.frame = Body.superview!.frame
        }
    }
}


