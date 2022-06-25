//
//  EventListViewModel.swift
//  Wen
//
//  Created by Vincent Grossier on 25/06/2022.
//

import Foundation

final class EventListViewModel {
    
    let title = "Events"
    var coordinator: EventListCoordinator?
    
    func tappedAddEvent() {
        coordinator?.startAddEvent()
    }
}
