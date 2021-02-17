//
//  InputViewController.swift
//  TableView
//
//  Created by 柴田優河 on 2021/02/16.
//

import UIKit

class InputViewController: UIViewController, UITextViewDelegate{

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var textView: UITextView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        textView.delegate = self
        textViewdSettings()
    }
    
    @IBAction func save(_ sender: Any) {
        // textViewの文字をviewControllerへと渡す　
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
        let navigationBarHeight = navigationBar.frame.size.height
        textView.frame = CGRect(x: 0, y: navigationBarHeight, width: view.frame.size.width, height: view.frame.size.height - navigationBarHeight)
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.font = UIFont.italicSystemFont(ofSize: 30)
        textView.text = "本文を入力……"
    }
    

}
