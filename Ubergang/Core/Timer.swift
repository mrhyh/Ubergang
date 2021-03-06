//
//  Timer.swift
//  Ubergang
//
//  Created by Robin Frielingsdorf on 07/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import Foundation

public class Timer {
    public static let instance = Timer()
    
    private let id = "\(#file)_update"
    
    public static var delta:NSTimeInterval = NSTimeInterval(0)
    public static var time:NSTimeInterval = NSTimeInterval(0)
    private var lastUpdateTime:NSTimeInterval = NSTimeInterval(0)
    
    private init() {}
    
    func start() {
        self.lastUpdateTime = NSDate().timeIntervalSince1970
        
        Engine.instance.register(update, forKey: id)
    }
    
    
    func stop() {
        Engine.instance.unregister(id)
    }
    
    
    func update() {
        tick(NSDate().timeIntervalSince1970)
    }
    
    
    func tick(currentTime: NSTimeInterval) {
        if lastUpdateTime == 0.0 {
            Timer.delta = 0
        } else {
            Timer.delta = currentTime - self.lastUpdateTime
        }
        
        self.lastUpdateTime = NSDate().timeIntervalSince1970
        
        Timer.time += Timer.delta
    }
}