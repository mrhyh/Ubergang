//
//  TransformTween.swift
//  Ubergang
//
//  Created by Robin Frielingsdorf on 14/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import Foundation
import UIKit

public class TransformTween: UTween<CGAffineTransform> {
    
    public convenience init() {
        let id = "\(#file)_\(random() * 1000)_update"
        self.init(id: id)
    }
    
    public override init(id: String) {
        super.init(id: id)
    }
    
    override func compute(value: Double) -> CGAffineTransform {
        super.compute(value)
        
        let from = self.from()
        let to = self.to()
        
        var currentValue = CGAffineTransformIdentity
        currentValue.tx = from.tx + (to.tx - from.tx) * CGFloat(value)
        currentValue.ty = from.ty + (to.ty - from.ty) * CGFloat(value)
        
        currentValue.a = from.a + (to.a - from.a) * CGFloat(value)
        currentValue.b = from.b + (to.b - from.b) * CGFloat(value)
        currentValue.c = from.c + (to.c - from.c) * CGFloat(value)
        currentValue.d = from.d + (to.d - from.d) * CGFloat(value)
        
        return currentValue
    }
}
