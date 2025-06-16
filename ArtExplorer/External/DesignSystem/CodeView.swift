//
//  CodeView.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 11/06/25.
//

protocol CodeView {

    func setupSubviews()
    func setupConstraints()
    func setupAdditionalConfiguration()
    func setupCodeView()
}

extension CodeView {

    func setupCodeView() {
        setupSubviews()
        setupConstraints()
        setupAdditionalConfiguration()
    }
}
