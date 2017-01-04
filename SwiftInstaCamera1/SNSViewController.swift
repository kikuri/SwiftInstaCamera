//
//  SNSViewController.swift
//  SwiftInstaCamera1
//
//  Created by kikuchi wataru on 2017/01/04.
//  Copyright © 2017年 kikuchi wataru. All rights reserved.
//

import UIKit
import Social

class SNSViewController: UIViewController {
    
    
    var endImage:UIImage = UIImage()
    
    //SNSシェア用
    var myComposeView : SLComposeViewController!

    
    @IBOutlet weak var endImageView: UIImageView!
    
    @IBOutlet weak var textView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        endImageView.image = endImage
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(textView.isFirstResponder){
            textView.resignFirstResponder()
        }
    }
    
    
    
    @IBAction func save(_ sender: Any) {
        
        //画像を保存する
        //UIImageWriteToSavedPhotosAlbum(self.endImageView.image!, self, nil, nil)
        UIImageWriteToSavedPhotosAlbum(endImageView.image!, self, nil, nil)
        //アラート画面をだす
        let alertController = UIAlertController(title: "保存が完了しました。",
                                                message: "OKボタンをおしてください",
                                                preferredStyle: .alert)

        let okAction:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action: UIAlertAction!) -> Void in
            
            
        })
        alertController.addAction(okAction)
        present(alertController, animated:true, completion: nil)
        

    }
    

    @IBAction func share(_ sender: Any) {
        
        //SNSへ投稿するメニュー画面を立ち上げるボタン
        
        let alertController = UIAlertController(title: "SNSへ投稿",
                                                message: "投稿する場所を選択肢て下さい。",
                                                preferredStyle: .actionSheet)
        
        let cancelAction:UIAlertAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: {(action:UIAlertAction!) -> Void in
            
            //キャンセルボタンの処理
        })
        let defaultAction1:UIAlertAction = UIAlertAction(title: "Facebook", style: UIAlertActionStyle.default, handler: {(action: UIAlertAction!) -> Void in
            
            //ここに処理を書く
            self.postFacebook()
            
        })
        
        let defaultAction2:UIAlertAction = UIAlertAction(title: "Twitter", style: UIAlertActionStyle.default, handler: {(action: UIAlertAction!) -> Void in
            
            //ここに処理を書く
            self.postTwitter()
            
        })
        
        let defaultAction3:UIAlertAction = UIAlertAction(title: "LINE", style: UIAlertActionStyle.default, handler: {(action: UIAlertAction!) -> Void in
            
            //ここに処理を書く
            self.postLINE()
            
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(defaultAction1)
        alertController.addAction(defaultAction2)
        alertController.addAction(defaultAction3)
        present(alertController, animated: true, completion: nil)
        
    }
    
    //Twitterに投稿するメソッド
    func postTwitter(){
        
        myComposeView = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        myComposeView.setInitialText(textView.text)
        myComposeView.add(endImageView.image)
        //SNSへの投稿画面が自動的に立ち上がる
        self.present(myComposeView, animated:true, completion: nil)
        
        
    }
    
    //Facebookに投稿するメソッド
    func postFacebook(){
        
        myComposeView = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        myComposeView.setInitialText(textView.text)
        myComposeView.add(endImageView.image)
        //SNSへの投稿画面が自動的に立ち上がる
        self.present(myComposeView, animated:true, completion: nil)
        
        
    }
    
    func postLINE(){
        
        let pastBoard: UIPasteboard = UIPasteboard.general
        
        pastBoard.setData(UIImageJPEGRepresentation(endImageView.image!, 0.75)!, forPasteboardType: "public.png")
        pastBoard.setValue(textView.text, forPasteboardType:textView.text)
        
        let lineUrlString: String = String(format: "line://msg/image/%@", pastBoard.name as CVarArg)
        
        
        UIApplication.shared.open(NSURL(string: lineUrlString)! as URL)

    }
    
    
    @IBAction func back(_ sender: Any) {
        
        //アラート画面をだす
        let alertController = UIAlertController(title: "本文は破棄されてしまいます。",
                                                message: "よろしいですか？",
                                                preferredStyle: .alert)
        
        let cancelAction:UIAlertAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: {(action:UIAlertAction!) -> Void in
            
            //キャンセルボタンの処理
        })
        
        let okAction:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action: UIAlertAction!) -> Void in
            
            //戻る
            self.navigationController?.popViewController(animated: true)
            
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        present(alertController, animated:true, completion: nil)

        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    


}
