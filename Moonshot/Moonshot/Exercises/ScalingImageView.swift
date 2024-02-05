//
//  ScalingImageView.swift
//  Moonshot
//
//  Created by Anna Olak on 21/01/2024.
//

import SwiftUI

struct ScalingImageView: View {
    var body: some View {
        Image(.portugal)
            .resizable()
            .scaledToFit()
            .containerRelativeFrame(.horizontal) { size, axis in
                size * 0.8
            }
    }
}

#Preview {
    ScalingImageView()
}
