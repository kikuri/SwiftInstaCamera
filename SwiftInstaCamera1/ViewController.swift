//
//  ViewController.swift
//  SwiftInstaCamera1
//
//  Created by kikuchi wataru on 2017/01/04.
//  Copyright © 2017年 kikuchi wataru. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

  


    @IBAction func camera(_ sender: Any) {
        
        
        let sourceType:UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.camera
        //カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            //インスタンスの生成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
            
        }

        
        
    }
    
    
    @IBAction func album(_ sender: Any) {
        
        
        let sourceType:UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.photoLibrary
        //カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
            //インスタンスの生成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
            
        }
        
        
    }
    
    //カメラ(アルバム)から画像を受け取るデリゲートメソッド
    func imagePickerController(_ imagePicker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            
            imageView.image = pickedImage
            
            //画面遷移
            performSegue(withIdentifier: "next", sender: nil)
            
            //値を渡しながら画面遷移をする
            
                   }
        
        //カメラ画像(アルバム画像)を閉じる処理
        imagePicker.dismiss(animated: true, completion: nil)
        
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if(segue.identifier == "next"){
            let editVC: EditViewController = segue.destination as! EditViewController
            
            //UIImage型の画像を入れる
            editVC.willEditImage = imageView.image!
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

