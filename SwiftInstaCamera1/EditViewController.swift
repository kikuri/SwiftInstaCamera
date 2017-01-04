//
//  EditViewController.swift
//  SwiftInstaCamera1
//
//  Created by kikuchi wataru on 2017/01/04.
//  Copyright © 2017年 kikuchi wataru. All rights reserved.
//

import UIKit
import CoreImage

class EditViewController: UIViewController {
    
    //フィルターをつける速度が早くなる
    var ciContext: CIContext!

    
    var willEditImage: UIImage = UIImage()
    
    
    @IBOutlet weak var sc: UIScrollView!
    
    
    @IBOutlet weak var editImageView: UIImageView!
    
    var uv = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        editImageView.image = nil
        editImageView.image = willEditImage
        
        
        //位置とサイズを決めます。
        uv.frame = CGRect(x: 0, y: 0, width: 800, height: 80)
        
        //uibuttonを作成
        for i in 0..<6{
            
            let button:UIButton = UIButton()
            button.frame = CGRect(x: i*80, y: 0, width: 80, height: 80)
            button.tag = i
            button.addTarget(self, action: #selector(tap), for: .touchUpInside)
            let buttonImage:UIImage = UIImage(named: String(i) + ".jpg")!
            button.setImage(buttonImage, for: UIControlState.normal)
            uv.addSubview(button)
            
        }
        
        //scにuvを貼る
        sc.addSubview(uv)
        sc.contentSize = uv.bounds.size
        
    }

    func tap(sender: UIButton){
        
        //tagの番号によって、editImageViewのimageを変えたい(フィルターをつけたい)
        
        if(sender.tag == 0){
            filter1()
        }
        if(sender.tag == 1){
            filter2()
        }
        if(sender.tag == 2){
            filter3()
        }
        if(sender.tag == 3){
            filter4()
        }
        if(sender.tag == 4){
            filter5()
        }
        if(sender.tag == 5){
            filter6()
        }
       
    }
    
    //画面遷移(画像の値を渡しながら)
    @IBAction func next(_ sender: Any) {
        
        performSegue(withIdentifier: "end", sender: nil)
        
    }
    
    // Segue 準備
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "end") {
            let snsVC: SNSViewController = segue.destination as! SNSViewController
            
            //UIImage型の画像を入れる
            snsVC.endImage =  editImageView.image!
            
        }
    }

    
    
    //フィルターのメソッドをつくっていく
    func filter1(){
        
        //imageが元画像のUIImage
        let ciImage:CIImage = CIImage(image:editImageView.image!)!;
        let ciFilter:CIFilter = CIFilter(name: "CISepiaTone")!
        ciFilter.setValue(ciImage, forKey: kCIInputImageKey)
        ciFilter.setValue(0.8, forKey: "inputIntensity")
        self.ciContext = CIContext(options: nil)
        let cgimg:CGImage = ciContext.createCGImage(ciFilter.outputImage!, from: ciFilter.outputImage!.extent)!
        
        //image2に加工後のUIImage
        let image2:UIImage = UIImage(cgImage: cgimg, scale: 1.0, orientation: UIImageOrientation.up)
        
        editImageView.image = image2
        
        
    }
    
    func filter2(){
        let ciImage:CIImage = CIImage(image:editImageView.image!)!;
        let ciFilter:CIFilter = CIFilter(name: "CIColorMonochrome")!
        ciFilter.setValue(ciImage, forKey: kCIInputImageKey)
        ciFilter.setValue(CIColor(red: 0.75, green: 0.75, blue: 0.75), forKey: "inputColor")
        ciFilter.setValue(1.0, forKey: "inputIntensity")
        self.ciContext = CIContext(options: nil)
        let cgimg:CGImage = ciContext.createCGImage(ciFilter.outputImage!, from:ciFilter.outputImage!.extent)!
        //image2に加工後のUIImage
        let image2:UIImage = UIImage(cgImage: cgimg, scale: 1.0, orientation:UIImageOrientation.up)
        editImageView.image = image2
        
    }

    
    func filter3(){
        let ciImage:CIImage = CIImage(image:editImageView.image!)!;
        let ciFilter:CIFilter = CIFilter(name: "CIFalseColor" )!
        ciFilter.setValue(ciImage, forKey: kCIInputImageKey)
        ciFilter.setValue(CIColor(red: 0.44, green: 0.5, blue: 0.2), forKey: "inputColor0")
        ciFilter.setValue(CIColor(red: 1, green: 0.92, blue: 0.50), forKey: "inputColor1")
        self.ciContext = CIContext(options: nil)
        let cgimg:CGImage = ciContext.createCGImage(ciFilter.outputImage!, from:ciFilter.outputImage!.extent)!
        //image2に加工後のUIImage
        let image2:UIImage = UIImage(cgImage: cgimg, scale: 1.0, orientation:UIImageOrientation.up)
        editImageView.image = image2
        
        
        
    }
    
    
    func filter4(){
        
        let ciImage:CIImage = CIImage(image:editImageView.image!)!;
        let ciFilter:CIFilter = CIFilter(name: "CIColorControls" )!
        ciFilter.setValue(ciImage, forKey: kCIInputImageKey)
        ciFilter.setValue(1.0, forKey: "inputSaturation")
        ciFilter.setValue(0.5, forKey: "inputBrightness")
        ciFilter.setValue(3.0, forKey: "inputContrast")
        self.ciContext = CIContext(options: nil)
        let cgimg:CGImage = ciContext.createCGImage(ciFilter.outputImage!, from:ciFilter.outputImage!.extent)!
        //image2に加工後のUIImage
        let image2:UIImage = UIImage(cgImage: cgimg, scale: 1.0, orientation:UIImageOrientation.up)
        editImageView.image = image2
        
    }
    
    func filter5(){
        
        let ciImage:CIImage = CIImage(image:editImageView.image!)!;
        let ciFilter:CIFilter = CIFilter(name: "CIToneCurve" )!
        ciFilter.setValue(ciImage, forKey: kCIInputImageKey)
        ciFilter.setValue(CIVector(x: 0.0, y: 0.0), forKey: "inputPoint0")
        ciFilter.setValue(CIVector(x: 0.25, y: 0.1), forKey: "inputPoint1")
        ciFilter.setValue(CIVector(x: 0.5, y: 0.5), forKey: "inputPoint2")
        ciFilter.setValue(CIVector(x: 0.75, y: 0.9), forKey: "inputPoint3")
        ciFilter.setValue(CIVector(x: 1.0, y: 1.0), forKey: "inputPoint4")
        self.ciContext = CIContext(options: nil)
        let cgimg:CGImage = ciContext.createCGImage(ciFilter.outputImage!, from:ciFilter.outputImage!.extent)!
        //image2に加工後のUIImage
        let image2:UIImage = UIImage(cgImage: cgimg, scale: 1.0, orientation:UIImageOrientation.up)
        editImageView.image = image2
        
    }
    
    func filter6(){
        let ciImage:CIImage = CIImage(image:editImageView.image!)!;
        let ciFilter:CIFilter = CIFilter(name: "CIHueAdjust" )!
        ciFilter.setValue(ciImage, forKey: kCIInputImageKey)
        ciFilter.setValue(3.14, forKey: "inputAngle")
        self.ciContext = CIContext(options: nil)
        let cgimg:CGImage = ciContext.createCGImage(ciFilter.outputImage!, from:ciFilter.outputImage!.extent)!
        //image2に加工後のUIImage
        let image2:UIImage = UIImage(cgImage: cgimg, scale: 1.0, orientation:UIImageOrientation.up)
        editImageView.image = image2
        
        
    }


    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
