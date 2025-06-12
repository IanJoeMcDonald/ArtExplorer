//
//  Flow.Main.TabBar.List.ViewController.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 11/06/25.
//

import UIKit

extension Flow.Main.TabBar.List {

    class ViewController: UIViewController {

        // MARK: Initializers
        init(viewModel: ViewModel) {
            self.viewModel = viewModel

            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

        // MARK: Properties
        private let customView = View()
        private let viewModel: ViewModel

        // MARK: View Life Cycle
        override func loadView() {
            view = customView
        }
    }
}
