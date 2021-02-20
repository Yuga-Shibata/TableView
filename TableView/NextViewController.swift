//
//  NextViewController.swift
//  TableView
//
//  Created by 柴田優河 on 2021/02/14.
//

import UIKit

protocol sendNextViewText {
    func sendEditedText(text:String)
}

class NextViewController: UIViewController {
        
    @IBOutlet weak var textView: UITextView!
    
    var sendedData:sendDatas?
    var delegate:sendNextViewText?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: false) // navigationbarを表示する
        textView.text = sendedData?.text
    }
    
    override func viewWillLayoutSubviews() {
        configure()
    }
    
    @IBAction func save(_ sender: Any) {
        textView.resignFirstResponder()
        if let editedText = textView.text {
            delegate?.sendEditedText(text: editedText)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.alpha = 0.0
    }

    func configure() {
        let navigationBarHeight = self.navigationController?.navigationBar.frame.size.height
        textView.frame = CGRect(x: 0, y: navigationBarHeight!, width: view.frame.size.width, height: self.view.frame.size.height - navigationBarHeight!)
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.font = UIFont.italicSystemFont(ofSize: 30)
        // darkモードに対応してフォントカラーを変更
        if traitCollection.userInterfaceStyle == .dark {
            textView.textColor = UIColor.white
        } else {
            textView.textColor = UIColor.black
        }
    }
    
    // textViewの編集が開始されたときに呼び出される
    func textViewDidBeginEditing(_ textView: UITextView) {
        
    }
}
