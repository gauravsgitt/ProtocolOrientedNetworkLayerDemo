//
//  GalleryViewController.swift
//  NetworkLayerDemo
//
//  Created by Gaurav Bisht on 24/06/23.
//

import Foundation
import UIKit

//MARK: - View Controller setup
class GalleryViewController: UIViewController {
    
    struct Constants {
        static let cellheight: CGFloat = 100.0
    }

    @IBOutlet private weak var galleryTableView: UITableView!
    
    private var dataSource: Gallery?
    private var viewModel: GalleryViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        initialiseViewModel()
        getGalleryData()
    }
    
    private func setupTableView() {
        galleryTableView.delegate = self
        galleryTableView.dataSource = self
        galleryTableView.register(UINib(nibName: GalleryTableViewCell.identifierOrNibName, bundle: nil), forCellReuseIdentifier: GalleryTableViewCell.identifierOrNibName)
    }
    
    private func initialiseViewModel() {
        viewModel = GalleryViewModel(galleryAPIHandler: GalleryAPIHandler(), apiLoader: APILoader())
    }
}

//MARK: - UITableViewDataSource
extension GalleryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: GalleryTableViewCell.identifierOrNibName) as? GalleryTableViewCell,
           let dataSource = dataSource,
           indexPath.row < dataSource.count,
           let imageUrl = dataSource[indexPath.row].downloadURL {
            let title = dataSource[indexPath.row].author
            cell.configureCellWith(imageURLString: imageUrl, title: title ?? "\(indexPath.row)th row", row: indexPath.row + 1)
            return cell
        }
        return UITableViewCell()
    }
}

//MARK: - UITableViewDelegate
extension GalleryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.cellheight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let dataSource = dataSource, indexPath.row < dataSource.count {
            debugPrint("Clicked on \(dataSource[indexPath.row].author ?? "\(indexPath.row)th row")")
        }
    }
}

//MARK: - API Calls
extension GalleryViewController: Alert {
    private func getGalleryData() {
        guard let viewModel = viewModel else {return}
        viewModel.getGalleryList { (galleryModel, error) in
            guard error == nil else {
                DispatchQueue.main.async {
                    self.showAlertWithTryAgainButton(message: error?.message ?? SOME_ERROR_OCCURRED) {
                        self.getGalleryData()
                    }
                }
                return
            }
            
            guard let galleryModel = galleryModel else {
                DispatchQueue.main.async {
                    self.showAlertWithTryAgainButton(message: error?.message ?? SOME_ERROR_OCCURRED) {
                        self.getGalleryData()
                    }
                }
                return
            }
            
            self.dataSource = galleryModel
            DispatchQueue.main.async {
                self.galleryTableView.reloadData()
            }
        }
    }
}
