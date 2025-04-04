//
//  FollowerListVC.swift
//  GHBook
//
//  Created by Basem Elkady on 4/2/25.
//

import UIKit

class FollowerListVC: UIViewController {
    
    enum section {
        case main
    }

    var username: String!
    var followers: [Follower] = []
    var page = 1
    var hasMoreFollowers = true
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource <section, Follower>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureViewController()
        getFollowers(username: username, page: page)
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = false
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    

    
    
    func getFollowers(username: String, page: Int){
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success(let followers):
                guard let followers = followers else {
                                self.presentGFAlertOnMainThread(title: "Error", message: "Invalid data received.", buttonTitle: "OK")
                                return
                            }
                if followers.count < 100 { self.hasMoreFollowers = false}
                self.followers.append(contentsOf: followers)
                self.updateData()
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad stuff", message: error.rawValue, buttonTitle: "OK")
                return
            }
        }
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource <section, Follower> (collectionView: collectionView, cellProvider: { collectionView, indexPath, follwoer in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follwoer)
            return cell
        })
    }
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}
extension FollowerListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offSetY = scrollView.contentOffset.y // The vertical distance the user has scrolled from the top of the content area
        let contentHeight = scrollView.contentSize.height // The total height of all the content within the scrollView
        let height = scrollView.frame.size.height // The height of the visible area of the scrollView (what you can see on the screen)
        
        if offSetY + height >= contentHeight {
            page += 1
            getFollowers(username: username, page: page )
        }
    }
    
}
