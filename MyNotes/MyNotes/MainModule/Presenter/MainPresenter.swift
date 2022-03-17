//
//  MainPresenter.swift
//  MyNotes
//
//  Created by Халим Магомедов on 15.03.2022.
//

import Foundation

protocol MainViewProtocol {
    func note (note: String)
}

protocol MainPresenterProtocol {
    func createNote (note: String)
    func deleteNote (note: String)

}

class MainPresenter: MainPresenterProtocol {
    func deleteNote(note: String) {
//        <#code#>
    }
    
    func createNote(note: String) {
//        <#code#>
    }
    
    let view: MainViewProtocol! = nil
}
