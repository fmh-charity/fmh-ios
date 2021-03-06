//
//  OurMissionDataArray.swift
//  fmh
//
//  Created: 6/19/22
//

import UIKit

struct OurMissionDataArray {
    
    private static var dataArray = [
        OurMissionStruct(tagline: "Хоспис для меня -\nэто то, каким должен быть мир.",
                         more: "\"Ну, идеальное устройство мира в моих глазах. Где никто не оценивает, никто не осудит, где говоришь, и тебя слышат, где, если страшно, тебя обнимут и возьмут за руку, а если холодно тебя согреют.\"\nЮля Капис, волонтер",
                         color: UIColor(red: 1, green: 0.941, blue: 0.904, alpha: 1),
                         isHidden: true),
        OurMissionStruct(tagline: "Хоспис в своем истинном понимании - это творчество.",
                         more: "\"Нет шаблона и стандарта, есть только дух, который живет в разных домах по разному. Но всегда он добрый, любящий и помогающий.”",
                         color: UIColor(red: 0.98, green: 0.941, blue: 0.839, alpha: 1),
                         isHidden: true),
        OurMissionStruct(tagline: "\"В хосписе не работают плохие люди”\nВ.В. Миллионщикова",
                         more: "Все сотрудники хосписа - это адвокаты пациента, его прав и потребностей. Поиск путей решения различных задач - это и есть хосписный индивидуальный подход к паллиативной помощи.",
                         color: UIColor(red: 0.858, green: 1, blue: 0.997, alpha: 1),
                         isHidden: true),
        OurMissionStruct(tagline: "«Хоспис – это философия, из которой следует сложнейшая наука медицинской помощи умирающим и искусство ухода, в котором сочетается компетентность и любовь» С. Сандерс",
                         more: "\"Творчески и осознанно подойти к проектированию опыта умирания.\nСоздать пространство физическое \nи психологическое, чтобы позволить жизни отыграть себя до конца.\nИ тогда человек не просто уходит с дороги.\nТогда старение и умирание могут стать процессом восхождения до самого конца.”\nБи Джей Миллер, врач,\nруководитель проекта “Дзен-хоспис”",
                         color: UIColor(red: 0.894, green: 1, blue: 0.892, alpha: 1),
                         isHidden: true),
        OurMissionStruct(tagline: "\"Служение человеку\nс теплом, любовью и заботой.\"",
                         more: "\"Если пациента нельзя вылечить, это не значит, что для него ничего нельзя сделать. То, что кажется мелочью, пустяком в жизни здорового человека - для пациента имеет огромный смысл.\"",
                         color: UIColor(red: 1, green: 0.941, blue: 0.906, alpha: 1),
                         isHidden: true),
        OurMissionStruct(tagline: "\"Хоспис продлевает жизнь, дает\nнадежду, утешение и поддержку.\"",
                         more: "“Хоспис - это мои новые друзья.\nПолная перезагрузка жизненных ценностей.\nВ хосписе нет страха и одиночества.”\nЕвгения Белоусова, дочь пациентки Ольги Васильевны",
                         color: UIColor(red: 1, green: 0.871, blue: 0.894, alpha: 1),
                         isHidden: true),
        OurMissionStruct(tagline: "\"Двигатель хосписа - милосердие плюс профессионализм\"\nА.В Гнездилов, д.м.н., один из пионеров хосписного движения.",
                         more: "\"Делай добро... А добро заразительно. По моему, все люди милосердны. Нужно просто говорить с ними об этом, суметь разбудить в них чувство сострадания, заложенное от рождения.”\nВ.В. Миллионщикова",
                         color: UIColor(red: 0.979, green: 0.94, blue: 0.838, alpha: 1),
                         isHidden: true),
        OurMissionStruct(tagline: "Важен каждый!",
                         more: "\"Каждый, кто оказывается в стенах хосписа, имеет огромное значение в жизни хосписа и его подопечных.\"",
                         color: UIColor(red: 0.904, green: 0.942, blue: 1, alpha: 1),
                         isHidden: true)]
    
    func getData() -> [OurMissionStruct] {
        return OurMissionDataArray.dataArray
    }
}
