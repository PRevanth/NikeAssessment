//
//  AlbumDetailViewController.swift
//  NikeAssessment
//
//  Created by Pendyala Revanth on 9/22/20.
//

import UIKit

class AlbumDetailViewController: UIViewController {
    private var albumLabel: UILabel?
    private var artistLabel: UILabel?
    private var genresLabel: UILabel?
    private var releaseDate: UILabel?
    private var copyrightLabel: UILabel?
    private var albumImage: UIImageView?
    private var iTunesButton: UIButton?

    let viewModel = AlbumDetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = NavigationTitleConstants.albumDetails
        setupUI()
        setupData()
    }

    private func setupUI() {
        self.view.backgroundColor = .white

        let imageView = UIImageView()
        albumImage = imageView
        view.addSubview(imageView)
        albumImage?.translatesAutoresizingMaskIntoConstraints = false
        albumImage?.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        albumImage?.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        albumImage?.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        albumImage?.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true

        let albumLabel = UILabel()
        albumLabel.font = FontConstants.helvetBold.font
        self.albumLabel = albumLabel

        let artistLabel = UILabel()
        artistLabel.font = FontConstants.helvetLight.font(with: FontSize.fontSize_16)
        self.artistLabel = artistLabel

        let genres = UILabel()
        genres.font = FontConstants.helvetLight.font
        self.genresLabel = genres

        let releaseDate = UILabel()
        releaseDate.font = FontConstants.helvetLight.font
        self.releaseDate = releaseDate

        let copyright = UILabel()
        copyright.font = FontConstants.helvetLight.font
        copyright.numberOfLines = 0
        self.copyrightLabel = copyright

        // StackView setup
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 5

        stackView.insertArrangedSubview(albumLabel, at: 0)
        stackView.insertArrangedSubview(artistLabel, at: 1)
        stackView.insertArrangedSubview(genres, at: 2)
        stackView.insertArrangedSubview(releaseDate, at: 3)
        stackView.insertArrangedSubview(copyright, at: 4)
        view.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true

        // Button setup
        let button = UIButton()
        iTunesButton = button
        view.addSubview(button)
        iTunesButton?.translatesAutoresizingMaskIntoConstraints = false
        iTunesButton?.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        iTunesButton?.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        iTunesButton?.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        iTunesButton?.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }

    private func setupData() {
        imageDownload(with: viewModel.eachAlbum?.artworkUrl100 ?? EMPTY_STRING)
        albumLabel?.text = viewModel.eachAlbum?.name
        artistLabel?.text = String(format: AppConstants.artistName, viewModel.eachAlbum?.artistName ?? NOT_AVAILABLE)
        genresLabel?.text = String(format: AppConstants.genres, viewModel.eachAlbum?.genres.compactMap{ $0.name }.joined(separator: SEPARATOR) ?? NOT_AVAILABLE)
        releaseDate?.text = String(format: AppConstants.releaseDate, viewModel.eachAlbum?.releaseDate ?? NOT_AVAILABLE)
        copyrightLabel?.text = String(format: AppConstants.copyright, viewModel.eachAlbum?.copyright ?? NOT_AVAILABLE)

        iTunesButton?.setTitle(AppConstants.iTunesButtonTitle, for: .normal)
        iTunesButton?.setTitleColor(.black, for: .normal)
        iTunesButton?.layer.cornerRadius = 18
        iTunesButton?.layer.borderColor = UIColor.black.cgColor
        iTunesButton?.layer.borderWidth = 1
        iTunesButton?.addTarget(self, action: #selector(iTunesButtonClinked(_:)), for: .touchUpInside)
    }
    
    private func imageDownload(with urlString: String) {
        viewModel.downloadImage(with: urlString) { (result) in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.albumImage?.image = image
                }
            case .failure(let error):
                print(String(format: NetworkErrorConstants.failedToDownloadimage, urlString, error.localizedDescription))
            }
        }
    }

    @objc private func iTunesButtonClinked(_ sender: UIButton) {
        guard let urlString = viewModel.eachAlbum?.url,
              let unwrappedURL = URL(string: urlString) else {
            // Need to handle error when there is no proper URL.
            return
        }
        let viewController = WebViewController(url: unwrappedURL)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
