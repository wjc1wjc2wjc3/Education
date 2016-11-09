//
//  CustomCollectionViewCell.swift
//  Education
//
//  Created by cmbfae on 8/11/2016.
//  Copyright © 2016 Education. All rights reserved.
//

import UIKit
import SnapKit

class CustomCollectionViewCell: UICollectionViewCell {
    var imageView : UIImageView!
    var label : UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.textColor = UIColor.black
        contentView.addSubview(label)
        
        imageView = UIImageView()
        contentView.addSubview(imageView);
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.centerX.equalToSuperview()
            ConstraintMaker.bottom.equalToSuperview().offset(40)
        }
        
        imageView.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.left.right.top.bottom.equalToSuperview()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
