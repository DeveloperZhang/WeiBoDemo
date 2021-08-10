//
//  StatusPictureView.swift
//  ZYWeiBo
//
//  Created by ZhangYu on 2021/8/6.
//

import UIKit

class StatusPictureView: UICollectionView {

    private let StatusPictureViewItemMargin: CGFloat = 8
    private let StatusPictureCellId = "StatusPictureCellId"
    
    
    var viewModel:StatusViewModel?{
        didSet{
            sizeToFit()
            reloadData()
        }
    }
    
    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(frame: CGRect.zero, collectionViewLayout: layout)
        backgroundColor = UIColor.init(white: 0.8, alpha: 1.0)
        layout.minimumLineSpacing = StatusPictureViewItemMargin
        layout.minimumInteritemSpacing = StatusPictureViewItemMargin
        
        dataSource = self
        register(StatusPictureCell.self, forCellWithReuseIdentifier: StatusPictureCellId)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return calcViewSize()
    }
    
}

extension StatusPictureView {
    private func calcViewSize() -> CGSize {
        let rowCount:CGFloat = 3
        let maxWidth = UIScreen.main.bounds.width - 2 * StatusCellMargin
        let itemWidth = (maxWidth - 2 * StatusPictureViewItemMargin)/3
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize.init(width: itemWidth, height: itemWidth)
        let count = viewModel?.thumbnailUrls?.count ?? 0
        if count == 0 {
            return CGSize.zero
        }else if count == 1{
            let size = CGSize(width: 150, height: 120)
            layout.itemSize = size
            return size
        }else if count == 4 {
            let w = 2 * itemWidth + StatusPictureViewItemMargin
            return CGSize.init(width: w, height: w)
        }
        let row = CGFloat((count - 1)/Int(rowCount) + 1)
        let h = row * itemWidth + (row - 1) * StatusPictureViewItemMargin + 1
        let w = rowCount * itemWidth + (rowCount - 1) * StatusPictureViewItemMargin + 1
        return CGSize.init(width: w, height: h)
    }
}

extension StatusPictureView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.thumbnailUrls?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StatusPictureCellId, for: indexPath) as! StatusPictureCell
        cell.imageURL = viewModel!.thumbnailUrls![indexPath.row]
        return cell
    }

}
