//
//  LoginFinishViewController.swift
//  Education
//
//  Created by cmbfae on 8/11/2016.
//  Copyright © 2016 Education. All rights reserved.
//

import UIKit
import SnapKit

class LoginFinishViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let frame : CGRect = self.view.frame
        
        let text : String = "尊敬的家长, 感谢您加入阳光成长平台。当您的孩子成功采集后，我们通过平台信息通知您。欢迎进入平台,体验平台功能。(点击进入APP)以后同一手机记住密码，不用重复登录，如果换账号登录，需进入软件，从我的账号设置中退出当前登录账号。"
        let textSize : CGSize = text.textSizeWithFont(font: UIFont.systemFont(ofSize: 17.0), constrainedToSize: CGSize(width : frame.size.width, height : frame.size.height))
        
        let rect: CGRect = CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: textSize)
        let textLabel : UILabel = UILabel(frame: rect)
        textLabel.numberOfLines = 0
        textLabel.textAlignment = NSTextAlignment.center
        textLabel.text = text
        self.view.addSubview(textLabel)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews();
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension String {
    
    func textSizeWithFont(font: UIFont, constrainedToSize size:CGSize) -> CGSize {
        
        var textSize:CGSize!
        
        if size.equalTo(CGSize.zero) {
            
            let attributes = NSDictionary(object: font, forKey: NSFontAttributeName as NSCopying)
            
            textSize = self.size(attributes: attributes as! [String : AnyObject] as [String : AnyObject])
            
        } else {
            
            let option = NSStringDrawingOptions.usesLineFragmentOrigin
            
            let attributes = NSDictionary(object: font, forKey: NSFontAttributeName as NSCopying)
            
            let stringRect = self.boundingRect(with: size, options: option, attributes: attributes as! [String : AnyObject] as [String : AnyObject], context: nil)
            
            textSize = stringRect.size
            
        }
        
        return textSize
        
    }
}
