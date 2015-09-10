//
//  ViewController.swift
//  ARShareCustomViewDemo
//
//  Created by 刘淋全 on 15/9/10.
//  Copyright (c) 2015年 刘淋全. All rights reserved.
//

import UIKit

class ViewController: UIViewController,ARShareCustomViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var btn:UIButton=UIButton(frame: CGRectMake(100, 120, 100, 100))
        btn.backgroundColor=UIColor.redColor()
        btn.addTarget(self, action: "click:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn)
    }
    
    func click(myBtn:UIButton){
        
        var shareView:ARShareCustomView=ARShareCustomView(title: "分享到", cancleBtnTitle: "取消", shareImageArr: ["PAG1","PAG2","PAG3","PAG2","PAG2","PAG3","PAG2","PAG2","PAG3","PAG2","PAG2","PAG3","PAG2"], shareTitleArr: ["微信朋友圈","PAG2","PAG3","PAG2","PAG2","PAG3","PAG2","PAG2","PAG3","PAG2","PAG2","PAG3","PAG2"])
        shareView.delegate=self
        shareView.showInView()
        
    }
    
    func shareSelectedIndex(index: Int) {
        var alertControl:UIAlertController=UIAlertController(title: "恭喜", message: "\(index)分享成功", preferredStyle: UIAlertControllerStyle.Alert)
        var okBtn:UIAlertAction=UIAlertAction(title: "确认", style: UIAlertActionStyle.Default, handler: nil)
        var cancleBtn:UIAlertAction=UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        alertControl.addAction(okBtn)
        alertControl.addAction(cancleBtn)
        self.presentViewController(alertControl, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

