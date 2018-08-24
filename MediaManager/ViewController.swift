//
//  ViewController.swift
//  MediaManager
//
//  Created by WY on 2018/8/24.
//  Copyright © 2018年 WY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.green
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
//        SystemMediaPicker.share.selectImage().pickImageCompletedHandler = {image in// 系统方式获取照片
//            print(image)
//        }
        DDImagePickerAlert.alert().completedHandle = {assets in//自定义获取图片
            print(assets)
        }
    }

}

