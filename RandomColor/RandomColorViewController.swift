//
//  ViewController.swift
//  RandomColor
//
//  Created by Patrick Wiseman on 3/26/18.
//  Copyright © 2018 Patrick Wiseman. All rights reserved.
//

import UIKit

final class RandomColorViewController: UIViewController {
    let viewModel = RandomColorViewModel()
    
    @IBOutlet private weak var newColorButton: UIButton!
    @IBOutlet private weak var colorDescriptionLabel: UILabel!
    @IBOutlet private weak var colorView: UIView!
    
    // MARK: view lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        viewModel.inputs.viewDidLoad()
    }
    
    // MARK: bind view model
    
    private func bindViewModel() {
        viewModel.outputs.displayModelSignal.observeValues { [weak self] in
            self?.colorDescriptionLabel.text = $0.description
            self?.colorView.backgroundColor = $0.color
        }
    }
    
    // MARK: action
    
    @IBAction private func newColorButtonTapped(_ sender: UIButton) {
        viewModel.inputs.newColorButtonTapped()
    }
}


