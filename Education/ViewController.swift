//
//  ViewController.swift
//  Education
//
//  Created by cmbfae on 8/11/2016.
//  Copyright © 2016 Education. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let textLabel: UILabel = UILabel(frame:CGRect(origin:CGPoint(x : 100, y: 200), size:CGSize(width: 200, height:20)))
//        textLabel.text = "这是一款儿童教育应用"
//        self.view.addSubview(textLabel)
        
        let pageHorizontalView = PagedHorizontalView(frame:UIScreen.main.bounds)
        self.view.addSubview(pageHorizontalView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

