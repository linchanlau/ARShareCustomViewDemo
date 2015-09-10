//
//  ARShareCustomView.swift
//  swiftShop
//
//  Created by 刘淋全 on 15/9/6.
//  Copyright (c) 2015年 刘淋全. All rights reserved.
//

import UIKit

protocol ARShareCustomViewDelegate
{
    func shareSelectedIndex(index:Int)
}

class ARShareCustomView: UIControl,UIScrollViewDelegate {
    
    var delegate:ARShareCustomViewDelegate?
    private let cellsSp:CGFloat=25.0
    private let rowC:Int=4
    private let columnC:Int=2
    private var bgView:UIView?
    private var shareSV:UIScrollView?
    private var pageControl:UIPageControl?
    private var cellImageViewArray=[UIImageView]()
    private var cellTitleArray=[UILabel]()
    private var cellBtnArray=[UIButton]()
    
    convenience init(title:String,cancleBtnTitle:String,shareImageArr:NSArray,shareTitleArr:NSArray)
    {
        self.init(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height))
        self.backgroundColor=UIColor.clearColor()
        
        bgView=UIView()
        bgView?.backgroundColor=UIColor.whiteColor()
        self.addSubview(bgView!)
        
        var titleLabel:UILabel=UILabel()
        titleLabel.textColor=UIColor.blackColor()
        titleLabel.font=UIFont.systemFontOfSize(16)
        titleLabel.text=title
        titleLabel.tag=100
        titleLabel.textAlignment=NSTextAlignment.Center
        bgView?.addSubview(titleLabel)
        
        shareSV=UIScrollView()
        shareSV?.showsHorizontalScrollIndicator=false
        shareSV?.showsVerticalScrollIndicator=false
        shareSV?.pagingEnabled=true
        shareSV?.delegate=self
        bgView?.addSubview(shareSV!)
        
        for i in 0..<shareImageArr.count
        {
            var imageView:UIImageView=UIImageView()
            imageView.image=UIImage(named: shareImageArr[i] as! String)
            shareSV?.addSubview(imageView)
            cellImageViewArray.append(imageView)
            
            var label:UILabel=UILabel()
            label.textAlignment=NSTextAlignment.Center
            label.text=shareTitleArr[i] as? String
            label.textColor=UIColor.grayColor()
            label.font=UIFont.systemFontOfSize(11)
            shareSV?.addSubview(label)
            cellTitleArray.append(label)
            
            var btn:UIButton=UIButton()
            btn.addTarget(self, action: "btnClick:", forControlEvents: UIControlEvents.TouchUpInside)
            btn.tag=i
            shareSV?.addSubview(btn)
            cellBtnArray.append(btn)
            
        }
        
        pageControl=UIPageControl()
        pageControl?.currentPage=0
        pageControl?.pageIndicatorTintColor=UIColor.grayColor()
        pageControl?.currentPageIndicatorTintColor=UIColor.blueColor()
        pageControl?.userInteractionEnabled=false
        bgView?.addSubview(pageControl!)
        bgView?.bringSubviewToFront(pageControl!)
        
        var cancleBtn:UIButton=UIButton()
        cancleBtn.setTitle(cancleBtnTitle, forState: UIControlState.Normal)
        cancleBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        cancleBtn.titleLabel?.font=UIFont.systemFontOfSize(18)
        cancleBtn.tag=2000
        cancleBtn.addTarget(self, action: "cancleBtnClick:", forControlEvents: UIControlEvents.TouchUpInside)
        cancleBtn.backgroundColor=UIColor.grayColor()
        bgView?.addSubview(cancleBtn)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var H:CGFloat=0
        var rowC_f:CGFloat=CGFloat(rowC)
        var columnC_f:CGFloat=CGFloat(columnC)
        var view_w:CGFloat=CGFloat(self.frame.size.width)
        var row_1_f:CGFloat=CGFloat(rowC+1)
        var rowc_columnC_f:CGFloat=CGFloat(rowC*columnC)
        var columnC_1_f:CGFloat=CGFloat(columnC+1)
        
        if cellImageViewArray.count>rowC
        {
            if cellImageViewArray.count>rowC*columnC
            {
                H=10.0+20.0+10.0+((UIScreen.mainScreen().bounds.size.width-cellsSp*row_1_f)/rowC_f+25.0)*columnC_f+10.0+10.0+35.0+10.0
                
            }else
            {
                var rowN:Int=cellImageViewArray.count%rowC==0 ? cellImageViewArray.count/rowC : cellImageViewArray.count/rowC+1
                H=10.0+20.0+10.0+((UIScreen.mainScreen().bounds.size.width-cellsSp*row_1_f)/rowC_f+25.0)*CGFloat(rowN)+10.0+35.0+10.0
                
            }
        }else{
            H=10.0+20.0+10.0+(UIScreen.mainScreen().bounds.size.width-cellsSp*row_1_f)/rowC_f+25.0+10.0+35.0+10.0
        }
        
