//
//  AddEventViewModel.swift
//  Wen
//
//  Created by Vincent Grossier on 25/06/2022.
//

import Foundation

final class AddEventViewModel {
    
    var coordinator: AddEventCoordinator?
    
    func viewDidDisappear() {
        coordinator?.didFinishAddEvent()
    }
}
