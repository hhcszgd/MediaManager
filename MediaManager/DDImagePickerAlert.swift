//
//  DDImagePickerAlert.swift
//  MediaManager
//
//  Created by WY on 2018/8/24.
//  Copyright © 2018年 WY. All rights reserved.
//

import UIKit

class DDImagePickerAlert: DDAlertContainer {
    var completedHandle : ((_ images : [PHAsset]?) -> Void)?
    let titleLabel = UILabel()
    let confirm = UIButton()
    let cancle = UIButton()
    let imgPicker =  DDImagePicker.init(frame: CGRect(x: 0, y: 0, width: 350, height: 600))
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imgPicker.delegate = self 
        self.addSubview(imgPicker)
        self.addSubview(confirm)
        self.addSubview(cancle)
        self.addSubview(titleLabel)
        confirm.setTitle("确定", for: UIControlState.normal)
        cancle.setTitle("取消", for: UIControlState.normal)
        confirm.setTitleColor(UIColor.lightGray, for: UIControlState.normal)
        cancle.setTitleColor(UIColor.lightGray, for: UIControlState.normal)
        
        titleLabel.text = "照片"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 19)
        confirm.addTarget(self , action: #selector(buttonClick(sender:)), for: UIControlEvents.touchUpInside)
        cancle.addTarget(self , action: #selector(buttonClick(sender:)), for: UIControlEvents.touchUpInside)
    }
    @objc func buttonClick(sender:UIButton) {
        if sender == self.confirm{
            imgPicker.done()
            self.remove()
            
        }else if sender == self.cancle{
            self.remove()
        }
    }
    static func alert(superView : UIView? = nil) -> DDImagePickerAlert{
        let pickerAlert = DDImagePickerAlert()
        pickerAlert.alpha = 0
        pickerAlert.backgroundColor = UIColor.lightGray.withAlphaComponent(pickerAlert.backgroundColorAlpha)
        if let superview = superView{
            superview.addSubview(pickerAlert)
            pickerAlert.frame = superview.bounds
        }else if let window = UIApplication.shared.keyWindow{
            window.addSubview(pickerAlert)
            pickerAlert.frame = window.bounds
        }
        
        UIView.animate(withDuration: 0.3) {
            pickerAlert.alpha = 1
        }
        return pickerAlert
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let buttonW : CGFloat = 64
        
        let topMargin : CGFloat = 24
        let bottomMargin : CGFloat = 36
        let buttonH : CGFloat = 44
        var buttonY  : CGFloat = 0
        if let windowBounds  = UIApplication.shared.keyWindow?.bounds , let superviewBounds = self.superview?.bounds , windowBounds.width == superviewBounds.width , windowBounds.height == superviewBounds.height {
            buttonY  = DDNavigationBarHeight - 44
        }else{
            buttonY = 0
        }
        self.cancle.frame = CGRect(x: 0, y: buttonY , width: buttonW, height: buttonH)
        self.confirm.frame = CGRect(x: self.bounds.width - buttonW, y: buttonY, width: buttonW, height: buttonH)
        self.titleLabel.frame = CGRect(x: self.cancle.frame.maxX, y: buttonY, width: self.confirm.frame.minX - self.cancle.frame.maxX, height: buttonH)
        
        self.imgPicker.frame = CGRect(x: 0, y: self.titleLabel.frame.maxY, width: self.bounds.width, height: self.bounds.height - self.titleLabel.frame.maxY )
        self.backgroundColor = .white
    }


}
import Photos
extension DDImagePickerAlert : GDImagePickerviewDelegate
{
    
    func getSelectedPHAssets(assets: [PHAsset]?) {
        print(assets?.count)
        completedHandle?(assets)
//        MediaManager.share.getMediaByPHAsset(asset: <#T##PHAsset#>, callBack: <#T##(UIImage?, [AnyHashable : Any]?) -> ()#>)//取出图片
    }
    
    func scrollDirection() -> UICollectionViewScrollDirection {
        return  UICollectionViewScrollDirection.vertical
    }
    func columnCount() -> Int {
        return 4
    }
    func rowCount() -> Int {
        return 5
    }
}
