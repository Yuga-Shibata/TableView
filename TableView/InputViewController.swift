//
//  InputViewController.swift
//  TableView
//
//  Created by 柴田優河 on 2021/02/16.
//

import UIKit

class InputViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        textView.delegate = self
        textViewdSettings()
    }
    
    // textViewの編集が開始されたときに呼び出される
    func textViewDidBeginEditing(_ textView: UITextView) {
        // darkモードに対応してフォントカラーを変更
        if traitCollection.userInterfaceStyle == .dark {
            textView.textColor = UIColor.white
        } else {
            textView.textColor = UIColor.black
        }
        textView.text = ""
    }
    
    func textViewdSettings() {
//        textView.frame = CGRect(x: <#T##CGFloat#>, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>)
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.font = UIFont.italicSystemFont(ofSize: 30)
        textView.text = "本文を入力……"
    }
    

}
