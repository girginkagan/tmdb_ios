//
//  HomeViewController.swift
//  tmdb
//
//  Created by Kagan Girgin on 12.12.2020.
//

import UIKit
import RxSwift
import RxCocoa

protocol HomeViewInputs: AnyObject {
    func prepareUI()
    func onError(err: BaseModelError)
    func onTableViewReady(source: HomeTableViewSource?)
    func onTableViewReadySearch(source: SearchResultTableViewSource?)
    func reloadTableView()
    func reloadTableViewSearch()
    func endEditing()
}

protocol HomeViewOutputs: AnyObject {
    func viewDidLoad()
    func refreshData()
    func getSearchData(q: String)
    func onSearchSegmentChanged(segment: MediaType)
}

final class HomeViewController: UIViewController{
    
    internal var presenter: HomeViewOutputs?
    let searchBar = UISearchBar()
    let tableView = UITableView()
    let refreshControl = UIRefreshControl()
    let viewSearchResult = UIView()
    let segmentedControlResult = UISegmentedControl(items: ["Movies", "People", "TV"])
    let tvSearchResult = UITableView()
    let viewSearchNoResult = UIView()
    let lblSearchNoResult = UILabel()
    let viewSearchLoading = UIView()
    let activityIndicatorSearchLoading = UIActivityIndicatorView(style: .gray)
    let _disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
    }
}

extension HomeViewController: HomeViewInputs{
    func reloadTableViewSearch() {
        tvSearchResult.reloadData()
    }
    
