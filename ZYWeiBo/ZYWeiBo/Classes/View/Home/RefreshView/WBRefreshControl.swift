//
//  WBRefreshControl.swift
//  ZYWeiBo
//
//  Created by ZhangYu on 2021/8/17.
//

import UIKit

class WBRefreshControl: UIRefreshControl {

    private let WBRefreshControlOffset:CGFloat = -60
    private lazy var refreshView = WBRefreshView.refreshView()
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print("frame.minY is:\(frame.minY)")
    
        
        print("refreshView.rotateFlag is:\(refreshView.rotateFlag)")
        if frame.minY > 0 {
           return
        }
        
        if isRefreshing {
            refreshView.startAnimation()
            print("is refreshing!")
            return
        }
//        print("is not refreshing!")
        
        if frame.minY < WBRefreshControlOffset && !refreshView.rotateFlag{
            print("反过来")
            refreshView.rotateFlag = true
        }
        else if frame.minY >= WBRefreshControlOffset && refreshView.rotateFlag{
            print("转过去")
            refreshView.rotateFlag = false
        }
    }
    
    override init() {
        super.init()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    override func endRefreshing() {
        super.endRefreshing()
        refreshView.stopAnimation()
    }
    
    override func beginRefreshing() {
        super.beginRefreshing()
        refreshView.startAnimation()
    }
    

    private func setupUI() {
        tintColor = UIColor.clear
        
        addSubview(refreshView)
        refreshView.snp.makeConstraints { make in
            make.center.equalTo(self.snp.center)
            make.size.equalTo(refreshView.bounds.size)
        }
        
        DispatchQueue.main.async {
            self.addObserver(self, forKeyPath: "frame", options: [], context: nil)
        }
    }
    
    deinit {
        self.removeObserver(self, forKeyPath: "frame")
    }

}

class WBRefreshView: UIView {
    
    @IBOutlet weak var loadingIconView: UIImageView!
    @IBOutlet weak var tipIconView: UIImageView!
    
    @IBOutlet weak var tipView: UIView!

    
    var rotateFlag = false {
        didSet{
            rotateTipIcon()
//            self.tipView.isHidden = false
        }
    }
    
    class func refreshView() -> WBRefreshView {
        let nib = UINib.init(nibName: "WBRefreshView", bundle: nil)
        return nib.instantiate(withOwner: nil, options: nil)[0] as! WBRefreshView
    }
    
    private func rotateTipIcon() {
        var angle = Double(Double.pi)
        let angleChanged = rotateFlag ? 0.0000001 : -0.0000001
        angle = angle + angleChanged

        UIView.animate(withDuration: 0.5) {
            self.tipIconView.transform = CGAffineTransform.identity.rotated(by: CGFloat(angle))
        }
    }
    
    func startAnimation() {
        tipView.isHidden = true
        let key = "transform.rotation"
        if loadingIconView.layer.animation(forKey: key) != nil {
            return
        }
        let anim = CABasicAnimation.init(keyPath: key)
        anim.toValue = 2 * Double.pi
        anim.repeatCount = MAXFLOAT
        anim.duration = 0.5
        anim.isRemovedOnCompletion = false
        loadingIconView.layer.add(anim, forKey: key)
    }
    
    func stopAnimation() {
        tipView.isHidden = false
        loadingIconView.layer.removeAllAnimations()
    }
}
