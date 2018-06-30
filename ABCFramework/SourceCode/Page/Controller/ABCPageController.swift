//
//  ABCPageController.swift
//  ABCFramework
//
//  Created by AKACoder on 2018/06/30.
//  Copyright © 2018年 AKACoder. All rights reserved.
//

import Foundation
import UIKit

open class ABCPageController: UIViewController {
    public var IsShowingByPresent: Bool = false
    public var UserData: Any? = nil
    
    open func IsAllowCloseNow() -> Bool {
        return true
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            self.view.insetsLayoutMarginsFromSafeArea = false
        }
        DidLoad()
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let status: Bool = IsShowingByPresent ? navigationController!.isBeingPresented : isMovingToParentViewController
        
        if(status) {
            Shown()
        } else {
            ReShown()
        }
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        let status: Bool = IsShowingByPresent ? navigationController!.isBeingPresented : isMovingToParentViewController
        
        if(status) {
            WillShow()
        } else {
            WillReShow()
        }
        
        super.viewWillAppear(animated)
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        let status: Bool = IsShowingByPresent ? navigationController!.isBeingDismissed : isMovingFromParentViewController
        
        if(status) {
            Released()
        } else {
            Hidden()
        }
        
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        let status: Bool = IsShowingByPresent ? navigationController!.isBeingDismissed : isMovingFromParentViewController
        
        if(status) {
            WillRelease()
        } else {
            WillHide()
        }
        super.viewWillDisappear(animated)
    }
    
    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        Refresh()
    }
    
    override open func loadView() {
        super.loadView()
        view.backgroundColor = UIColor.white
    }
    
    deinit {
        Destroyed()
    }
    
    open func DidLoad() {}
    
    open func WillShow() {}
    open func WillReShow() {}
    
    open func WillHide(){}
    open func WillRelease() {}
    
    open func Shown() {}
    open func ReShown() {}
    
    open func Hidden() {}
    open func Released() {}
    
    open func Destroyed() {}
    open func Refresh() {}
}

extension ABCPageController: ABCPageControllerProtocol {
    public static var PageName: String = ""
}

