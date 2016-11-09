//
//  WelcomeViewController.swift
//  Education
//
//  Created by cmbfae on 8/11/2016.
//  Copyright © 2016 Education. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire

class PagedHorizontalView: UIView {

    var pageControl : UIPageControl!
    var scrollView : UIScrollView!
    var skipButton : UIButton!
    var timer : Timer!
    var collectionView : UICollectionView!
    var label : UILabel!
    
    
    let items : [(image: String, label: String)] = [
        ("1", "关注孩子成长"),
        ("2", "孩子成长教育"),
        ("3", "平台体验功能"),
        ]
    
    fileprivate var endDragging = false
    open dynamic var currentIndex: Int = 0 {
        didSet {
            updateAccessoryViews()
        }
    }
    
    func updateAccessoryViews() {
        pageControl?.numberOfPages = collectionView.numberOfItems(inSection: 0)
        pageControl?.currentPage = currentIndex
    }
    
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
//        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.scrollDirection = .horizontal
//        flowLayout.minimumInteritemSpacing = 0
//        flowLayout.minimumLineSpacing = 0
//        flowLayout.sectionInset = UIEdgeInsetsMake(0, 1, 0, 1)
//        
//        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
//        collectionView.isPagingEnabled = true
//        collectionView.showsVerticalScrollIndicator = false
//        collectionView.delegate = self
//        addSubview(collectionView)
//        
//
//        
//        let widths : CGFloat = frame.size.width * CGFloat(items.count)
//        let localSize : CGSize = CGSize(width:widths, height: frame.size.height)
//        scrollView = UIScrollView(frame:CGRect(origin:CGPoint(x:0.0, y:0.0), size:localSize))
//        scrollView.addSubview(collectionView)
//        addSubview(scrollView);
//        
//        pageControl = UIPageControl()
//        pageControl.addTarget(self, action: Selector(("valueChanged:")), for: .valueChanged)
//        pageControl.numberOfPages =  items.count
//        addSubview(pageControl)
        
        skipButton = UIButton(type:.custom)
        skipButton.layer.cornerRadius = 15.0
        skipButton.backgroundColor = UIColor(red:90 / 255.0, green:90 / 255.0, blue:90 / 255.0, alpha:1.0)
        skipButton.setTitle("剩余5S", for:.normal);
        skipButton.isEnabled = false
        skipButton.addTarget(self, action: #selector(PagedHorizontalView.skipButtonAction(btn:)), for:.touchUpInside)
        addSubview(skipButton);
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction(timer:)), userInfo: nil, repeats: true)
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func valueChanged(sender:UIPageControl) -> Void {
        moveToPage(page: sender.currentPage, animated: true)
    }
    
    func moveToPage(page: Int, animated: Bool) -> Void {
        if page < 0 || page >= collectionView.numberOfItems(inSection: 0) {
            return
        }
        
        currentIndex = page
        collectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0),
                                    at: .left, animated: animated)
    }
    
    func timerAction(timer:Timer) {
        var text = skipButton.titleLabel?.text
        text = text?.replacingOccurrences(of: "剩余", with: "")
        text = text?.replacingOccurrences(of: "S", with: "")
        var textTime: Int = Int(text!)!
        if textTime == 0 {
            skipButton.isEnabled = true
            text = "跳过"
            timer.invalidate()
        }
        else
        {
            textTime -= 1
            text = "剩余" + String(textTime) + "S"
        }
        
        skipButton.setTitle(text, for: .normal)
    }
    
    func skipButtonAction(btn: UIButton) {
        print("skipButtonAction")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        collectionView.snp.makeConstraints { (ConstraintMaker) in
//            ConstraintMaker.left.top.right.bottom.equalToSuperview()
//        }
//
//        scrollView.snp.makeConstraints { (ConstraintMaker) in
//            ConstraintMaker.left.right.top.bottom.equalToSuperview()
//        }
//        
//        pageControl.snp.makeConstraints { (ConstraintMaker) in
//            ConstraintMaker.bottom.equalToSuperview().offset(20)
//            ConstraintMaker.left.right.equalToSuperview()
//            ConstraintMaker.centerX.equalToSuperview()
//        }
        
        skipButton.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.equalToSuperview().offset(40)
            ConstraintMaker.right.equalToSuperview().offset(-80)
            ConstraintMaker.width.equalTo(90)
            ConstraintMaker.height.equalTo(30)
        }
        
//        collectionView.performBatchUpdates(nil, completion: nil)
//        moveToPage(page: currentIndex, animated: false)
    }
}

extension PagedHorizontalView : UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            endScrolling(scrollView)
        } else {
            endDragging = true
        }
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if endDragging {
            endDragging = false
            endScrolling(scrollView)
        }
    }
    
    fileprivate func endScrolling(_ scrollView: UIScrollView) {
        let width = scrollView.bounds.width
        let page = (scrollView.contentOffset.x + (0.5 * width)) / width
        currentIndex = Int(page)
    }
}

extension PagedHorizontalView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        let item = items[(indexPath as NSIndexPath).item]
        cell.imageView.image = UIImage(named: item.image)
        cell.label.text = item.label
        return cell
    }
}

extension UIImage {
    
    func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage!
        
        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        
        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
    
}
