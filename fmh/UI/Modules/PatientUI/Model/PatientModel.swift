//
//  PatientModel.swift
//  fmh
//
//  Created: 03.06.2022
//

import Foundation


struct PatientModel: Identifiable {
    
    var id = UUID()
    var fio: String
    var dateOfBirth: String
    var status: String
}

var patients: [PatientModel] = [
    PatientModel(fio: "В. Ю. Сорокин", dateOfBirth: "10.04.1946", status: "Новый"),
    PatientModel(fio: "Е. С. Акимова", dateOfBirth: "07.11.1948", status: "В хосписе"),
    PatientModel(fio: "Н. П. Фролов", dateOfBirth: "03.06.1952", status: "Выписан"),
    PatientModel(fio: "М. С. Ерохина", dateOfBirth: "02.12.1938", status: "В хосписе"),
    PatientModel(fio: "В. Ю. Сорокин", dateOfBirth: "10.04.1946", status: "Новый"),
    PatientModel(fio: "Е. С. Акимова", dateOfBirth: "07.11.1948", status: "В хосписе"),
    PatientModel(fio: "Н. П. Фролов", dateOfBirth: "03.06.1952", status: "Выписан"),
    PatientModel(fio: "М. С. Ерохина", dateOfBirth: "02.12.1938", status: "В хосписе"),
    PatientModel(fio: "Ф. П. Тюрин", dateOfBirth: "07.02.1950", status: "В хосписе")
]

