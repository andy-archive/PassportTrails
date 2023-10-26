//
//  AppSettingViewController.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/10/27.
//

import UIKit

final class AppSettingViewController: BaseViewController {
    
    private lazy var tableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.rowHeight = 60
        view.backgroundColor = Constants.Color.background
        return view
    }()
    
    private lazy var latestVersionLabel = {
        let view = UILabel()
        view.textColor = Constants.Color.secondaryLabel
        view.font = .systemFont(ofSize: Constants.FontSize.subtitle, weight: .semibold)
        view.backgroundColor = Constants.Color.background
        return view
    }()
    
    private var dataSource: UITableViewDiffableDataSource<Int, String>!
    private let settingTitle = ["💬 문의하기", "📖 개인정보 처리방침", "🪪 오픈소스 라이선스", "📦 앱 버전"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDataSource()
    }
    
    override func configureView() {
        super.configureView()
        
        navigationController?.navigationBar.topItem?.title = Constants.Text.NavigationBar.settingTitle
        
        tableView.register(AppSettingTableViewCell.self, forCellReuseIdentifier: AppSettingTableViewCell.reuseIdentifier)
        
        guard let latestVersion = Constants.System.appVersion else { return }
        latestVersionLabel.text = latestVersion
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.Design.verticalConstant),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AppSettingTableViewCell.reuseIdentifier) as? AppSettingTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.titleLabel.text = self.settingTitle[indexPath.row]
            
            if indexPath.row == 3 {
                self.latestVersionLabel.sizeToFit()
                cell.accessoryView = self.latestVersionLabel
            }
            
            return cell
        })
        
        tableView.dataSource = dataSource
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        snapshot.appendItems(settingTitle)
        dataSource.apply(snapshot)
    }
}

