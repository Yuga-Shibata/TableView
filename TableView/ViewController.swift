//
//  ViewController.swift
//  TableView
//
//  Created by 柴田優河 on 2021/02/14.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
//    var hierarchicalData = [[String]]()
    var hierarchicalData = [["test1", "test2"], ["test3"]]
    var sectionTitles = ["title1", "title2"]
    var text = String()
    

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
    
    @IBAction func input(_ sender: Any) {
      
    }
    // セクションの数
    func numberOfSections(in tableView: UITableView) -> Int {
        return hierarchicalData.count
    }
    
    // セクションのタイトル
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }

    // 行の数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hierarchicalData[section].count
    }
    
    // セル
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = hierarchicalData[indexPath.section][indexPath.row]
        cell.imageView?.image = UIImage(named: "bunny")
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
    
    // 行を選択したときに呼び出される
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(text)
        print("\(indexPath.row)が選択されました")
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "next", sender: nil)
    }
    

}

