//
//  MainPresenter.swift
//  MyNotes
//
//  Created by Халим Магомедов on 15.03.2022.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func note (note: String)
}

protocol MainPresenterProtocol: AnyObject {
    func createNote (note: String)
    func deleteNote (note: String)

}

class MainPresenter: MainPresenterProtocol {
    let view: MainViewProtocol!
    let router: RouterProtocol!
    
    init (  view: MainViewProtocol, router: RouterProtocol){
        self.view = view
        self.router = router
    }
    
    func deleteNote(note: String) {
//        <#code#>
    }
    
    func createNote(note: String) {
//        <#code#>
    }
    
   
}
