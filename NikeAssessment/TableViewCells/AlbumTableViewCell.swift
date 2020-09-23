//
//  AlbumTableViewCell.swift
//  NikeAssessment
//
//  Created by Pendyala Revanth on 9/22/20.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    private var downloadTask: URLSessionDataTask?
    private var albumLabel: UILabel?
    private var artistLabel: UILabel?
    private var thumbnailImage: UIImageView?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        if downloadTask != nil {
            downloadTask?.cancel()
            downloadTask = nil
        }
        self.thumbnailImage?.image = nil
    }

    private func setupUI() {
        // Image setup
        let imageView = UIImageView()
        self.thumbnailImage = imageView
        self.contentView.addSubview(imageView)
        self.thumbnailImage?.translatesAutoresizingMaskIntoConstraints = false
        self.thumbnailImage?.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        self.thumbnailImage?.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        self.thumbnailImage?.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        self.thumbnailImage?.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.thumbnailImage?.widthAnchor.constraint(equalToConstant: 50).isActive = true

        // StackView Setup
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 5

        let albumName = UILabel()
        albumName.font = FontConstants.helvetMedium.font
        self.albumLabel = albumName

        let artistName = UILabel()
        artistName.font = FontConstants.helvetLight.font
        self.artistLabel = artistName

        stackView.insertArrangedSubview(albumName, at: 0)
        stackView.insertArrangedSubview(artistName, at: 1)
        self.contentView.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        stackView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
    }

    func setData(for albumResult: Results) {
        albumLabel?.text = albumResult.name
        artistLabel?.text = albumResult.artistName
        downloadImage(in: albumResult.artworkUrl100)
    }

    private func downloadImage(in urlString: String) {
        downloadTask = Network().downloadTask(urlString: urlString, { (result) in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.thumbnailImage?.image = image
                }
            case .failure(let error):
                print(String(format: NetworkErrorConstants.failedToDownloadimage, urlString, error.localizedDescription))
            }
        })
    }
}
