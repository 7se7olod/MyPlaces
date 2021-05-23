//
//  RaintingControll.swift
//  MyPlaces
//
//  Created by Всеволод on 18.05.2021.
//

import UIKit

@IBDesignable class RatingControll: UIStackView {

    //MARK: Properties
    var rating = 0 {
        didSet {
            updateButtonSelectionState()
        }
    }
    private var ratingButtons = [UIButton]()
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons()
        }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
    }
    
    required init(coder: NSCoder) {
        super .init(coder: coder)
        setupButtons()
    }
    
    //MARK: Button pressed

    @objc func raitingButtonTaped(button: UIButton) {
        
        guard let index = ratingButtons.firstIndex(of: button) else { return }
        
        //Calculace the rating of the selected button
        let selectedRating = index + 1
        
        if selectedRating == rating {
            rating = 0
        } else {
            rating = selectedRating
        }
    }
    
    //MARK: Private Method
    
    private func setupButtons() {
        
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        //Load button image
        let bundle = Bundle(for: type(of: self))
        
        let filledStar = UIImage(named: "filledStar",
                                 in: bundle,
                                 compatibleWith: self.traitCollection)
        
        let emptyStar = UIImage(named: "emptyStar",
                                in: bundle,
                                compatibleWith: self.traitCollection)
        
        let highlightStar = UIImage(named: "highlightedStar",
                                    in: bundle,
                                    compatibleWith: self.traitCollection)
        
        
        for _ in 0..<starCount {
            
            //create the button
            let button = UIButton()
            
            //set the button image
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightStar, for: .highlighted)
            button.setImage(highlightStar, for: [.highlighted, .selected])

            
            // add constrains
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            //Setup the button action
            button.addTarget(self, action: #selector(raitingButtonTaped(button:)), for: .touchUpInside)
            
            // add the button to the stack
            addArrangedSubview(button)
            
            //add the new button on the rating button array
            ratingButtons.append(button)
        }
        
        updateButtonSelectionState()
    }
    
    private func updateButtonSelectionState() {
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
        }
    }
}
