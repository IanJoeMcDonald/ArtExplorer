//
//  Font.swift
//  ArtExplorer
//
//  Created by Ian McDonald on 11/06/25.
//

import UIKit

enum FontStyle {

    case heading(Heading)
    case body(Body)
    case action(Action)
    case caption(Caption)

    public var font: UIFont {
        switch self {
        case let .heading(size): size.font
        case let .body(size): size.font
        case let .action(size): size.font
        case let .caption(size): size.font
        }
    }
}

extension FontStyle {

    enum Heading: CaseIterable {

        case xl
        case lg
        case md
        case sm
        case xs

        var font: UIFont {
            switch self {
            case .xl: UIFont.systemFont(ofSize: 24, weight: .black)
            case .lg: UIFont.systemFont(ofSize: 18, weight: .black)
            case .md: UIFont.systemFont(ofSize: 16, weight: .black)
            case .sm: UIFont.systemFont(ofSize: 14, weight: .black)
            case .xs: UIFont.systemFont(ofSize: 12, weight: .bold)
            }
        }
    }
}

extension FontStyle {

    enum Body: CaseIterable {

        case xl
        case lg
        case md
        case sm
        case xs

        var font: UIFont {
            switch self {
            case .xl: UIFont.systemFont(ofSize: 18, weight: .regular)
            case .lg: UIFont.systemFont(ofSize: 16, weight: .regular)
            case .md: UIFont.systemFont(ofSize: 14, weight: .regular)
            case .sm: UIFont.systemFont(ofSize: 12, weight: .regular)
            case .xs: UIFont.systemFont(ofSize: 10, weight: .regular)
            }
        }
    }
}

extension FontStyle {

    enum Action: CaseIterable {

        case lg
        case md
        case sm

        var font: UIFont {
            switch self {
            case .lg: UIFont.systemFont(ofSize: 14, weight: .semibold)
            case .md: UIFont.systemFont(ofSize: 12, weight: .semibold)
            case .sm: UIFont.systemFont(ofSize: 10, weight: .semibold)
            }
        }
    }
}

extension FontStyle {

    enum Caption: CaseIterable {

        case md

        var font: UIFont {
            switch self {
            case .md: UIFont.systemFont(ofSize: 10, weight: .semibold)
            }
        }
    }
}
