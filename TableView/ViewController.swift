//
//  ViewController.swift
//  TableView
//
//  Created by 柴田優河 on 2021/02/14.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SendInputViewText, sendNextViewText {
    
//    var hierarchicalData = [[String]]()
    var hierarchicalData = [["test1", "test2"]]
    var sectionTitles = ["メモ一覧"]
    var currentIndexPath = Int()

    @IBOutlet weak var inputButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true) // navigationbarをhiddenする
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let ViewWidth = self.view.frame.size.width
        let viewHeight = self.view.frame.size.height
        let buttonSize = ViewWidth / 4
        inputButton.frame = CGRect(x: ViewWidth - buttonSize, y: viewHeight - buttonSize, width: buttonSize, height: buttonSize)
    }
    
    // セクションの数
    func numberOfSections(in tableView: UITableView) -> Int {
        if hierarchicalData.count == 0 {
            hierarchicalData.append([String]())
        }
        return hierarchicalData.count
    }
    
    // セクションのタイトル
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[0]
    }

    // 行の数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hierarchicalData[section].count
    }
    
    // セル
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = hierarchicalData[indexPath.section][indexPath.row]
        cell.imageView?.image = UIImage(named: "mail")
        return cell
    }
    
    // 行の高さ
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        var cellSize = UITableView.automaticDimension
        // 一番最初のcellだった場合、そのcellをタイトルcellとして利用する
        if indexPath.row == 0 {
            // 各フォントの大きさを指定する
            let largeTitleFont = UIFont.preferredFont(forTextStyle: .largeTitle)
            let bodyFont = UIFont.preferredFont(forTextStyle: .body)
            
            let largeTitleHeight = largeTitleFont.lineHeight + largeTitleFont.leading
            let bodyHeight = bodyFont.lineHeight + bodyFont.leading
            
            let cellMarginSize:CGFloat = 4.0
            
            let titleCellSize = largeTitleHeight + (bodyHeight * 2.0) + (cellMarginSize * 2)
            cellSize = titleCellSize
        }
        return cellSize
    }
    
    // tableVIewをスワイプしたときのアクションを登録する
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // 削除処理
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            //削除処理を記述
            print("Deleteがタップされた")
            self.hierarchicalData[indexPath.section].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            print(indexPath)
            while true {
                var foundNill = false
                if self.hierarchicalData.count == 0 {
                    break
                }
                // hierarchicalDataの空配列を削除する
                for i in 0...self.hierarchicalData.count - 1 {
                    print("i:\(i)")
                    if self.hierarchicalData[i].isEmpty {
                        // 空配列を削除する。途中で削除すると添字が変わるので、for文を最初からやり直す
                        self.hierarchicalData.remove(at: i)
                        print(self.hierarchicalData)
                        foundNill = true
                        break
                    }
                }
                if foundNill == false {
                    break
                }
            }
            // rowを読み込み直す
            tableView.reloadData()
            // 実行結果に関わらず記述
            completionHandler(true)
        }
        // 定義したアクションをセット
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    // 行を選択したときに呼び出される
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)が選択されました")
        currentIndexPath = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        let text = hierarchicalData[0][indexPath.row]
        let data = sendDatas(text: text, path: indexPath.row)
        self.performSegue(withIdentifier: "next", sender: data)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "input" {
            let inputView = segue.destination as! InputViewController
            inputView.delegate = self
        } else if segue.identifier == "next" {
            let nextView = segue.destination as! NextViewController
            nextView.sendedData = sender as? sendDatas;()
        }
        
    }
    
    func sendText(text: String) {
        hierarchicalData[0].append(text)
        tableView.reloadSections([0], with: .none)
        print(hierarchicalData)
    }
    
    func sendEditedText(text: String) {
        hierarchicalData[0][currentIndexPath] = text
        let path:IndexPath = [0, currentIndexPath]
        tableView.reloadRows(at: [path], with: .fade)
        print("呼ばれたよ")
    }

    // textViewの編集が開始されたときに呼び出される
    func textViewDidBeginEditing(_ textView: UITextView) {
        // darkモードに対応してフォントカラーを変更
        if traitCollection.userInterfaceStyle == .dark {
            textView.textColor = UIColor.white
        } else {
            textView.textColor = UIColor.black
        }
    }

}