        bgView?.frame=CGRectMake(0, self.frame.size.height, self.frame.size.width, H)
        
        var titleLabel=bgView?.viewWithTag(100) as! UILabel
        titleLabel.frame=CGRectMake(10.0, 10.0, self.frame.size.width-10.0*2.0, 20.0)
        
        shareSV?.frame=CGRectMake(0, titleLabel.frame.origin.y+titleLabel.frame.size.height+5, bgView!.frame.size.width, bgView!.frame.size.height-95.0)
        var pageCount:Int=cellImageViewArray.count%(rowC*columnC)==0 ? Int(cellImageViewArray.count/(rowC*columnC)) : Int(cellImageViewArray.count/(rowC*columnC))+1
        shareSV?.contentSize = CGSizeMake(CGFloat(shareSV!.frame.size.width)*CGFloat(pageCount), shareSV!.frame.size.height)
        
        for i in 0..<cellImageViewArray.count
        {
            var imageView=cellImageViewArray[i] as UIImageView
            imageView.frame = CGRectMake(cellsSp+((view_w-cellsSp*row_1_f)/rowC_f+cellsSp)*((CGFloat(i)%rowc_columnC_f)%rowC_f)+CGFloat(i/rowC/columnC)*view_w, 5.0+CGFloat((i%(rowC*columnC))/rowC)*((view_w-cellsSp*row_1_f)/rowC_f+28.0), (view_w-cellsSp*row_1_f)/rowC_f, (view_w-cellsSp*row_1_f)/rowC_f)
            
            var label=cellTitleArray[i] as UILabel
            label.frame=CGRectMake(imageView.frame.origin.x-cellsSp/2.0, imageView.frame.origin.y+imageView.frame.size.height, imageView.frame.size.width+cellsSp, 20)
            
            var btn=cellBtnArray[i] as UIButton
            btn.frame=CGRectMake(imageView.frame.origin.x-cellsSp/2.0, imageView.frame.origin.y, imageView.frame.size.width+cellsSp, imageView.frame.size.height+20.0)
        }
        
        if pageCount>1
        {
            pageControl?.frame=CGRectMake(0, shareSV!.frame.origin.y+shareSV!.frame.size.height-5.0, bgView!.frame.size.width, 10.0)
            pageControl?.numberOfPages=pageCount
        }
        
        var cancleBtn=bgView?.viewWithTag(2000) as! UIButton
        cancleBtn.frame=CGRectMake(cellsSp, bgView!.frame.size.height-10.0-35.0, bgView!.frame.size.width-cellsSp*2.0, 35.0)
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDelay(0.3)
        self.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        bgView?.frame=CGRectMake(0, self.frame.size.height-bgView!.frame.size.height, self.frame.size.width, bgView!.frame.size.height)
        UIView.commitAnimations()
    }
    
    func showInView()
    {
        UIApplication.sharedApplication().keyWindow?.addSubview(self)
    }
    
    func btnClick(myBtn:UIButton)
    {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.backgroundColor=UIColor.clearColor()
            self.bgView?.frame=CGRectMake(0, self.frame.size.height, self.frame.size.width, 200)
            
            }) { (finished:Bool) -> Void in
                self.delegate?.shareSelectedIndex(myBtn.tag)
                self.removeFromSuperview()
        }
        
    }
    
    func cancleBtnClick(myBtn:UIButton)
    {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.backgroundColor=UIColor.clearColor()
            self.bgView?.frame=CGRectMake(0, self.frame.size.height, self.frame.size.width, 200)
            
            }) { (finished:Bool) -> Void in
                
                self.removeFromSuperview()
        }
    }
    
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        var i:Int=Int(scrollView.contentOffset.x/shareSV!.frame.size.width)
        pageControl?.currentPage=i
    }
    
    //点击背景消失
    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) -> Bool {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.backgroundColor=UIColor.clearColor()
            self.bgView?.frame=CGRectMake(0, self.frame.size.height, self.frame.size.width, 200)
            
            }) { (finished:Bool) -> Void in
                
            self.removeFromSuperview()
        }
        return true
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
