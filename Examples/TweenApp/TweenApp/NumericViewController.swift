//
//  ViewController.swift
//  TweenApp
//
//  Created by RF on 07/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import UIKit
import Ubergang

class NumericViewController: UIViewController {
    
    @IBOutlet var numberLabel: UILabel!
    
    @IBOutlet var progressBar: CircularProgressBar!
    
    var tweenControls: TweenControlsView!
    
    var timelineContainer: UTimeline!
    var timeline: UTimeline!
    
    var labelTween: NumericTween<Int>?
    
    var direction = false
    override func viewDidLoad() {
        tweenControls = TweenControlsView.instanceFromNib()
        tweenControls.onPlay = { [unowned self] in
            self.timelineContainer.start()
        }
        tweenControls.onStop = { [unowned self] in
            self.timelineContainer.stop()
        }
        tweenControls.onPause = { [unowned self] in
            self.timelineContainer.pause()
        }
        tweenControls.onResume = { [unowned self] in
            self.timelineContainer.resume()
        }
        tweenControls.onDirection = { [unowned self] direction in
            self.timelineContainer.tweenDirection(direction)
        }
        tweenControls.onProgress = { [unowned self] value in
            self.timelineContainer.progressTotal = value
        }
        view.addSubview(tweenControls)
        
        
        timeline = UTimeline(id: "timeline")
        timeline.memoryReference(.Weak)
        timeline.options(.Repeat(9))
        timeline.updateTotal { [unowned self] (progressTotal) in
            self.tweenControls.progress(progressTotal)
        }
        timeline.complete {
            print("complete")
        }
        
        let tween = UTweenBuilder
            .to( CGFloat(-0.1),
                 current: { CGFloat(-360.0) },
                 update: { [unowned self] (value: CGFloat) in
                    print("value: \(value)")
                    self.progressBar.endAngle = value
                },
                 duration: 3,
                 id: "arcIncreaseTween")
        tween.options(.Yoyo).ease(Cubic.easeInOut)
        tween.start()
        
        timeline?.append(
            tween
            )
        
        timeline?.append( UTweenBuilder
            .to( CGFloat(0.0),
                current: { CGFloat(-360.0) },
                update: { [unowned self] (value: CGFloat) in
                    self.progressBar.startAngle = value
                },
                duration: 1.5,
                id: "arcDecreaseTween")
            .ease(Cubic.easeInOut))
        
        
        timelineContainer = UTimeline(id: "timelineContainer")
        timelineContainer.memoryReference(.Weak)
        timelineContainer.insert(timeline, at: 0)
        
        
        timelineContainer.insert( UTweenBuilder
            .to( 0,
                current: { 10 },
                update: { [unowned self] (value: Int) in
                    self.numberLabel.text = String(value)
                },
                duration: 10.0,
                id: "countTween")
            .ease(Linear.ease)
            .memoryReference(.Weak), at: 0.0)
    }
}

