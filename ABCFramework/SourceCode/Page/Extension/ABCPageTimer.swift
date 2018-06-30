//
//  ABCPageTimer.swift
//  ABCFramework
//
//  Created by AKACoder on 2018/6/30.
//  Copyright © 2018年 AKACoder. All rights reserved.
//

import Foundation
import UIKit

extension ABCPage {
    @objc private func TimeIntervalCallback(timer: Timer) {
        let userCallback = timer.userInfo as! () -> Void
        userCallback()
    }
    
    @objc private func TimeoutCallback(timer: Timer) {
        let userCallback = timer.userInfo as! () -> Void
        userCallback()
        timer.invalidate()
    }
    
    @discardableResult
    public func SetTimeInterval(interval: Double, name: String, callback: @escaping () -> Void) -> Bool {
        if(nil != TimeIntervalList[name]){
            return false
        }
        
        let timer = Timer.scheduledTimer(timeInterval: interval,
                                         target: self,
                                         selector: #selector(TimeIntervalCallback),
                                         userInfo: callback, repeats: true)
        RunLoop.current.add(timer, forMode: RunLoopMode.commonModes)
        TimeIntervalList[name] = timer
        
        return true
    }
    
    public func ClearTimeInterval(name: String) {
        TimeIntervalList[name]?.invalidate()
        TimeIntervalList.removeValue(forKey: name)
    }
    
    public func FireTimeInterval(name: String) {
        TimeIntervalList[name]?.fire()
    }
    
    public func SetTimeout(after: Double, callback: () -> Void) {
        let timer = Timer.scheduledTimer(timeInterval: after,
                                         target: self,
                                         selector: #selector(TimeoutCallback),
                                         userInfo: callback, repeats: false)
        RunLoop.current.add(timer, forMode: RunLoopMode.commonModes)
        
        TimeoutList.append(timer)
    }
}
