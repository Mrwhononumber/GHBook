//
//  FollowerListVC.swift
//  GHBook
//
//  Created by Basem Elkady on 4/2/25.
//

import UIKit

/// Displays a paginated and searchable list of followers for a given GitHub username
class FollowerListVC: UIViewController {
    
    
    // MARK: - Section Enum
    
    
    enum Section {
        case main
    }

    
    // MARK: - Properties
    
    
    var username: String!
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var page = 1
    var hasMoreFollowers = true
    var isSearching = false
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource <Section, Follower>!

    
    // MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureViewController()
        configureSearchController()
        getFollowers(username: username, page: page)
        configureDataSource()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = false
    }
    
    
    // MARK: - Configuration
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
 
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    
    func configureSearchController(){
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
        
        
        searchController.searchBar.placeholder = "Search for a user"
        navigationItem.searchController = searchController
    }
    
    
    // MARK: - Networking & Data
    
    /// Fetches followers for a given username and appends them to the current list
    func getFollowers(username: String, page: Int){
        showLoadingView()
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else {return}
            self.dismissLoadingView()
            
            switch result {
            case .success(let followers):
                guard let followers = followers else {
                                self.presentGFAlertOnMainThread(title: "Error", message: "Invalid data received.", buttonTitle: "OK")
                                return
                            }
                if followers.count < 100 { self.hasMoreFollowers = false}
                self.followers.append(contentsOf: followers)
                if followers.isEmpty && page == 1 {
                    let message = " This user has no followers 😢"
                  DispatchQueue.main.async {self.showEmptyStateView(with: message, in: self.view)}
                  
                    return
                }
                self.updateData(on: self.followers)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad stuff", message: error.rawValue, buttonTitle: "OK")
                return
            }
        }
    }
    
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource <Section, Follower> (collectionView: collectionView, cellProvider: { collectionView, indexPath, follwoer in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follwoer)
            return cell
        })
    }
    
    /// Applies the updated follower list to the collection view using diffable data source
    func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    
    //MARK: - Action
    
    /// Fetches user info and adds them to favorites when the "+" button is tapped
    @objc func addButtonTapped () {
        showLoadingView()
        
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let user):
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                
                PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
                    guard let self = self else { return }
                    guard let error = error else {
                        self.presentGFAlertOnMainThread(title: "Success! ", message: "saved to favorites successfully!", buttonTitle: "Ok")
                        return
                    }
                    self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    //MARK: - Scroll Pagination Logic

    /// Returns true if the user has scrolled to the bottom and more data is available
    private func shouldFetchMoreFollowers(from scrollView: UIScrollView) -> Bool {
        let offsetY = scrollView.contentOffset.y // The vertical distance the user has scrolled from the top of the content area
        let contentHeight = scrollView.contentSize.height // The total height of all the content within the scrollView
        let visibleHeight = scrollView.frame.size.height // The height of the visible area of the scrollView (what you can see on the screen)
        
        let isScrolledToBottom = offsetY + visibleHeight >= contentHeight
        
        return isScrolledToBottom && hasMoreFollowers
    }
}


//MARK: - CollectionView Delegate


extension FollowerListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if shouldFetchMoreFollowers(from: scrollView) {
            page += 1
            getFollowers(username: username, page: page )
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredFollowers : followers
        let follower = activeArray[indexPath.item]

        let destinationVC = UserInfoVC()
        destinationVC.username = follower.login
        destinationVC.delegate = self
        let navigationController = UINavigationController(rootViewController: destinationVC)
        present(navigationController, animated: true )
    }
}


//MARK: - SearchBar & SearchResultsUpdating Delegate


extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearching = true
        filteredFollowers = followers.filter {$0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredFollowers)
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(on: self.followers)
    }
}


//MARK: - UserInfoVC Delegate


extension FollowerListVC: UserInfoVCDelegate {
 
    /// Reloads the follower list when a new username is passed from UserInfoVC
    func didRequestFollowers(for user: User) {
        let username = user.login
        self.username = username
        self.title = username
        page = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        updateData(on: followers)
        getFollowers(username: username, page: page )
    }
}
