//
//  ABCRouterRegister.swift
//  ABCFramework
//
//  Created by AKACoder on 2018/6/30.
//  Copyright © 2018年 AKACoder. All rights reserved.
//

import Foundation

extension ABCRouter {
    public func Register(page name: String, with type: ABCPageController.Type) -> String? {
        let prev = PageTypeMap[name]
        if(nil != prev) {
            return nil
        }
        
        type.PageName = name
        ABCRouter.Shared.PageTypeMap[name] = type
        return name
    }
}

