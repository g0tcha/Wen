//
//  TitleSubtitleCell.swift
//  Wen
//
//  Created by Vincent Grossier on 26/06/2022.
//

import UIKit

final class TitleSubtitleCell: UITableViewCell {
    private var viewModel: TitleSubtitleCellViewModel?
    private let titleLabel = UILabel()
    let subtitleTextField = UITextField()
    private let verticalStackView = UIStackView()
    private let padding: CGFloat = 15
    
    private let datePickerView = UIDatePicker()
    private let toolBar = UIToolbar(frame: .init(x: 0, y: 0, width: 100, height: 100))
    
    lazy var doneButton: UIBarButtonItem = {
        UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tappedDone))
    }()
    
    private let photoImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with viewModel: TitleSubtitleCellViewModel) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        subtitleTextField.text = viewModel.subtitle
        subtitleTextField.placeholder = viewModel.placeholder
        subtitleTextField.inputView = viewModel.type == .date ? datePickerView : nil
        subtitleTextField.inputAccessoryView = viewModel.type == .date ? toolBar : nil
        
        photoImageView.isHidden = viewModel.type != .image
        subtitleTextField.isHidden = viewModel.type == .image
        verticalStackView.spacing = viewModel.type == .image ? padding : verticalStackView.spacing
    }
    
    private func setupViews() {
        verticalStackView.axis = .vertical
        titleLabel.font = .systemFont(ofSize: 22, weight: .medium)
        subtitleTextField.font = .systemFont(ofSize: 20, weight: .medium)
        [verticalStackView, titleLabel, subtitleTextField].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        toolBar.setItems([doneButton], animated: false)
        datePickerView.datePickerMode = .date
        photoImageView.backgroundColor = .black.withAlphaComponent(0.4)
        photoImageView.layer.cornerRadius = 10
    }
    
    private func setupHierarchy() {
        contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(subtitleTextField)
        verticalStackView.addArrangedSubview(photoImageView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            verticalStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: padding),
            verticalStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -padding),
            verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ])
        photoImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    @objc private func tappedDone() {
        viewModel?.update(datePickerView.date)
    }
}
