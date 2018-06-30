//
//  ABCRouter.swift
//  ABCFramework
//
//  Created by AKACoder on 2018/6/30.
//  Copyright © 2018年 AKACoder. All rights reserved.
//

import Foundation
import UIKit

open class ABCRouter: ABCRouterProtocol {
    public static var Shared: ABCRouter = ABCRouter()
    var PageTypeMap = [String: ABCPageControllerProtocol.Type]()
    var ReusablePageMap = [String: ABCPageControllerProtocol]()
    
    var ReusablePageMapStack = [[String: ABCPageControllerProtocol]] ()
    var RouterNavStack = [UINavigationController]()
    
    static var RouterNav = UINavigationController()
    static let GestureRecognizer = ABCPageRouterGestureRecognizer()
    
    public static func CanClose(router: ABCRouter?) -> Bool {
        if(0 == router?.RouterNavStack.count || nil == router) {
            let ctrlStack = ABCRouter.RouterNav.viewControllers
            if(ctrlStack.count < 2) {
                return false
            }
            
            let curCtrl = ctrlStack.last as? ABCPageController
            if(nil != curCtrl) {
                return curCtrl!.IsAllowCloseNow()
            }
        }
        
        return true
    }
}

class ABCPageRouterGestureRecognizer: NSObject, UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if(gestureRecognizer.isKind(of: UIPanGestureRecognizer.self)) {
            if(ABCRouter.CanClose(router: nil)) {
                return true
            }
            
            return false
        }
        return true
    }
}





