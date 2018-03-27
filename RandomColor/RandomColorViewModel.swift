//
//  RandomColorViewModel.swift
//  RandomColor
//
//  Created by Patrick Wiseman on 3/26/18.
//  Copyright © 2018 Patrick Wiseman. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

protocol RandomColorViewModelInputs {
    func viewDidLoad()
    func newColorButtonTapped()
}

protocol RandomColorViewModelOutputs {
    var displayModelSignal: Signal<RandomColorDisplayModel, NoError> { get }
}

protocol RandomColorViewModelType {
    var inputs: RandomColorViewModelInputs { get }
    var outputs: RandomColorViewModelOutputs { get }
}

final class RandomColorViewModel: RandomColorViewModelInputs,
RandomColorViewModelOutputs, RandomColorViewModelType {
    
    // MARK: type
    
    var inputs: RandomColorViewModelInputs { return self }
    var outputs: RandomColorViewModelOutputs { return self }
    
    // MARK: outputs
    
    var displayModelSignal: Signal<RandomColorDisplayModel, NoError> {
        return Signal.merge(
            viewDidLoadIO.output,
            newColorButtonTappedIO.output
            ).map { RandomColorDisplayModel() }
    }
    
    // MARK: inputs
    
    private let viewDidLoadIO = Signal<Void, NoError>.pipe()
    func viewDidLoad() {
        viewDidLoadIO.input.send(value: ())
    }
    
    private let newColorButtonTappedIO = Signal<Void, NoError>.pipe()
    func newColorButtonTapped() {
        newColorButtonTappedIO.input.send(value: ())
    }
}
