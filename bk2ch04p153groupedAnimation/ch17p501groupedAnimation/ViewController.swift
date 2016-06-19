import UIKit

extension CGRect {
    init(_ x:CGFloat, _ y:CGFloat, _ w:CGFloat, _ h:CGFloat) {
        self.init(x:x, y:y, width:w, height:h)
    }
}
extension CGSize {
    init(_ width:CGFloat, _ height:CGFloat) {
        self.init(width:width, height:height)
    }
}
extension CGPoint {
    init(_ x:CGFloat, _ y:CGFloat) {
        self.init(x:x, y:y)
    }
}


class ViewController : UIViewController {
    var v : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.v = UIView(frame:CGRect(254,28,56,38))
        self.view.addSubview(self.v)
        self.v.layer.contents = UIImage(named:"boat.gif")!.cgImage
        self.v.layer.contentsGravity = kCAGravityResizeAspectFill
    }
    
    @IBAction func doButton (_ sender: AnyObject?) {
        self.animate()
    }
    
    func animate() {
        let h : CGFloat = 200
        let v : CGFloat = 75
        let path = CGMutablePath()
        var leftright : CGFloat = 1
        var next : CGPoint = self.v.layer.position
        var pos : CGPoint
        path.moveTo(nil, x: next.x, y: next.y)
        for _ in 0 ..< 4 {
            pos = next
            leftright *= -1
            next = CGPoint(pos.x+h*leftright, pos.y+v)
            path.addCurve(nil,
                cp1x: pos.x, cp1y: pos.y+30,
                cp2x: next.x, cp2y: next.y-30,
                endingAtX: next.x, y: next.y)
        }
        let anim1 = CAKeyframeAnimation(keyPath:"position")
        anim1.path = path
        anim1.calculationMode = kCAAnimationPaced
        
        let revs = [0.0, .pi, 0.0, .pi]
        let anim2 = CAKeyframeAnimation(keyPath:"transform")
        anim2.values = revs
        anim2.valueFunction = CAValueFunction(name:kCAValueFunctionRotateY)
        anim2.calculationMode = kCAAnimationDiscrete

        let pitches = [0.0, .pi/60.0, 0.0, -.pi/60.0, 0.0]
        let anim3 = CAKeyframeAnimation(keyPath:"transform")
        anim3.values = pitches
        anim3.repeatCount = Float.infinity
        anim3.duration = 0.5
        anim3.isAdditive = true
        anim3.valueFunction = CAValueFunction(name:kCAValueFunctionRotateZ)

        let group = CAAnimationGroup()
        group.animations = [anim1, anim2, anim3]
        group.duration = 8
        self.v.layer.add(group, forKey:nil)
        CATransaction.setDisableActions(true)
        self.v.layer.position = next

    }
}
