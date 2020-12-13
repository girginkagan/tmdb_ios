//
//  DetailViewController.swift
//  tmdb
//
//  Created by Kagan Girgin on 12.12.2020.
//

import UIKit

protocol DetailViewInputs: AnyObject {
    func prepareUI()
    func onError(err: BaseModelError)
    func onTableViewReady(source: DetailTableViewSource?)
}

protocol DetailViewOutputs: AnyObject {
    func viewDidLoad()
}

final class DetailViewController: UIViewController{
    
    internal var presenter: DetailViewOutputs?
    let tableView = UITableView()
    
    override func viewWillDisappear(_ animated: Bool) {
        setNavigationBarAppearance(appeared: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNavigationBarAppearance(appeared: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
        navigationItem.title = " "
    }
    
    func setNavigationBarAppearance(appeared: Bool){
        if appeared{
            navigationController?.navigationBar.shadowImage = UIImage()
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        }
        else{
            navigationController?.navigationBar.shadowImage = nil
            navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        }
    }
}

extension DetailViewController: DetailViewInputs{
    func onError(err: BaseModelError) {
        AlertUtil.showStandardAlert(parentController: self, title: "Error", message: APIErrorGenerator().generateError(error: err))
    }
    
    func onTableViewReady(source: DetailTableViewSource?) {
        tableView.dataSource = source
        tableView.delegate = source
        tableView.reloadData()
    }
    
    func prepareUI() {
        view.backgroundColor = UIColor(red: CGFloat(248/255.0), green: CGFloat(248/255.0), blue: CGFloat(248/255.0), alpha: 1.0)
        
        //MARK: tableView init
        tableView.allowsSelection = false
        tableView.backgroundColor = UIColor(red: CGFloat(248/255.0), green: CGFloat(248/255.0), blue: CGFloat(248/255.0), alpha: 1.0)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        tableView.separatorStyle = .none
        tableView.register(DetailHeaderTableViewCell.self, forCellReuseIdentifier: "DetailHeaderTableViewCell")
        tableView.register(TitleTableViewCell.self, forCellReuseIdentifier: "TitleTableViewCell")
        tableView.register(DetailDescriptionTableViewCell.self, forCellReuseIdentifier: "DetailDescriptionTableViewCell")
        tableView.register(DetailVideosTableViewCell.self, forCellReuseIdentifier: "DetailVideosTableViewCell")
        tableView.register(DetailCastTableViewCell.self, forCellReuseIdentifier: "DetailCastTableViewCell")
        tableView.register(DetailPersonMoviesTableViewCell.self, forCellReuseIdentifier: "DetailPersonMoviesTableViewCell")
        tableView.register(DetailPersonTVsTableViewCell.self, forCellReuseIdentifier: "DetailPersonTVsTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        
        //MARK: set constraints
        NSLayoutConstraint.activate([
            tableView.leading.constraint(equalTo: view.leading),
            tableView.trailing.constraint(equalTo: view.trailing),
            tableView.top.constraint(equalTo: view.topAnchor),
            tableView.bottom.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension DetailViewController: Viewable {}
