//
//  WishesCell.swift
//  fmh
//
//  Created: 30.04.22
//

import UIKit

protocol Sorted {
    func sorting(wishes: Wishes)
}

class WishesCell: UITableViewCell {
    
    private let taskThemeLabel = UILabel(text: "Тема", font: .avenirNext14())
    private let taskDescription = UILabel(text: "заменить матрац", font: .avenirNext16())
    private let patientLabel = UILabel(text: "Пациент", font: .avenirNext13())
    private let patientName = UILabel(text: "А.Н.Акопова", font: .avenirNext13())
    private let executorLabel = UILabel(text: "Исполнитель", font: .avenirNext13())
    private let executorName = UILabel(text: "М.Л.Павлов", font: .avenirNext13())
    private let plannedDateLabel = UILabel(text: "Плановая дата", font: .avenirNext13())
    private let plannedDate = UILabel(text: "10.19.22", font: .avenirNext14())
    private let plannedTime = UILabel(text: "9:00", font: .avenirNext13())
    
    private var taskColor = CGColor(gray: 0, alpha: 0)
    private var separateLineColor = UIColor(cgColor: (CGColor(gray: 0, alpha: 0)))
    
    private let lineFirst = UIView()
    private let lineSecond = UIView()
    private let linethird = UIView()
    private let lineFourth = UIView()
    
    private let leftSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8765103221, green: 0.8765102029, blue: 0.8765103221, alpha: 1)
        return view
    }()
    private let rightSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8765103221, green: 0.8765102029, blue: 0.8765103221, alpha: 1)
        return view
    }()
    
    private let openTask: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "VectorW"), for: .normal)
        return button
    }()
    
    private let cellView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 2
        view.backgroundColor = .white
        return view
    }()
    
    private let resultView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.openTask.addTarget(self, action: #selector(openTaskAction), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViewModel(_ viewModel: WishesViewModel) {
        self.taskDescription.text = viewModel.taskDescription
        self.patientName.text = viewModel.patientName
        self.executorName.text = viewModel.executorName
        self.plannedDate.text = viewModel.plannedDate
        self.plannedTime.text = viewModel.plannedTime
        self.taskColor = viewModel.color
        self.separateLineColor = UIColor(cgColor: self.taskColor)
        self.cellView.layer.borderColor = self.taskColor
        self.openTask.setBackgroundImage(.init(named: viewModel.nameButton), for: .normal)
        configureUI()
    }
    
    private func configureUI() {
        self.backgroundColor = UIColor(white: 0, alpha: 0)
        self.contentView.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        self.contentView.addSubview(self.resultView)
        self.resultView.backgroundColor = .white
        self.resultView.addSubview(self.cellView)
        
        let themeStackView = UIStackView(arrangedSubviews: [self.taskThemeLabel, self.taskDescription], axis: .horizontal, spacing: 10, distribution: .equalSpacing)
        self.cellView.addSubview(themeStackView)
        NSLayoutConstraint.activate([
            themeStackView.topAnchor.constraint(equalTo: self.cellView.topAnchor, constant: 5),
            themeStackView.leadingAnchor.constraint(equalTo: self.cellView.leadingAnchor, constant: 10),
            themeStackView.trailingAnchor.constraint(equalTo: self.cellView.trailingAnchor, constant: -10),
            themeStackView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        let patientStackView = UIStackView(arrangedSubviews: [self.patientLabel, self.patientName], axis: .horizontal, spacing: 10, distribution: .equalSpacing)
        self.cellView.addSubview(patientStackView)
        NSLayoutConstraint.activate([
            patientStackView.topAnchor.constraint(equalTo: themeStackView.bottomAnchor, constant: 5),
            patientStackView.leadingAnchor.constraint(equalTo: self.cellView.leadingAnchor, constant: 10),
            patientStackView.trailingAnchor.constraint(equalTo: self.cellView.trailingAnchor, constant: -10),
            patientStackView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        let executorStackView = UIStackView(arrangedSubviews: [self.executorLabel, self.executorName], axis: .horizontal, spacing: 10, distribution: .equalSpacing)
        self.cellView.addSubview(executorStackView)
        NSLayoutConstraint.activate([
            executorStackView.topAnchor.constraint(equalTo: patientStackView.bottomAnchor, constant: 5),
            executorStackView.leadingAnchor.constraint(equalTo: self.cellView.leadingAnchor, constant: 10),
            executorStackView.trailingAnchor.constraint(equalTo: self.cellView.trailingAnchor, constant: -10),
            executorStackView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        self.cellView.addSubview(self.plannedDateLabel)
        NSLayoutConstraint.activate([
            plannedDateLabel.topAnchor.constraint(equalTo: executorStackView.bottomAnchor, constant: 5),
            plannedDateLabel.leadingAnchor.constraint(equalTo: self.cellView.leadingAnchor, constant: 10),
            plannedDateLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        let planeDateStackView = UIStackView(arrangedSubviews: [self.plannedDate, self.plannedTime], axis: .horizontal, spacing: 10, distribution: .equalSpacing)
        self.cellView.addSubview(planeDateStackView)
        NSLayoutConstraint.activate([
            planeDateStackView.topAnchor.constraint(equalTo: executorStackView.bottomAnchor, constant: 5),
            planeDateStackView.leadingAnchor.constraint(equalTo: self.plannedDateLabel.trailingAnchor, constant: 70),
            planeDateStackView.trailingAnchor.constraint(equalTo: self.cellView.trailingAnchor, constant: -10),
            planeDateStackView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        self.cellView.addSubview(self.openTask)
        self.openTask.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.openTask.topAnchor.constraint(equalTo: planeDateStackView.bottomAnchor, constant: 9),
            self.openTask.centerXAnchor.constraint(equalTo: self.cellView.centerXAnchor),
            self.openTask.widthAnchor.constraint(equalToConstant: 17),
            self.openTask.heightAnchor.constraint(equalToConstant: 12)
        ])
        
        
        let separateLines = [lineFirst, lineSecond, linethird, lineFourth]
        for line in separateLines {
        self.cellView.addSubview(line)
            line.backgroundColor = separateLineColor
        }
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = CGRect(x: 20, y: 0, width: self.bounds.width - 40, height: self.bounds.height)
        self.resultView.frame = CGRect(x: 1, y: 2, width: self.bounds.width - 42, height: self.bounds.height)
       
        self.cellView.frame = CGRect(x: 20, y: 0, width: self.resultView.bounds.width - 40, height: self.resultView.bounds.height - 10)
        self.lineFirst.frame = setSeparateLines(y: 37)
        self.lineSecond.frame = setSeparateLines(y: 75)
        self.linethird.frame = setSeparateLines(y: 105)
        self.lineFourth.frame = setSeparateLines(y: 140)
    }
    
    private func setSeparateLines(y: Double) -> CGRect {
    return CGRect(x: self.cellView.bounds.minX + 10, y: y , width: self.cellView.bounds.width - 20, height: 1)
    }
    
    @objc private  func openTaskAction() {
        print("open task")
    }
    
}
