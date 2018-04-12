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

private extension CGFloat {
    static var random: CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

struct RandomColorDisplayModel {
    let description: String
    let color: UIColor

    init() {
        let red =  CGFloat.random
        let green =  CGFloat.random
        let blue =  CGFloat.random

        color = UIColor(red: red, green: green, blue: blue, alpha: 1)
        description = "red: \(red), green: \(green), blue: \(blue)"
    }
}

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
