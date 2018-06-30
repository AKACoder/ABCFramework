//
//  ABCCalcExtensionsForLayout.swift
//  ABCFramework
//
//  Created by AKACoder on 2018/6/30.
//  Copyright © 2018年 AKACoder. All rights reserved.
//

import Foundation
import UIKit

extension UIDevice {
    public func IsX() -> Bool {
        if UIScreen.main.bounds.height == 812 {
            return true
        }
        
        return false
    }
}


extension CGFloat {
    var LayoutVal: CGFloat {
        get {
            return self / ABCSizes.ScaleRatio
        }
    }
    
    var LayoutValForImg: CGFloat {
        get {
            return self * ABCSizes.GetScaleRatioInPixel()
        }
    }
}

extension Double {
    var LayoutVal: CGFloat {
        get {
            return CGFloat(self) / ABCSizes.ScaleRatio
        }
    }
    
    var LayoutValForImg: CGFloat {
        get {
            return CGFloat(self) * ABCSizes.GetScaleRatioInPixel()
        }
    }
}

extension Int {
    var LayoutVal: CGFloat {
        get {
            return CGFloat(self) / ABCSizes.ScaleRatio
        }
    }
    
    var LayoutValForImg: CGFloat {
        get {
            return CGFloat(self) * ABCSizes.GetScaleRatioInPixel()
        }
    }
}

extension Int32 {
    var LayoutVal: CGFloat {
        get {
            return CGFloat(self) / ABCSizes.ScaleRatio
        }
    }
    
    var LayoutValForImg: CGFloat {
        get {
            return CGFloat(self) * ABCSizes.GetScaleRatioInPixel()
        }
    }
}

extension Int64 {
    var LayoutVal: CGFloat {
        get {
            return CGFloat(self) / ABCSizes.ScaleRatio
        }
    }
    
    var LayoutValForImg: CGFloat {
        get {
            return CGFloat(self) * ABCSizes.GetScaleRatioInPixel()
        }
    }
}


