//
//  ViewController.swift
//  XebiaAssignment
//
//  Created by Siva Cherukuri on 31/03/19.
//  Copyright © 2019 xebia. All rights reserved.
//

import UIKit

final public class HomeViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    public var viewModel: HomeViewModelProtocol!
    fileprivate var refreshControl: UIRefreshControl!

    override public func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupViews()
        setupViewModel()
    }

}

// MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.contentViewModels.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(type: ContentCollectionViewCell.self, for: indexPath)
        if let content = viewModel.contentViewModel(at: indexPath.item) {
            cell.set(viewModel: content)
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: 500)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height) {
            viewModel.loadMore()
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let content = viewModel.contentViewModel(at: indexPath.item) {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Home", bundle:nil)
            let articleDetailViewController = storyBoard.instantiateViewController(withIdentifier: "ArticleDetailViewController") as! ArticleDetailViewController
            self.navigationController?.pushViewController(articleDetailViewController, animated:true)
            articleDetailViewController.urlString = content.id
        }
    }
}

// MARK: - Users Interactions

extension HomeViewController {
    @objc func refreshControlValueChanged() {
        viewModel.refresh()
    }
}

// MARK: - Privates

extension HomeViewController {
    fileprivate func setupViews() {
        title = NSLocalizedString("The New York Times", comment: "")
        
        collectionView.register(type: ContentCollectionViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        refreshControl = UIRefreshControl(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        refreshControl.addTarget(self, action: #selector(refreshControlValueChanged), for: .valueChanged)
        collectionView.addSubview(refreshControl)
    }
    
    fileprivate func setupViewModel() {
        viewModel.onReloadData = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.refreshControl.endRefreshing()
            strongSelf.loadingView.stopAnimating()
            strongSelf.collectionView.reloadData()
        }
        viewModel.onMoreData = { [weak self] contents in
            guard let strongSelf = self else { return }
            strongSelf.collectionView.performBatchUpdates({
                for content in contents {
                    strongSelf.viewModel.append(contentViewModel: content)
                    let indexPath = IndexPath(item: strongSelf.viewModel.contentViewModels.count - 1, section: 0)
                    strongSelf.collectionView.insertItems(at: [indexPath])
                }
            })
        }
        viewModel.onError = { [weak self] errorMessage in
            guard let strongSelf = self else { return }
            let alertController = UIAlertController(title: NSLocalizedString("Error", comment: ""), message: errorMessage, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            strongSelf.present(alertController, animated: true, completion: nil)
        }
        viewModel.refresh()
    }
}

extension Constant {
    struct HomeViewController {
        
    }
}
