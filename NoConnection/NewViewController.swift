//
//  NewViewController.swift
//  NoConnection
//
//  Created by TPCG II on 17/12/16.
//  Copyright © 2016 TPCG II. All rights reserved.
//

import UIKit

class NewViewController: UIViewController {

    
    @IBOutlet weak var globe: UIImageView!
    @IBOutlet weak var cycle: UIImageView!
    @IBOutlet weak var satellite: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
      //  satellite.transform.inverted()
        satellite.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI));
//         globe.layer.cornerRadius = globe.frame.size.height/2;
//         globe.layer.masksToBounds = true;
//         globe.layer.borderWidth = 2.0
//         globe.layer.borderColor = UIColor.green.cgColor
       // satellite.layer.setAffineTransform(CGAffineTransform.init(scaleX: 1, y: -1))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
 
    @IBAction func startAnimatinoHere(_ sender: AnyObject) {
        globe.layoutIfNeeded()
        print(globe.frame)
        let cycleAnimation = self.animationReapeatAfterPause(hour: 12, radius: self.globe.frame.width/2 + 7)
        self.cycle.layer.add(cycleAnimation, forKey: "cycleRotation")
        
        let satelliteAnimation = self.animationReapeatAfterPause(hour: 6, radius: self.globe.frame.width/2 + 25)
       //  CATransaction.begin()
        
//         CATransaction.setCompletionBlock({
//            print("completion block")
//            self.satellite.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI));
//         })
        self.satellite.layer.add(satelliteAnimation, forKey: "satelliteRotation")
       // CATransaction.commit()
        
        
    }
    

    
}

extension NewViewController : CAAnimationDelegate {

    func animationReapeatAfterPause(hour : CGFloat ,radius : CGFloat) -> CAAnimationGroup {
        
        let animatinoGroup = CAAnimationGroup.init()
        animatinoGroup.repeatCount = Float.infinity
        animatinoGroup.duration = 4.0
        
        // copied from above
        let pathAnimation = CAKeyframeAnimation.init()
        pathAnimation.keyPath = "position"
        pathAnimation.calculationMode = kCAAnimationPaced
        pathAnimation.fillMode = kCAFillModeForwards
        pathAnimation.isRemovedOnCompletion = false
        pathAnimation.repeatCount = Float.infinity
        pathAnimation.duration = 4
        pathAnimation.timingFunction = CAMediaTimingFunction.init(controlPoints: 0.0, 0.25, 0.5, 1)//CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
       // pathAnimation.beginTime = 0.5
        
        //
        pathAnimation.rotationMode = kCAAnimationRotateAuto
        // circular path
        let curvedPath = CGMutablePath()
        //  let circlecointainer = CGRect.init(x: 55, y: 179, width: 214, height: 214)
        
        // curvedPath.addEllipse(in: circlecointainer, transform: nil)
        //   curvedPath.addEllipse(in: circlecointainer)
        
        //   CGPathAddArc(curvedPath, NULL, 160, 270, 100, radiansForHour(11), radiansForHour(12 + 11), NO);
        curvedPath.addArc(center: CGPoint.init(x: globe.frame.midX, y: globe.frame.midY), radius: radius, startAngle: radianForHours(hour: hour), endAngle: radianForHours(hour: hour + 12), clockwise: false)
        
        
        pathAnimation.path = curvedPath
       // pathAnimation.delegate = self
        animatinoGroup.animations = [pathAnimation]
        animatinoGroup.delegate = self
        //self.cycle.layer.add(animatinoGroup, forKey: "myCircleGroupAnimation")
        
        
        return animatinoGroup
        
        
    }

    
    func radianForHours(hour : CGFloat) -> CGFloat {
        
        return 2 * CGFloat(M_PI) * (hour - 3) / 12
        
    }
    
    func animationDidStart(_ anim: CAAnimation) {
     
        self.satellite.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI * 2));
        
    }
    

    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
    }
}
