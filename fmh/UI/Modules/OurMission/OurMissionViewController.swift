//
//  OurMissionViewController.swift
//  fmh
//
//  Created: 5/15/22
//

import UIKit

// MARK: - Data Struct
struct ourMissionStruct {
    let tagline: String
    let more: String
    let color: UIColor
    var isHidden: Bool
}

class OurMissionViewController: UIViewController {
    
    // MARK: - Parameters
    private let taglineView = UIView()
    private let customTableView = UITableView()
    
    override func loadView() {
        super.loadView()
        setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customTableView.register(OurMissionCell.self, forCellReuseIdentifier: OurMissionCell.identifier)
        customTableView.dataSource = self
        customTableView.delegate = self
    }
    
    // MARK: - Data Array
    private var dataArray = [
        ourMissionStruct(tagline: "Хоспис для меня -\nэто то, каким должен быть мир.",
                         more: "\"Ну, идеальное устройство мира в моих глазах. Где никто не оценивает, никто не осудит, где говоришь, и тебя слышат, где, если страшно, тебя обнимут и возьмут за руку, а если холодно тебя согреют.\"\nЮля Капис, волонтер",
                         color: UIColor(red: 1, green: 0.941, blue: 0.904, alpha: 1),
                         isHidden: true),
        ourMissionStruct(tagline: "Хоспис в своем истинном понимании - это творчество.",
                         more: "\"Нет шаблона и стандарта, есть только дух, который живет в разных домах по разному. Но всегда он добрый, любящий и помогающий.”",
                         color: UIColor(red: 0.98, green: 0.941, blue: 0.839, alpha: 1),
                         isHidden: true),
        ourMissionStruct(tagline: "\"В хосписе не работают плохие люди”\nВ.В.       Миллионщикова",
                         more: "Все сотрудники хосписа - это адвокаты пациента, его прав и потребностей. Поиск путей решения различных задач - это и есть хосписный индивидуальный подход к паллиативной помощи.",
                         color: UIColor(red: 0.858, green: 1, blue: 0.997, alpha: 1),
                         isHidden: true),
        ourMissionStruct(tagline: "«Хоспис – это философия, из которой следует сложнейшая наука медицинской помощи умирающим и искусство ухода, в котором сочетается компетентность и любовь» С. Сандерс",
                         more: "\"Творчески и осознанно подойти к проектированию опыта умирания.\nСоздать пространство физическое \nи психологическое, чтобы позволить жизни отыграть себя до конца.\nИ тогда человек не просто уходит с дороги.\nТогда старение и умирание могут стать процессом восхождения до самого конца.”\nБи Джей Миллер, врач,\nруководитель проекта “Дзен-хоспис”",
                         color: UIColor(red: 0.894, green: 1, blue: 0.892, alpha: 1),
                         isHidden: true),
        ourMissionStruct(tagline: "\"Служение человеку\nс теплом, любовью и заботой.\"",
                         more: "\"Если пациента нельзя вылечить, это не значит, что для него ничего нельзя сделать. То, что кажется мелочью, пустяком в жизни здорового человека - для пациента имеет огромный смысл.\"",
                         color: UIColor(red: 1, green: 0.941, blue: 0.906, alpha: 1),
                         isHidden: true),
        ourMissionStruct(tagline: "\"Хоспис продлевает жизнь, дает\nнадежду, утешение и поддержку.\"",
                         more: "“Хоспис - это мои новые друзья.\nПолная перезагрузка жизненных ценностей.\nВ хосписе нет страха и одиночества.”\nЕвгения Белоусова, дочь пациентки Ольги Васильевны",
                         color: UIColor(red: 1, green: 0.871, blue: 0.894, alpha: 1),
                         isHidden: true),
        ourMissionStruct(tagline: "\"Двигатель хосписа - милосердие плюс профессионализм\"\nА.В Гнездилов, д.м.н., один из пионеров хосписного движения.",
                         more: "\"Делай добро... А добро заразительно. По моему, все люди милосердны. Нужно просто говорить с ними об этом, суметь разбудить в них чувство сострадания, заложенное от рождения.”\nВ.В. Миллионщикова",
                         color: UIColor(red: 0.979, green: 0.94, blue: 0.838, alpha: 1),
                         isHidden: true),
        ourMissionStruct(tagline: "Важен каждый!",
                         more: "\"Каждый, кто оказывается в стенах хосписа, имеет огромное значение в жизни хосписа и его подопечных.\"",
                         color: UIColor(red: 0.904, green: 0.942, blue: 1, alpha: 1),
                         isHidden: true)]
    
    // MARK: - Setup UI
    private func setupUI() {
        view.addSubview(taglineView)
        taglineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            taglineView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60), //fix
            taglineView.leftAnchor.constraint(equalTo: view.leftAnchor),
            taglineView.rightAnchor.constraint(equalTo: view.rightAnchor),
            taglineView.heightAnchor.constraint(equalToConstant: 68)
        ])
        taglineView.clipsToBounds = true
        taglineView.backgroundColor = UIColor(red: 0.892, green: 0.892, blue: 0.892, alpha: 1)
        
        let taglineLabel = UILabel()
        taglineView.addSubview(taglineLabel)
        taglineLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            taglineLabel.centerXAnchor.constraint(equalTo: taglineView.centerXAnchor),
            taglineLabel.centerYAnchor.constraint(equalTo: taglineView.centerYAnchor),
            taglineLabel.heightAnchor.constraint(equalToConstant: 32),
            taglineLabel.widthAnchor.constraint(equalToConstant: 211)
        ])
        taglineLabel.clipsToBounds = true
        taglineLabel.layer.cornerRadius = 6
        taglineLabel.backgroundColor = UIColor(red: 0.821, green: 1, blue: 0.998, alpha: 1)
        taglineLabel.font.withSize(19   )
        taglineLabel.textColor = UIColor(red: 0, green: 0.506, blue: 0.498, alpha: 1)
        taglineLabel.textAlignment = .center
        taglineLabel.text = "Главное - жить любя"
        
        view.addSubview(customTableView)
        customTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            customTableView.topAnchor.constraint(equalTo: taglineView.bottomAnchor),
            customTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            customTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        customTableView.clipsToBounds = true
        customTableView.backgroundView = UIImageView(image: UIImage(named: "BackGround"))
        customTableView.separatorStyle = .none
        customTableView.rowHeight = UITableView.automaticDimension
    }
    
}

// MARK: - DataSource
extension OurMissionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OurMissionCell.identifier, for: indexPath) as! OurMissionCell
        
        cell.configure(cellData: dataArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = customTableView.cellForRow(at: indexPath) as! OurMissionCell
        
        customTableView.beginUpdates()
       
        cell.isDescriptionHidden.toggle()
        dataArray[indexPath.row].isHidden.toggle()
        
        customTableView.endUpdates()
    }
}
