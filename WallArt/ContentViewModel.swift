//
//  ContentViewModel.swift
//  WallArt
//
//  Created by Janvi Arora on 06/06/24.
//

import Foundation
import Observation

enum FlowState {
    case idle
    case intro
    case projectileFlying
    case updateWallArt
}

@Observable
class ContentViewModel {
    var flowState = FlowState.idle

    
}
