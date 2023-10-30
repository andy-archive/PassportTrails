//
//  AppSettingViewController.swift
//  PassportTrails
//
//  Created by Taekwon Lee on 2023/10/27.
//

import UIKit
import SafariServices

final class AppSettingViewController: BaseViewController {
    
    enum Section: Int {
        case support = 0, appInfo
        
        func headerDescription() -> String {
            switch self {
            case .support:
                return Constants.Setting.Section.support
            case .appInfo:
                return Constants.Setting.Section.appInfo
            }
        }
    }
    
    typealias SectionType = Section
    
    private lazy var tableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.rowHeight = 60
        view.backgroundColor = Constants.Color.groupedBackground
        return view
    }()
    
    private lazy var latestVersionLabel = {
        let view = UILabel()
        view.textColor = Constants.Color.secondaryLabel
        view.font = .systemFont(ofSize: Constants.FontSize.subtitle, weight: .regular)
        return view
    }()
    
    private var dataSource: UITableViewDiffableDataSource<SectionType, String>!
    private let supportList = Constants.Setting.supportList
    private let appInfoList = Constants.Setting.appInfoList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDataSource()
    }
    
    override func configureView() {
        navigationController?.navigationBar.topItem?.title = Constants.Text.NavigationBar.settingTitle
        
        tableView.delegate = self
        tableView.register(AppSettingTableViewCell.self, forCellReuseIdentifier: AppSettingTableViewCell.reuseIdentifier)
        
        guard let latestVersion = Constants.System.appVersion else { return }
        latestVersionLabel.text = latestVersion
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func setConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureDataSource() {
        dataSource = DataSource(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AppSettingTableViewCell.reuseIdentifier) as? AppSettingTableViewCell else { return UITableViewCell() }
            
            if indexPath.section == 0 {
                cell.titleLabel.text = self.supportList[indexPath.row]
            } else if indexPath.section == 1 {
                cell.titleLabel.text = self.appInfoList[indexPath.row]
                
                if indexPath.row == 2 {
                    cell.accessoryView = self.latestVersionLabel
                    self.latestVersionLabel.sizeToFit()
                }
            } else {
                return UITableViewCell()
            }
            return cell
        })
        
        tableView.dataSource = dataSource
        
        var snapshot = NSDiffableDataSourceSnapshot<SectionType, String>()
        snapshot.appendSections([.support])
        snapshot.appendItems(supportList)
        snapshot.appendSections([.appInfo])
        snapshot.appendItems(appInfoList)
        
        dataSource.apply(snapshot)
    }
    
    private func openSafari(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let vc = SFSafariViewController(url: url)
        
        present(vc, animated:  true)
    }
    
    private func openInstagram(urlString: String) {
        guard let instagramURL = NSURL(string: urlString) else { return }
        
        if UIApplication.shared.canOpenURL(instagramURL as URL) {
            UIApplication.shared.open(
                instagramURL as URL,
                options: [:],
                completionHandler: nil
            )
        }
    }
}

//MARK: UITableViewDiffableDataSource

extension AppSettingViewController {
    
    class DataSource: UITableViewDiffableDataSource<SectionType, String> {
        
        override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            let sectionKind = Section(rawValue: section)
            return sectionKind?.headerDescription()
        }
    }
}

//MARK: UITableViewDelegate

extension AppSettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0: openInstagram(urlString: Constants.LinkUrl.AppSupport.instagram)
            case 1: openSafari(urlString: Constants.LinkUrl.AppSupport.googleForm)
            default: break
            }
        } else if
            indexPath.section == 1 {
            switch indexPath.row {
            case 0: openSafari(urlString: Constants.LinkUrl.AppInfo.privacyPolicy)
            case 1: openSafari(urlString: Constants.LinkUrl.AppInfo.openSourceLicence)
            default: break
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
