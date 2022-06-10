//
//  ChambersHeaderListView.swift
//  fmh
//
//  Created: 10.06.2022
//

import UIKit

class ChambersHeaderListView: UIView {
    
    private lazy var listLabel: UILabel = {
        let label = UILabel()
        label.text = "Список палат"
        label.font = .systemFont(ofSize: 19, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        return label
    }()
    
    private lazy var infoButton: UIButton = {
        let button = UIButton(image: UIImage(systemName: "info.circle"))
        return button
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton(image: UIImage(systemName: "plus.circle"))
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [infoButton, addButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.backgroundColor = .systemGray5
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstrains()
        self.backgroundColor = .systemGray5
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setupConstrains() {
    
        addSubview(listLabel)
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            listLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            listLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 18),
            stackView.leadingAnchor.constraint(lessThanOrEqualTo: listLabel.trailingAnchor, constant: 180),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15)
        ])
        
    }
    
    
}


// MARK: - SwiftUI Representable
#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ChambersViewRepresentable: UIViewRepresentable {
    
    func makeUIView(context: Context) -> some UIView {
        return ChambersHeaderListView()
    }
    
    func updateUIView(_ uiViewController: UIViewType, context: Context) {
        
    }
}

struct PatientsUIViewView_Preview: PreviewProvider {
    static var previews: some View {
        ChambersViewRepresentable()
            //.frame(width: 290, height: 170, alignment: .center)
    }
}
#endif
