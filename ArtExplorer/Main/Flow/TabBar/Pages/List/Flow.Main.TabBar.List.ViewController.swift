//
//  Flow.Main.TabBar.List.ViewController.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 11/06/25.
//

import Combine
import UIKit

extension Flow.Main.TabBar.List {

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
        private var dataSource: UICollectionViewDiffableDataSource<
            Model.Main.TabBar.List.ViewInformation.Section,
            Model.Main.TabBar.List.ViewInformation.Object
        >?
        private var objects = [Model.Main.TabBar.List.ViewInformation.Object]()

        // MARK: View Life Cycle
        override func loadView() {
            view = customView
        }

        override func viewDidLoad() {
            super.viewDidLoad()

            setupCancellable()
            viewModel.fetchInformation()

            setupDataSource()
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
            customView.collectionView.delegate = self
            customView.collectionView.register(Cell.self, forCellWithReuseIdentifier:Cell.reuseID)
        }

        private func setupDataSource() {
            dataSource = UICollectionViewDiffableDataSource<
                Model.Main.TabBar.List.ViewInformation.Section,
                Model.Main.TabBar.List.ViewInformation.Object
            >(collectionView: customView.collectionView) { collectionView, indexPath, object in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: Cell.reuseID,
                    for: indexPath
                ) as? Cell ?? Cell()

                cell.setup(with: object)
                return cell
            }
        }

        private func reloadData() {
            var snapshot = NSDiffableDataSourceSnapshot<
            Model.Main.TabBar.List.ViewInformation.Section,
            Model.Main.TabBar.List.ViewInformation.Object
            >()
            snapshot.appendSections([.main])
            snapshot.appendItems(objects)

            dataSource?.apply(snapshot, animatingDifferences: true)
        }

        private func createCollectionViewLayout() -> UICollectionViewLayout {
            let width = customView.bounds.width
            let padding = Spacing.md.rawValue
            let interItemSpacing = Spacing.xxxs.rawValue
            let availableWidth = width - (padding * 2) - (interItemSpacing * 2)
            let itemWidth = availableWidth / 3

            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
            flowLayout.minimumInteritemSpacing = interItemSpacing
            flowLayout.minimumLineSpacing = interItemSpacing
            flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)

            return flowLayout
        }

        private func checkIfCollectionViewNeedsMoreObjects() {
            if customView.collectionView.bounds.height > customView.collectionView.contentSize.height {
                viewModel.fetchMoreObjects()
            }
        }

        private func handleState(_ state: State) {
            switch state {
            case .initial: break
            case let .isLoading(state):
                customView.isLoading(state)
            case let .updateObjects(objects):
                self.objects.append(contentsOf: objects)
                reloadData()
                checkIfCollectionViewNeedsMoreObjects()
            }
        }
    }
}

extension Flow.Main.TabBar.List.ViewController: UICollectionViewDelegate {

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        if offsetY >= contentHeight - height {
            viewModel.fetchMoreObjects()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let object = objects[indexPath.item]
        viewModel.showObject(object)
    }
}
