import UIKit

class FilterView: UIView {
    
    private let applyButton = UIButton(type: .system)
    private let cancelButton = UIButton(type: .system)
    private var buttons: [UIButton] = []
    let noOfOptionsInRow: Int = 3
    
    var selectedFilters: Set<FilterOption> = []
    
    // Closure to handle the apply action
    var onApplyFilters: ((Set<FilterOption>) -> Void)?
    var onCancelFilters: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        
        DispatchQueue.main.async {
            self.backgroundColor = .white
            self.layer.cornerRadius = LayoutConstants.defaultCornerRadius
            self.clipsToBounds = true

            // Create an array of button titles
            let buttonTitles = [
                "Active Coins", "Inactive Coins", "Only Coins",
                "Only Tokens", "New Coins"
            ]

            // Create the buttons dynamically and add them to the array
            for title in buttonTitles {
                let buttonHeight = 30
                let button = UIButton(type: .system)
                button.setTitle(title, for: .normal)
                button.heightAnchor.constraint(equalToConstant: CGFloat(buttonHeight)).isActive = true
                button.layer.cornerRadius = CGFloat(buttonHeight/2)
                button.layer.borderWidth = 1
                button.layer.borderColor = UIColor.systemBlue.cgColor
                button.addTarget(self, action: #selector(self.toggleFilterSelection(_:)), for: .touchUpInside)
                button.titleLabel?.font = UIFont.systemFont(ofSize: LayoutConstants.samllFontSize) // Set font size to 18
                self.buttons.append(button)
            }

            // Style Apply and Cancel buttons
            self.applyButton.setTitle("Apply", for: .normal)
            self.applyButton.addTarget(self, action: #selector(self.applyFilters), for: .touchUpInside)
            self.applyButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: LayoutConstants.defaultFontSize) // Set font size to 18
            self.applyButton.layer.cornerRadius = LayoutConstants.buttonHeight / 2
            self.applyButton.backgroundColor = .systemBlue
            self.applyButton.setTitleColor(.white, for: .normal)
            self.applyButton.heightAnchor.constraint(equalToConstant: LayoutConstants.buttonHeight).isActive = true

            self.cancelButton.setTitle("Cancel", for: .normal)
            self.cancelButton.addTarget(self, action: #selector(self.cancelFilter), for: .touchUpInside)
            self.cancelButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: LayoutConstants.defaultFontSize) // Set font size to 18
            self.cancelButton.layer.cornerRadius = LayoutConstants.buttonHeight / 2
            self.cancelButton.backgroundColor = .systemGray
            self.cancelButton.setTitleColor(.white, for: .normal)
            self.cancelButton.heightAnchor.constraint(equalToConstant: LayoutConstants.buttonHeight).isActive = true

            // Main vertical stack view
            let mainStackView = UIStackView()
            mainStackView.axis = .vertical
            mainStackView.spacing = Spacing.defaultVerticalSpacing
            mainStackView.alignment = .fill
            mainStackView.translatesAutoresizingMaskIntoConstraints = false

            // Add buttons to horizontal stack views (3 per row)
            var rowStackViews: [UIStackView] = []
            var rowButtons: [UIButton] = []

            for (index, button) in self.buttons.enumerated() {
                rowButtons.append(button)

                // If we have 3 buttons in a row, create a stack view for that row
                if rowButtons.count == self.noOfOptionsInRow || index == self.buttons.count - 1 {
                    let rowStackView = UIStackView(arrangedSubviews: rowButtons)
                    rowStackView.axis = .horizontal
                    rowStackView.spacing = Spacing.smallHorizontalSpacing
                    rowStackView.alignment = .center
                    rowStackView.distribution = .fillEqually
                    rowStackView.translatesAutoresizingMaskIntoConstraints = false
                    rowStackViews.append(rowStackView)
                    rowButtons = [] // Reset row buttons
                }
            }

            // Add all row stack views to the main stack view
            for rowStackView in rowStackViews {
                mainStackView.addArrangedSubview(rowStackView)
            }

            // Create a horizontal stack view for Apply and Cancel buttons
            let actionButtonStackView = UIStackView(arrangedSubviews: [self.cancelButton, self.applyButton])
            actionButtonStackView.axis = .horizontal
            actionButtonStackView.spacing = Spacing.smallHorizontalSpacing
            actionButtonStackView.alignment = .fill
            actionButtonStackView.distribution = .fillEqually
            actionButtonStackView.translatesAutoresizingMaskIntoConstraints = false

            // Add the action button stack view to the main stack view
            mainStackView.addArrangedSubview(actionButtonStackView)

            // Add the main stack view to the view
            self.addSubview(mainStackView)

            // Set constraints for the main stack view
            NSLayoutConstraint.activate([
                mainStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: LayoutConstants.defaultMargin),
                mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: LayoutConstants.defaultMargin),
                mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -LayoutConstants.defaultMargin),
                mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -LayoutConstants.largeMargin)
            ])
        }
    }
    
    func updateButtonStates() {
        for button in buttons {
            guard let title = button.title(for: .normal),
                  let option = FilterOption(rawValue: title) else { continue }
            
            if selectedFilters.contains(option) {
                button.backgroundColor = .systemBlue
                button.setTitleColor(.white, for: .normal)
            } else {
                button.backgroundColor = .white
                button.setTitleColor(.systemBlue, for: .normal)
            }
        }
    }

    
    @objc private func toggleFilterSelection(_ sender: UIButton) {
        guard let tagValue = sender.title(for: .normal), let option = FilterOption(rawValue: tagValue) else { return }
        sender.layer.borderColor = UIColor.systemBlue.cgColor // Change border color to green
        
        // Check if the filter is already selected
        if selectedFilters.contains(option) {
            // Deselect the filter
            selectedFilters.remove(option)
            // Reset button's background and border color
            sender.backgroundColor = .white // Reset background color to clear
            sender.setTitleColor(.systemBlue, for: .normal)
        } else {
            // Select the filter
            selectedFilters.insert(option)
            // Change button's border and background color for selection
            sender.backgroundColor = UIColor.systemBlue // Highlight with background color
            sender.setTitleColor(.white, for: .normal)
        }
    }
    
    @objc private func applyFilters() {
        onApplyFilters?(selectedFilters)
    }
    
    @objc private func cancelFilter() {
        onCancelFilters?()
    }
}
