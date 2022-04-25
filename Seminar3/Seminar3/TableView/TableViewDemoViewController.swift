//
//  TableViewDemoViewController.swift
//  Seminar3
//
//  Created by taehy.k on 2022/04/25.
//

import UIKit

class TableViewDemoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        registerXibs()
    }
    
    // 테이블 뷰 세팅 관련 함수 정의
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // 셀 등록 관련 함수 정의
    private func registerXibs() {
        let nib = UINib(nibName: MusicTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: MusicTableViewCell.identifier)
    }
}

extension TableViewDemoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

extension TableViewDemoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MusicDataModel.sampleData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MusicTableViewCell.identifier, for: indexPath) as? MusicTableViewCell else { return UITableViewCell() }
        
        cell.setData(MusicDataModel.sampleData[indexPath.row])
        
        return cell
    }
}

