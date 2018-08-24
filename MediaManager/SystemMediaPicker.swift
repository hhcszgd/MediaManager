//
//  SystemMediaPicker.swift
//  MediaManager
//
//  Created by WY on 2018/8/24.
//  Copyright © 2018年 WY. All rights reserved.
//

import UIKit

//enum SelectingStyle {
//    case system
//    case custom
//}
class SystemMediaPicker: NSObject {
    static let share = SystemMediaPicker()
    var pickImageCompletedHandler : ((_ image: UIImage?) -> Void)?
    var pickMovieCompletedHandler : ((_ data: Data?) -> Void)?
    func selectImage() -> SystemMediaPicker{
//        if style == .system {
            selectPhotoBySystem()
//        }else if style == .custom{
//            selectPhotoByCustom()
//        }
        return SystemMediaPicker.share
    }
}




extension SystemMediaPicker   {//customStyle
    private func selectPhotoByCustom(){
        
    }
}









import MobileCoreServices
extension SystemMediaPicker  : UIImagePickerControllerDelegate , UINavigationControllerDelegate  {//systemStyle
    
    
    private func selectPhotoBySystem(){
        let alertVC  = UIAlertController.init(title: nil , message: nil , preferredStyle: UIAlertControllerStyle.actionSheet)
        let alertAction1 = UIAlertAction.init(title: "拍摄", style: UIAlertActionStyle.default) { (action ) in
            
            self.setupCarame(type: 1)
            alertVC.dismiss(animated: true , completion: {
                //调用相机
            })
        }
        let alertAction2 = UIAlertAction.init(title: "相册", style: UIAlertActionStyle.default) { (action ) in
            
            self.setupCarame(type: 2)
            alertVC.dismiss(animated: true , completion: {
                //调用本地相册库
            })
        }
        let alertAction3 = UIAlertAction.init(title: "取消", style: UIAlertActionStyle.cancel) { (action ) in
            alertVC.dismiss(animated: true , completion: {})
        }
        alertVC.addAction(alertAction1)
        alertVC.addAction(alertAction2)
        alertVC.addAction(alertAction3)
        UIApplication.shared.keyWindow?.rootViewController?.present(alertVC, animated: true , completion: {
            
        })
    }
    private func pickImage(completed:(() -> ())){//系统选图
        let alertVC  = UIAlertController.init(title: nil , message: nil , preferredStyle: UIAlertControllerStyle.actionSheet)
        let alertAction1 = UIAlertAction.init(title: "拍摄", style: UIAlertActionStyle.default) { (action ) in
            
            self.setupCarame(type: 1)
            alertVC.dismiss(animated: true , completion: {
                //调用相机
            })
        }
        let alertAction2 = UIAlertAction.init(title: "相册", style: UIAlertActionStyle.default) { (action ) in
            
            self.setupCarame(type: 2)
            alertVC.dismiss(animated: true , completion: {
                //调用本地相册库
            })
        }
        let alertAction3 = UIAlertAction.init(title: "取消", style: UIAlertActionStyle.cancel) { (action ) in
            alertVC.dismiss(animated: true , completion: {})
        }
        alertVC.addAction(alertAction1)
        alertVC.addAction(alertAction2)
        alertVC.addAction(alertAction3)
        UIApplication.shared.keyWindow?.rootViewController?.present(alertVC, animated: true , completion: {
            
        })
        //        self.present(alertVC, animated: true) {}
    }
    
    
    
    
    private func setupCarame (type : Int /**1 拍摄 , 2本地相册*/)  {//调用系统相机
        //return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
        //        if (!UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.rear ) || !UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.front )){
        //            GDAlertView.alert("摄像头不可用", image: nil , time: 2, complateBlock: nil)//摄像头专属
        //        }
        let picker = UIImagePickerController.init()
        //        self.picker = picker
        picker.delegate = self
        //        if (UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.rear ) || UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.front )){
        //            //            GDAlertView.alert("摄像头不可用", image: nil , time: 2, complateBlock: nil)//摄像头专属
        //
        //            picker.sourceType = UIImagePickerControllerSourceType.camera//这一句一定在下一句之前
        //        }else{
        //            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        //        }
        if (type == 1){
            //            GDAlertView.alert("摄像头不可用", image: nil , time: 2, complateBlock: nil)//摄像头专属
            if !(UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.rear ) && UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.front )){
                //                GDAlertView.alert("摄像头不可用", image: nil , time: 2, complateBlock: nil)//摄像头专属
                return
            }else{
                picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            }
            picker.sourceType = UIImagePickerControllerSourceType.camera//这一句一定在下一句之前
        }else{
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        }
        //        picker.mediaTypes = [kUTTypeMovie as String , kUTTypeVideo as String , kUTTypeImage as String  , kUTTypeJPEG as String , kUTTypePNG as String]//kUTTypeMPEG4
        picker.mediaTypes = [kUTTypeImage as String  , kUTTypeJPEG as String , kUTTypePNG as String]//只要图片
        
        //        picker.allowsEditing = true ;
        picker.videoMaximumDuration = 12
        //        picker.showsCameraControls = true//摄像头专属
        //        picker.cameraOverlayView = UISwitch()
        //        picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureMode.photo
        //            pickerVC.navigationBar.isHidden = true
        UIApplication.shared.keyWindow!.rootViewController!.present(picker, animated: true, completion: nil)
        //        UIApplication.shared.keyWindow!.rootViewController!.present(FilterDisplayViewController(), animated: true, completion: nil)//自定义照相机 , todo
    }
    
    // MARK: 注释 : imagePickerDelegate
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        if let type  = info[UIImagePickerControllerMediaType] as? String{
            DispatchQueue.main.async {
                if type == "public.movie" {
                    self.dealModie(info: info)
                }else if type == "public.image" {
                    self.dealImage(info: info)
                }
                
            }
            picker.dismiss(animated: true) {}
        }
    }
    private func dealModie(info:[String : Any])  {
        if let url  = info[UIImagePickerControllerMediaURL] as? URL {
            //file:///private/var/mobile/Containers/Data/Application/6142A42C-BDE9-43CF-8C2E-B04F06945925/tmp/51711806175__214B5E6E-8AD3-4AF0-9CA0-EF891A4B4543.MOV
            //                let avPlayer : AVPlayer = AVPlayer.init(url: url)
            //                let avPlayerVC : AVPlayerViewController  = AVPlayerViewController.init()
            //                self.avPlayerVC = avPlayerVC
            //                avPlayerVC.player = avPlayer
            //                self.present(avPlayerVC, animated: true  , completion: { })
            
            
            do{
                let data : Data = try Data.init(contentsOf: url)
                
                pickMovieCompletedHandler?(data)
            }catch{
                pickMovieCompletedHandler?(nil)
                //                mylog(error)
            }
            pickMovieCompletedHandler = nil
        }else{
            pickMovieCompletedHandler?(nil)
            pickMovieCompletedHandler = nil
        }
    }
    
    
    
    private func dealImage(info:[String : Any])  {
        var theImage : UIImage?
        if let editImageReal  = info[UIImagePickerControllerEditedImage] as? UIImage {
            theImage = editImageReal
        }else  if let originlImage  = info[UIImagePickerControllerOriginalImage] as? UIImage {
            theImage = originlImage
        }
        //perform upload image
        if theImage != nil  {
            self.pickImageCompletedHandler?(theImage)
            self.pickImageCompletedHandler = nil
            //            let imageData = UIImageJPEGRepresentation(theImage!, 0.5)
        }
    }
}
