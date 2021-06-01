//
//  ListTableViewController.swift
//  CloudNotes
//
//  Created by steven on 2021/05/31.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    var memoList: [Memo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parseSampleData()
        // 아이패드에서는 잘 나오는데 아이폰에서는 안나옴.
//        self.navigationController?.navigationBar.topItem?.title = "메모"
        self.navigationItem.title = "메모"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarButtonTouched(_:)))

//        self.tableView.rowHeight = UITableView.automaticDimension
//        self.tableView.estimatedRowHeight = 70
        self.tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
    }
    
    func parseSampleData() {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let jsonData = NSDataAsset(name: "sample") else {
            return
        }
        guard let memoList = try? jsonDecoder.decode([Memo].self, from: jsonData.data) else {
            return
        }
        self.memoList = memoList
    }
     
    @objc func addBarButtonTouched(_ sender: UIBarButtonItem) {
        self.splitViewController?.showDetailViewController(TextViewController(), sender: nil)
        print("done!")
        
    }
}

extension ListTableViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
//
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as! ListTableViewCell
        let memoItem = memoList[indexPath.row]
        cell.titleLabel.text = memoItem.title
        cell.dateLabel.text = String(memoItem.lastModified)
        cell.bodyLabel.text = memoItem.body
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
}
