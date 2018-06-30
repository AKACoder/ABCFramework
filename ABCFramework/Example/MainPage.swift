//
//  MainPage.swift
//  ABCFramework
//
//  Created by AKACoder on 2018/6/30.
//  Copyright © 2018年 AKACoder. All rights reserved.
//

import Foundation
import UIKit
import Neon

class ExampleMainPageController: ABCPageController {
    var Page: ExampleMainPage!
    
    override func DidLoad() {
        self.Page = ExampleMainPage(beloneTo: self, drawIn: self.view, layout: .BodyOnly)
    }
    
    deinit {
        Page?.Release()
    }
}

class ExampleMainPage: ABCPage {}

extension ExampleMainPage: ABCPageLayout {
    func PageLayout() {
        print("page layout")
    }
    
    func BodyLayout() {
        print("body layout")
        let label = UILabel()
        
        label.text = "Hello ABCFramework"
        label.sizeToFit()
        
        Body.addSubview(label)
        label.anchorInCenter(width: label.width, height: label.height)
    }
}
