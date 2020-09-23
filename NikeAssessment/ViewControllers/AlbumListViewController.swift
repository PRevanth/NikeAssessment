//
//  AlbumListViewController.swift
//  NikeAssessment
//
//  Created by Pendyala Revanth on 9/22/20.
//

import UIKit

class AlbumListViewController: UIViewController {
    
    private var tableView: UITableView?
    private let viewModel = AlbumListViewModel()
    private let spinnerView = SpinnerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .white
        title = NavigationTitleConstants.albumList
    }
    
    private func setupUI() {
        spinnerView.setup(view: view)
        spinnerView.startAnimating()
        tableViewSetup()
    }
    
    private func tableViewSetup() {
        let tableView = UITableView()
        self.tableView = tableView
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        view.addSubview(tableView)
        self.tableView?.translatesAutoresizingMaskIntoConstraints = false
        self.tableView?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.tableView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.tableView?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.tableView?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        registerCell()
    }
    
    private func registerCell() {
        self.tableView?.register(AlbumTableViewCell.self, forCellReuseIdentifier: CellIdentifierConstants.albumCell)
    }
    
    private func loadData() {
        self.tableView?.isHidden = true
        viewModel.fetchAlbums()
        viewModel.shouldReload = { [weak self] in
            DispatchQueue.main.async {
                self?.spinnerView.stopAnimating()
                self?.tableView?.isHidden = false
                self?.tableView?.reloadData()
            }
        }
        viewModel.displayError = { [weak self] in
            DispatchQueue.main.async {
                self?.spinnerView.stopAnimating()
                self?.errorView()
            }
            
        }
    }
    
    private func errorView() {
        let errorLabel = UILabel()
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.textAlignment = .center
        errorLabel.text = NetworkErrorConstants.unableToLoad
        
        self.view.addSubview(errorLabel)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
}

extension AlbumListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let albumResult = viewModel.dataForRow(at: indexPath.row),
              let albumCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifierConstants.albumCell, for: indexPath) as? AlbumTableViewCell else {
            return UITableViewCell()
        }
        albumCell.setData(for: albumResult)
        return albumCell
    }
}

extension AlbumListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let albumController = AlbumDetailViewController()
        albumController.viewModel.eachAlbum = viewModel.dataForRow(at: indexPath.row)
        self.navigationController?.pushViewController(albumController, animated: true)
    }
}

