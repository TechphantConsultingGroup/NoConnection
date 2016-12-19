//
//  ViewController.swift
//  NoConnection
//
//  Created by TPCG II on 16/12/16.
//  Copyright © 2016 TPCG II. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var cycle: UIView!
    var cycle2: UIView?
    
    @IBOutlet weak var circleView: UIView!
    
    @IBOutlet weak var satelliteView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        cycle2 = UIView.init(frame: cycle.frame)
//        //cycle2?.frame = cycle.frame
//        cycle2?.backgroundColor = UIColor.green
//        
//        self.view.addSubview(cycle2!)
       // self.animationViewFirst()

        
        
        cycle.layer.cornerRadius = cycle.frame.size.height/2;
        cycle.layer.masksToBounds = true;

        
        
        circleView.layer.cornerRadius = circleView.frame.size.height/2;
        circleView.layer.masksToBounds = true;
        
        
        satelliteView.layer.cornerRadius = satelliteView.frame.size.height/2;
        satelliteView.layer.masksToBounds = true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func animteButtonAction(_ sender: AnyObject) {
        
        //self.animationViewFirst()
        //self.aMultiStageAnimation()
       // self.animationAlongaPath()
        //self.rotationAnimation()
       // self.orbitAnimation()
        //self.animationReapeatAfterPause()
        let animationCycle = self.animationReapeatAfterPause(hour: 11, radius: 110)
        self.cycle.layer.add(animationCycle, forKey: "rotation")
        let animationSatellite = self.animationReapeatAfterPause(hour: 5, radius: 140)
        self.satelliteView.layer.add(animationSatellite, forKey: "rotation")
    }
    
   
    

    func animationViewFirst() -> Void {
        
        let animation = CABasicAnimation.init()
        animation.keyPath = "position.x"
        animation.fromValue = 16
        let x = 320 + cycle.frame.width + cycle.frame.origin.x
        animation.toValue = x//320 + cycle.frame.width + cycle.frame.origin.x
        animation.duration = 2
        
// for not removing animations  other way 
        
//        animation.fillMode =  kCAFillModeForwards
//        animation.isRemovedOnCompletion = false
        
        
        cycle.layer.add(animation, forKey: "basic")
        // another way
        // cycle.layer.position = CGPoint.init(x: x, y: cycle.frame.origin.y)
        
        animation.beginTime = CACurrentMediaTime() + 2.5
        cycle2?.layer.add(animation, forKey: "basic")
        
        
    }
    
    func aMultiStageAnimation() -> Void {// shake animation 
        
        let animation = CAKeyframeAnimation.init()
        animation.keyPath = "position.x"
        animation.values = [0
            ,10,-10,0]
     //   animation.keyTimes = [0,NSNumber(value: 1 / 6.0),NSNumber(value: 3 / 6.0),NSNumber(value: 5 / 6.0),0]
        animation.duration = 0.4
        animation.isAdditive = true
        
        cycle.layer.add(animation, forKey: "shake")
        
        
    }
    
    func animationAlongaPath() -> Void {
        
        let boundingRect = CGRect.init(x: -100, y: -100, width: 300, height: 300)
        let animation = CAKeyframeAnimation.init()
        animation.keyPath = "position"
        animation.path = CGPath(ellipseIn: boundingRect,transform: nil)
        animation.duration = 4
        animation.isAdditive = true
        animation.repeatCount = HUGE
        animation.calculationMode = kCAAnimationPaced;
        animation.rotationMode = kCAAnimationRotateAuto;
        
        cycle.layer.add(animation, forKey: "orbit")
        
        
    }
    
    func rotationAnimation() -> Void {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = Float(M_PI * 2.0)
        rotationAnimation.duration = 1
        rotationAnimation.repeatCount = Float.infinity
        
        cycle.layer.add(rotationAnimation, forKey: "rotate")
    }
    
    func orbitAnimation() -> Void {
        
        // Set up path movement
//        CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//        pathAnimation.calculationMode = kCAAnimationPaced;
//        pathAnimation.fillMode = kCAFillModeForwards;
//        pathAnimation.removedOnCompletion = NO;
//        pathAnimation.repeatCount = INFINITY;
//        //pathAnimation.rotationMode = @"auto";
//        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//        pathAnimation.duration = 5.0;
//        
//        // Create a circle path
//        CGMutablePathRef curvedPath = CGPathCreateMutable();
//        CGRect circleContainer = CGRectMake(0, 0, 400, 400); // create a circle from this square, it could be the frame of an UIView
//        CGPathAddEllipseInRect(curvedPath, NULL, circleContainer);
//        
//        pathAnimation.path = curvedPath;
//        CGPathRelease(curvedPath);
//        
//        [self.imageView.layer addAnimation:pathAnimation forKey:@"myCircleAnimation"];
        
        let pathAnimation = CAKeyframeAnimation.init()
        pathAnimation.keyPath = "position"
        pathAnimation.calculationMode = kCAAnimationPaced
        pathAnimation.fillMode = kCAFillModeForwards
        pathAnimation.isRemovedOnCompletion = false
        pathAnimation.repeatCount = Float.infinity
        pathAnimation.duration = 3
        pathAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        pathAnimation.beginTime = 1
        
        // circular path
        let curvedPath = CGMutablePath()
        let circlecointainer = CGRect.init(x: 55, y: 179, width: 210, height: 210)
        
       // curvedPath.addEllipse(in: circlecointainer, transform: nil)
        curvedPath.addEllipse(in: circlecointainer)
        pathAnimation.path = curvedPath
        
        self.cycle.layer.add(pathAnimation, forKey: "myCircleAnimation")
        
    
    }
    
    
    func animationReapeatAfterPause(hour : CGFloat ,radius : CGFloat) -> CAAnimationGroup {
        
        let animatinoGroup = CAAnimationGroup.init()
        animatinoGroup.repeatCount = Float.infinity
        animatinoGroup.duration = 5
        
        // copied from above
        let pathAnimation = CAKeyframeAnimation.init()
        pathAnimation.keyPath = "position"
        pathAnimation.calculationMode = kCAAnimationPaced
        pathAnimation.fillMode = kCAFillModeForwards
        pathAnimation.isRemovedOnCompletion = false
        pathAnimation.repeatCount = Float.infinity
        pathAnimation.duration = 4
        pathAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        pathAnimation.beginTime = 1
        
        // circular path
        let curvedPath = CGMutablePath()
      //  let circlecointainer = CGRect.init(x: 55, y: 179, width: 214, height: 214)
        
        // curvedPath.addEllipse(in: circlecointainer, transform: nil)
     //   curvedPath.addEllipse(in: circlecointainer)
    
     //   CGPathAddArc(curvedPath, NULL, 160, 270, 100, radiansForHour(11), radiansForHour(12 + 11), NO);
        curvedPath.addArc(center: CGPoint.init(x: circleView.frame.midX, y: circleView.frame.midY), radius: radius, startAngle: radianForHours(hour: hour), endAngle: radianForHours(hour: hour + 12), clockwise: false)
        
        
        pathAnimation.path = curvedPath
        
        animatinoGroup.animations = [pathAnimation]
        //self.cycle.layer.add(animatinoGroup, forKey: "myCircleGroupAnimation")
        

        return animatinoGroup
        
        
    }
    
//    CGFloat radiansForHour(CGFloat hour)
//    {
//    return 2 * M_PI * (hour - 3) / 12;
//    }
    
    func radianForHours(hour : CGFloat) -> CGFloat {
        
        return 2 * CGFloat(M_PI) * (hour - 3) / 12
        
    }
}