    func endEditing() {
        searchBar.endEditing(true)
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func onError(err: BaseModelError) {
        AlertUtil.showStandardAlert(parentController: self, title: "Error", message: APIErrorGenerator().generateError(error: err))
    }
    
    func onTableViewReady(source: HomeTableViewSource?) {
        tableView.dataSource = source
        tableView.delegate = source
        tableView.reloadData()
        
        if refreshControl.isRefreshing{
            refreshControl.endRefreshing()
        }
    }
    
    func onTableViewReadySearch(source: SearchResultTableViewSource?) {
        tvSearchResult.dataSource = source
        tvSearchResult.delegate = source
        tvSearchResult.reloadData()
        
        viewSearchLoading.isHidden = true
        if tvSearchResult.numberOfRows(inSection: 0) == 0{
            viewSearchNoResult.isHidden = false
        }
        else{
            viewSearchNoResult.isHidden = true
        }
    }
    
    func prepareUI() {
        view.backgroundColor = UIColor(red: CGFloat(248/255.0), green: CGFloat(248/255.0), blue: CGFloat(248/255.0), alpha: 1.0)
        
        //MARK: searchBar init
        searchBar.searchBarStyle = .default
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.tintColor = .black
        searchBar.rx.searchButtonClicked.subscribe { [weak self] (_) in
            self?.searchBar.showsCancelButton = true
            self?.viewSearchResult.isHidden = false
            self?.viewSearchLoading.isHidden = false
            self?.presenter?.getSearchData(q: self?.searchBar.text ?? "")
            self?.searchBar.endEditing(true)
        }.disposed(by: _disposeBag)
        searchBar.rx.cancelButtonClicked.subscribe { [weak self] (_) in
            self?.searchBar.showsCancelButton = false
            self?.viewSearchResult.isHidden = true
            self?.tvSearchResult.dataSource = nil
            self?.tvSearchResult.delegate = nil
            self?.searchBar.endEditing(true)
            self?.searchBar.text = ""
        }.disposed(by: _disposeBag)
        navigationItem.titleView = searchBar
        
        //MARK: tableView init
        tableView.backgroundColor = .clear
        tableView.register(TitleTableViewCell.self, forCellReuseIdentifier: "TitleTableViewCell")
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeTableViewCell")
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.refreshControl = refreshControl
        
        //MARK: refreshcontrol init
        refreshControl.tintColor = .black
        refreshControl.rx.controlEvent(.valueChanged).subscribe { [weak self] (value) in
            self?.presenter?.refreshData()
        }.disposed(by: _disposeBag)
        
        //MARK: viewSearchResult init
        viewSearchResult.isHidden = true
        viewSearchResult.translatesAutoresizingMaskIntoConstraints = false
        viewSearchResult.backgroundColor = UIColor(red: CGFloat(248/255.0), green: CGFloat(248/255.0), blue: CGFloat(248/255.0), alpha: 1.0)
        
        //MARK: segmentedControlResult init
        segmentedControlResult.translatesAutoresizingMaskIntoConstraints = false
        segmentedControlResult.tintColor = .black
        segmentedControlResult.selectedSegmentIndex = 0
        segmentedControlResult.rx.controlEvent(.valueChanged).subscribe { [weak self] (value) in
            var selectedSegment = MediaType.movie
            switch self?.segmentedControlResult.selectedSegmentIndex {
            case 0:
                selectedSegment = MediaType.movie
            case 1:
                selectedSegment = MediaType.person
            case 2:
                selectedSegment = MediaType.tv
            default: break
            }
            self?.presenter?.onSearchSegmentChanged(segment: selectedSegment)
            self?.tvSearchResult.reloadData()
            
            if self?.tvSearchResult.numberOfRows(inSection: 0) == 0{
                self?.viewSearchNoResult.isHidden = false
            }
            else{
                self?.viewSearchNoResult.isHidden = true
            }
        }.disposed(by: _disposeBag)
        
        //MARK: tvSearchResult init
        tvSearchResult.backgroundColor = .clear
        tvSearchResult.register(SearchTableViewCell.self, forCellReuseIdentifier: "SearchTableViewCell")
        tvSearchResult.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        tvSearchResult.separatorStyle = .none
        tvSearchResult.translatesAutoresizingMaskIntoConstraints = false
        tvSearchResult.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        //MARK: viewSearchNoResult init
        viewSearchNoResult.translatesAutoresizingMaskIntoConstraints = false
        viewSearchNoResult.backgroundColor = UIColor(red: CGFloat(248/255.0), green: CGFloat(248/255.0), blue: CGFloat(248/255.0), alpha: 1.0)
        viewSearchNoResult.isHidden = true
        
        //MARK: viewSearchLoading init
        viewSearchLoading.translatesAutoresizingMaskIntoConstraints = false
        viewSearchLoading.backgroundColor = UIColor(red: CGFloat(248/255.0), green: CGFloat(248/255.0), blue: CGFloat(248/255.0), alpha: 1.0)
        viewSearchLoading.isHidden = true
        
        //MARK: activityIndicatorSearchLoading init
        activityIndicatorSearchLoading.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorSearchLoading.color = .black
        activityIndicatorSearchLoading.startAnimating()
        
        //MARK: lblSearchNoResult init
        lblSearchNoResult.translatesAutoresizingMaskIntoConstraints = false
        lblSearchNoResult.textColor = .black
        lblSearchNoResult.text = "No Result"
        lblSearchNoResult.font = UIFont.systemFont(ofSize: 23, weight: .semibold)
        
        view.addSubview(tableView)
        view.addSubview(viewSearchResult)
        viewSearchResult.addSubview(segmentedControlResult)
        viewSearchResult.addSubview(tvSearchResult)
        viewSearchResult.addSubview(viewSearchNoResult)
        viewSearchResult.addSubview(viewSearchLoading)
        viewSearchNoResult.addSubview(lblSearchNoResult)
        viewSearchLoading.addSubview(activityIndicatorSearchLoading)
        
        //MARK: set constraints
        NSLayoutConstraint.activate([
            tableView.leading.constraint(equalTo: view.leading),
            tableView.trailing.constraint(equalTo: view.trailing),
            tableView.top.constraint(equalTo: view.top),
            tableView.bottom.constraint(equalTo: view.bottomAnchor),
            viewSearchResult.leading.constraint(equalTo: view.leading),
            viewSearchResult.trailing.constraint(equalTo: view.trailing),
            viewSearchResult.top.constraint(equalTo: view.top),
            viewSearchResult.bottom.constraint(equalTo: view.bottomAnchor),
            segmentedControlResult.leading.constraint(equalTo: viewSearchResult.leading, constant: 20),
            segmentedControlResult.trailing.constraint(equalTo: viewSearchResult.trailing, constant: -20),
            segmentedControlResult.top.constraint(equalTo: viewSearchResult.top, constant: 20),
            segmentedControlResult.height.constraint(equalToConstant: 40),
            tvSearchResult.leading.constraint(equalTo: viewSearchResult.leading),
            tvSearchResult.trailing.constraint(equalTo: viewSearchResult.trailing),
            tvSearchResult.top.constraint(equalTo: viewSearchResult.top, constant: 70),
            tvSearchResult.bottom.constraint(equalTo: viewSearchResult.bottom),
            viewSearchLoading.leading.constraint(equalTo: viewSearchResult.leading),
            viewSearchLoading.trailing.constraint(equalTo: viewSearchResult.trailing),
            viewSearchLoading.top.constraint(equalTo: viewSearchResult.top),
            viewSearchLoading.bottom.constraint(equalTo: viewSearchResult.bottom),
            viewSearchNoResult.leading.constraint(equalTo: viewSearchResult.leading),
            viewSearchNoResult.trailing.constraint(equalTo: viewSearchResult.trailing),
            viewSearchNoResult.top.constraint(equalTo: segmentedControlResult.bottom, constant: 20),
            viewSearchNoResult.bottom.constraint(equalTo: viewSearchResult.bottom),
            activityIndicatorSearchLoading.centerX.constraint(equalTo: viewSearchLoading.centerX),
            activityIndicatorSearchLoading.centerY.constraint(equalTo: viewSearchLoading.centerY),
            lblSearchNoResult.centerX.constraint(equalTo: viewSearchNoResult.centerX),
            lblSearchNoResult.centerY.constraint(equalTo: viewSearchNoResult.centerY)
        ])
    }
}

extension HomeViewController: Viewable {}
