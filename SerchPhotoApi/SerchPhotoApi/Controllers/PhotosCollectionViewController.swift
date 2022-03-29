//
//  PhotosCollectionViewController.swift
//  SerchPhotoApi
//
//  Created by Igor on 28.03.2022.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {
    
    private let itemsPerRow: CGFloat = 2
    private let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    private var selectedImages = [UIImage]()
    
    private lazy var addBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarbuttonTapped))
    }()
    
    private lazy var actiondBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(actiondBarButtonTapped))
    }()
    
    private var numberOfSelectedPhotos: Int {
        return collectionView.indexPathsForSelectedItems?.count ?? 0
    }
    
    var networkDataFetcher = NetworkDataFetcher()
    
    private var timer: Timer?
    
    private var photos = [UnsplashPhoto]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateNavButtonsState()
        collectionView.backgroundColor = .white
        setupNavigationBar()
        setupCollectionView()
        setupSearchBar()
    }
    
    func refresh() {
        self.selectedImages.removeAll()
        self.collectionView.selectItem(at: nil, animated: true, scrollPosition: [])
        updateNavButtonsState()
    }
    
    func updateNavButtonsState() {
        addBarButtonItem.isEnabled = numberOfSelectedPhotos > 0
        actiondBarButtonItem.isEnabled = numberOfSelectedPhotos > 0

    }
    
    // MARK: - Navigation Actions
    @objc private func addBarbuttonTapped() {
        print(#function)
    }
    
    @objc private func actiondBarButtonTapped(sender: UIBarButtonItem) {
        print(#function)
        
        let shareController = UIActivityViewController(activityItems: selectedImages, applicationActivities: nil)
        
        shareController.completionWithItemsHandler = { _, bool, _, _ in
            if bool {
                self.refresh()
            }
        }
        
        // для ipad 2 lines
        shareController.popoverPresentationController?.barButtonItem = sender
        shareController.popoverPresentationController?.permittedArrowDirections = .any
        
        present(shareController, animated: true)
    }
    
    // MARK: - Setup UI Elements
    
    private func setupCollectionView() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CellId")
        collectionView.register(PhotosCell.self, forCellWithReuseIdentifier: PhotosCell.reuseId)
        
        collectionView.allowsMultipleSelection = true
        
        // flowLayout
        collectionView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.contentInsetAdjustmentBehavior = .automatic
    }
    
    private func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = "Photos"
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleLabel.textColor = UIColor(red: 0.502, green: 0.498, blue: 0.498, alpha: 1)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
        
        navigationItem.rightBarButtonItems = [actiondBarButtonItem, addBarButtonItem]
    }
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        // настройка серча
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.sizeToFit()
        searchController.obscuresBackgroundDuringPresentation = false
        
        // дерелат реализовает селф
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
    
        // серч скрыт по умолчанию
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    // MARK: - UICollectionViewDataSource, UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCell.reuseId, for: indexPath) as! PhotosCell
        let unsplashPhoto = photos[indexPath.row]
        cell.unsplashPhoto = unsplashPhoto
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PhotosCell
        guard let image = cell.photoImageView.image else { return }
        selectedImages.append(image)
        updateNavButtonsState()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PhotosCell
        guard let image = cell.photoImageView.image else { return }
        if let index = selectedImages.firstIndex(of: image) {
            selectedImages.remove(at: index)
        }
        updateNavButtonsState()
    }
}

// MARK: - UISearchBarDelegate

extension PhotosCollectionViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [self] _ in
            networkDataFetcher.fetchImages(searchTerm: searchText) { [weak self] searchResults in
                guard let fetchedPhotos = searchResults else { return }
                
                self?.photos = fetchedPhotos.results
                self?.collectionView.reloadData()
                self?.refresh()
            }
        })
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PhotosCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let photo = photos[indexPath.item]
        let paddingSpace = sectionInserts.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        let height = CGFloat(photo.height) * widthPerItem / CGFloat(photo.width)
        return CGSize(width: widthPerItem, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
}
