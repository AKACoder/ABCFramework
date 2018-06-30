//
//  ABCSizes.swift
//  ABCFramework
//
//  Created by AKACoder on 2018/6/30.
//  Copyright © 2018年 AKACoder. All rights reserved.
//

import Foundation
import UIKit

protocol ABCSizesParameter {
    var PageHeaderHeight: CGFloat { get }
    var PageFooterHeight: CGFloat { get }
    var DesignedWidth: CGFloat { get }
}

public class ABCSizes {
    //calculation flag, avoid duplicate calculations
    fileprivate static var RatioInPixelCalced = false
    
    //the page width that designed by designers, in pixels uint
    fileprivate static var DesignedWidth : CGFloat = 750.0
    
    //scale ratio
    static var ScaleRatio : CGFloat { get { return ABCSizes.DesignedWidth / ABCSizes.ScreenWidth } }
    static var ScaleRatioInPixel : CGFloat = 0.0
    
    //screen related dimensions
    static let MainScreen = UIScreen.main
    static let ScreenWidth : CGFloat = UIScreen.main.bounds.width
    static let ScreenHeight : CGFloat = UIScreen.main.bounds.height
    
    
    //common dimensions
    static var PageHeaderHeight: CGFloat = UIDevice.current.IsX() ? 168.LayoutVal : 128.LayoutVal
    static var PageFooterHeight: CGFloat = UIDevice.current.IsX() ? 128.LayoutVal : 98.LayoutVal
    static var PageBodyHeight: CGFloat { get { return ABCSizes.ScreenHeight - ABCSizes.PageHeaderHeight - ABCSizes.PageFooterHeight }}
    static var PageNoFooterBodyHeight: CGFloat { get { return ABCSizes.ScreenHeight - ABCSizes.PageHeaderHeight } }
    static var PageNoHeaderBodyHeight: CGFloat { get { return ABCSizes.ScreenHeight - ABCSizes.PageFooterHeight } }
    static let PageBodyOnlyHeight: CGFloat = ABCSizes.ScreenHeight
    static let OnePixel = 1 / ABCSizes.MainScreen.scale
    
    //set framwork based sizes
    static func SetFrameworkSizeParameter(param: ABCSizesParameter) {
        ABCSizes.RatioInPixelCalced = false
        
        ABCSizes.PageHeaderHeight = param.PageHeaderHeight
        ABCSizes.PageFooterHeight = param.PageFooterHeight
        ABCSizes.DesignedWidth = param.DesignedWidth
        
        ABCSizes.GetScaleRatioInPixel()
    }
    
    //calculate the scale ratio in pixel for layout
    @discardableResult
    static func GetScaleRatioInPixel() -> CGFloat {
        
        if(false == ABCSizes.RatioInPixelCalced){
            let mainScreenWidth = ABCSizes.ScreenWidth
            let mainScreenPixelWidth = mainScreenWidth * ABCSizes.MainScreen.scale
            ABCSizes.ScaleRatioInPixel = mainScreenPixelWidth / ABCSizes.DesignedWidth
            ABCSizes.RatioInPixelCalced = true
        }
        
        return ABCSizes.ScaleRatioInPixel
    }
}

