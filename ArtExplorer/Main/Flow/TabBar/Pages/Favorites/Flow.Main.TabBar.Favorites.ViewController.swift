//
//  Flow.Main.TabBar.Favorites.ViewController.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 11/06/25.
//

import Combine
import UIKit

extension Flow.Main.TabBar.Favorites {

    class ViewController: UIViewController {

        // MARK: Initializers
        init(viewModel: ViewModel) {
            self.viewModel = viewModel

            super.init(nibName: nil, bundle: nil)
        }

        @available(*, unavailable)
        required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

        // MARK: Properties
        private let customView = View()
        private let viewModel: ViewModel
        private var cancellable: AnyCancellable?
        private var collectionViewState = Model.Main.TabBar.Favorites.ViewInformation.CollectionViewState.isEmpty

        // MARK: View Life Cycle
        override func loadView() {
            view = customView
        }

        override func viewDidLoad() {
            super.viewDidLoad()
            setupCancellable()
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            viewModel.fetchInformation()
        }

        override func viewIsAppearing(_ animated: Bool) {
            super.viewIsAppearing(animated)
            setupCollectionView()
        }

        // MARK: Private Custom Methods
        private func setupCancellable() {
            cancellable = viewModel.$state.sink { [weak self] state in self?.handleState(state) }
        }

        private func setupCollectionView() {
            customView.collectionView.collectionViewLayout = createCollectionViewLayout()
            customView.collectionView.dataSource = self
            customView.collectionView.delegate = self
            customView.collectionView.register(LoadingCell.self, forCellWithReuseIdentifier: LoadingCell.reuseID)
            customView.collectionView.register(FavoriteCell.self, forCellWithReuseIdentifier: FavoriteCell.reuseID)
        }

        private func createCollectionViewLayout() -> UICollectionViewLayout {
            let width = customView.bounds.width
            let padding = Spacing.md.rawValue
            let interItemSpacing = Spacing.sm.rawValue
            let availableWidth = width - (padding * 2) - interItemSpacing
            let itemWidth = availableWidth / 2

            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
            flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.2)

            return flowLayout
        }

        private func handleState(_ state: State) {
            switch state {
            case .initial: break
            case let .updateCollectionViewState(to: state):
                collectionViewState = state
                customView.emptyViewIsHidden(state != .isEmpty)
                customView.collectionView.reloadData()
            }
        }
    }
}

extension Flow.Main.TabBar.Favorites.ViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionViewState {
        case .isEmpty: 0
        case .isLoading: 10
        case let .setup(objects): objects.count
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch collectionViewState {
        case .isEmpty:
            return collectionView.dequeueReusableCell(
                withReuseIdentifier: Flow.Main.TabBar.Favorites.LoadingCell.reuseID,
                for: indexPath
            )
        case .isLoading:
            return collectionView.dequeueReusableCell(
                withReuseIdentifier: Flow.Main.TabBar.Favorites.LoadingCell.reuseID,
                for: indexPath
            )
        case let .setup(with: objects):
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Flow.Main.TabBar.Favorites.FavoriteCell.reuseID,
                for: indexPath
            ) as! Flow.Main.TabBar.Favorites.FavoriteCell


            cell.setup(with: objects[indexPath.item])

            return cell
        }
    }
}

extension Flow.Main.TabBar.Favorites.ViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard case let .setup(objects) = collectionViewState else { return }
        let object = objects[indexPath.item]
        viewModel.showObject(object)
    }
}
