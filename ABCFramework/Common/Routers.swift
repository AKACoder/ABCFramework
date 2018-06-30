//
//  Routers.swift
//  ABCFramework
//
//  Created by AKACoder on 2018/6/30.
//  Copyright © 2018年 AKACoder. All rights reserved.
//

import Foundation

class ExamplePageSet {
    static let Main = ABCRouter.Shared.Register(page: "ExampleMainPage", with: ExampleMainPageController.self)
}
