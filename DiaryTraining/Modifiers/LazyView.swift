//
//  LazyView.swift
//  DiaryTraining
//
//  Created by Ilya Nechoysa on 26.07.2021.
//

import SwiftUI

public struct LazyView<Content: View> : View {
    private let build: () -> Content
    public init(_ build: @autoclosure @escaping () -> Content ) {
        self.build = build
    }

    public var body : Content {
        build()
    }
}
