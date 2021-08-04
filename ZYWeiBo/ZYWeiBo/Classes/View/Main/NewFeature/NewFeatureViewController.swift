//
//  NewFeatureViewController.swift
//  ZYWeiBo
//
//  Created by ZhangYu on 2021/7/29.
//

import UIKit
import SnapKit

private let reuseIdentifier = "Cell"

class NewFeatureViewController: UICollectionViewController {
    
    private let ZYNewFeatureViewCellId = "ZYNewFeatureViewCellId"
    private let ZYNewFeatureImageCount = 4

    
  
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = UIScreen.main.bounds.size
        layout.minimumInteritemSpacing = 0 //单元格间距
        layout.minimumLineSpacing = 0 //行间距
        layout.scrollDirection = .horizontal
        super.init(collectionViewLayout: layout)
        collectionView?.isPagingEnabled = false
        collectionView.bounces = false //去掉弹簧效果
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(NewFeatureCell.self, forCellWithReuseIdentifier: ZYNewFeatureViewCellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ZYNewFeatureImageCount
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZYNewFeatureViewCellId, for: indexPath) as! NewFeatureCell
        cell.backgroundColor = indexPath.item%2 == 0 ? UIColor.red:UIColor.green
        return cell
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x/scrollView.bounds.width)
        if page != ZYNewFeatureImageCount - 1{
            return
        }
        let cell = collectionView?.cellForItem(at: NSIndexPath.init(item: page, section: 0) as IndexPath) as! NewFeatureCell
        cell.showButtonAnim()
    }

    
}

private class NewFeatureCell: UICollectionViewCell {
    
    private lazy var iconView: UIImageView = UIImageView()
    private var imageIndex: Int = 0{
        didSet{
            iconView.image = UIImage.init(named: "new_feature_\(imageIndex + 1)")
        }
    }
    private lazy var startButton: UIButton = UIButton.init(title: "开始体验", color: UIColor.white, backImageName: "new_feature_finish_button")
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("\(#function)not implemented")
    }
    
    private func setupUI() {
        //添加控件
        addSubview(iconView)
        //指定位置
        iconView.frame = bounds
        
        addSubview(startButton)
        startButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.snp.bottom).multipliedBy(0.7)
        }
        startButton.addTarget(self, action: #selector(clickStartButton), for: .touchUpInside)
        
        startButton.isHidden = true
    }
    
    func showButtonAnim(){
        startButton.isHidden = false
        startButton.transform = CGAffineTransform.init(scaleX: 0, y: 0)
        startButton.isUserInteractionEnabled = false;
        UIView.animate(withDuration: 1.6, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 10, options: []) {
            self.startButton.transform = CGAffineTransform.identity
        } completion: { (_) in
            self.startButton.isUserInteractionEnabled = true
        }

    }
    
    @objc private func clickStartButton(){
        print("开始体验")
        NotificationCenter.default.post(name: NSNotification.Name(ZYSwitchRootViewControllerNotification), object: nil)
    }
}
