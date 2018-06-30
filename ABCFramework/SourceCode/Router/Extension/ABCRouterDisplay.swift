//
//  ABCRouterDisplay.swift
//  ABCFramework
//
//  Created by AKACoder on 2018/6/30.
//  Copyright © 2018年 AKACoder. All rights reserved.
//

import Foundation
import UIKit

extension ABCRouter {
    func DismissPageStackAndPush(to page: ABCPageController, animated: Bool, targetStack stackIdx: Int) {
        let runAnimate = animated ? ((stackIdx + 1) == RouterNavStack.count) : false
        
        if(stackIdx == RouterNavStack.count) {
            if page != ABCRouter.RouterNav.viewControllers.last {
                ABCRouter.RouterNav.popToViewController(page, animated: animated)
            }
            return
        }
        
        ABCRouter.RouterNav.dismiss(animated: runAnimate) { [weak self] in
            ABCRouter.RouterNav.interactivePopGestureRecognizer?.delegate = nil
            self?.PopNavAndPageStack()
            self?.DismissPageStackAndPush(to: page, animated: animated, targetStack: stackIdx)
        }
    }
    
    func Push(to page: ABCPageController, animated: Bool) {
        let prevPage = GetStacksIdxForReusablePage(page: page)
        if(prevPage.exist) {
            DismissPageStackAndPush(to: page, animated: animated, targetStack: prevPage.stackIdx)
        } else {
            ABCRouter.RouterNav.pushViewController(page, animated: animated)
        }
    }
    
    func Present(nav: UINavigationController, to page: ABCPageController, animated: Bool, currentPageStack: [UIViewController]) {
        let prevPage = GetStacksIdxForReusablePage(page: page)
        if(prevPage.exist) {
            DismissPageStackAndPush(to: page, animated: animated, targetStack: prevPage.stackIdx)
        } else {
            ABCRouter.RouterNav.present(nav, animated: animated)
            PushNavAndPageStack(nav: nav)
        }
    }
    
    func GetStacksIdxForReusablePage(page: ABCPageController) -> (exist: Bool, stackIdx: Int) {
        if(!(page is ABCReusablePageControllerProtocol)) {
            return (false, Int.max)
        }
        
        let pageStack = ABCRouter.RouterNav.viewControllers
        if (pageStack.contains(page)) {
            return (true, RouterNavStack.count)
        }
        
        var isInStack = false
        var backwardToStackIdx: Int = 0
        for (idx, pageMap) in ReusablePageMapStack.enumerated() {
            for (_, prevPage) in pageMap {
                if (page == (prevPage as? ABCPageController)) {
                    isInStack = true
                    backwardToStackIdx = idx
                    break
                }
            }
            
            if(isInStack) {
                break
            }
        }
        
        return (isInStack, backwardToStackIdx)
    }
}

extension ABCRouter {
    public func ClosePage(depth: Int = 1, animated: Bool = true) {
        guard let current = CurrentPage() else {
            return
        }
        
        if(!ABCRouter.CanClose(router: self)) {
            return
        }
        
        if(current.IsShowingByPresent) {
            Dismiss(animated: animated)
        } else {
            PopBack(withDepth: depth, animated: animated)
        }
    }
    
    
    fileprivate func Dismiss(animated: Bool = true) {
        if(RouterNavStack.count <= 0) {
            return
        }
        
        ABCRouter.RouterNav.dismiss(animated: animated, completion: nil)
        ABCRouter.RouterNav.interactivePopGestureRecognizer?.delegate = nil
        PopNavAndPageStack()
    }
    
    fileprivate func PopBack(withDepth depth: Int = 1, animated: Bool = true) {
        let pageStack = ABCRouter.RouterNav.viewControllers
        let pagesCountInStack = pageStack.count
        if(pagesCountInStack <= depth) {
            return
        }
        
        let targetPage = pageStack[pagesCountInStack - depth - 1]
        
        ABCRouter.RouterNav.popToViewController(targetPage, animated: animated)
    }
}

extension ABCRouter: ABCRouterEngine {
    func Display(page: ABCPageControllerProtocol, displayBy style: ABCPageDisplayStyle = .PushWithAnimate) {
        guard let target = page as? ABCPageController else {
            return
        }
        
        let pageStack = ABCRouter.RouterNav.viewControllers
        let currentPage = pageStack.last as? ABCPageController
        
        if(currentPage == target) {
            return
        }
        
        switch style {
        case .PushWithAnimate:
            DisplayByPush(target, animated: true)
            break
            
        case .PushWithoutAnimate:
            DisplayByPush(target, animated: false)
            break
            
        case .PresentWithoutAnimate(let background):
            DisplayByPresent(target, background: background, animated: false)
            break
            
        case .PresentWithAnimate(let transition, let background):
            DisplayByPresent(target, transition: transition, background: background, animated: true)
            break
            
        case .PresentWithDefaultAnimate:
            DisplayByPresent(target, transition: .coverVertical, background: nil, animated: true)
            break;
            
        }
    }
    
    func DisplayByPush(_ page: ABCPageController, animated: Bool) {
        SetNavToRootController()
        Push(to: page, animated: animated)
    }
    
    func DisplayByPresent(_ page: ABCPageController,
                          transition: UIModalTransitionStyle = .coverVertical,
                          background: UIColor? = nil,
                          animated: Bool = true) {
        SetNavToRootController()
        
        page.IsShowingByPresent = true
        
        let newNav = UINavigationController(rootViewController: page)
        newNav.interactivePopGestureRecognizer?.delegate = ABCRouter.GestureRecognizer
        
        newNav.setNavigationBarHidden(true, animated: false)
        newNav.modalTransitionStyle = transition
        if(nil != background) {
            newNav.modalPresentationStyle = UIModalPresentationStyle.custom
            page.view.backgroundColor = background!
        }
        
        Present(nav: newNav, to: page, animated: animated, currentPageStack: ABCRouter.RouterNav.viewControllers)
    }
}

extension ABCRouter {
    func SetNavToRootController() {
        if(nil != UIApplication.shared.keyWindow?.rootViewController) {return}
        if(UIApplication.shared.keyWindow?.rootViewController != ABCRouter.RouterNav) {
            UIApplication.shared.keyWindow?.rootViewController = ABCRouter.RouterNav
            ABCRouter.RouterNav.setNavigationBarHidden(true, animated: false)
            ABCRouter.RouterNav.interactivePopGestureRecognizer?.delegate = ABCRouter.GestureRecognizer
        }
    }
    
    func CurrentPage() -> ABCPageController? {
        return ABCRouter.RouterNav.viewControllers.last as? ABCPageController
    }
    
    fileprivate func PushNavAndPageStack(nav: UINavigationController) {
        
        ReusablePageMapStack.append(ReusablePageMap)
        ReusablePageMap = [String: ABCPageControllerProtocol]()
        
        RouterNavStack.append(ABCRouter.RouterNav)
        ABCRouter.RouterNav = nav
    }
    
    fileprivate func PopNavAndPageStack() {
        if(0 == RouterNavStack.count) {
            return
        }
        ABCRouter.RouterNav = RouterNavStack.popLast()!
        ReusablePageMap = ReusablePageMapStack.popLast()!
    }
}

