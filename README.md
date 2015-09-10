# ARShareCustomViewDemo
swift写的自定义第三方分享弹窗，可根据分享的数量动态高度，支持分页

简单使用
var shareView:ARShareCustomView=ARShareCustomView(title: "分享到", cancleBtnTitle: "取消", shareImageArr: ["PAG1","PAG2","PAG3","PAG2","PAG2","PAG3","PAG2","PAG2","PAG3","PAG2","PAG2","PAG3","PAG2"], shareTitleArr: ["微信朋友圈","PAG2","PAG3","PAG2","PAG2","PAG3","PAG2","PAG2","PAG3","PAG2","PAG2","PAG3","PAG2"])
shareView.delegate=self
shareView.showInView()

选中代理ARShareCustomViewDelegate
func shareSelectedIndex(index: Int) {
       
}
