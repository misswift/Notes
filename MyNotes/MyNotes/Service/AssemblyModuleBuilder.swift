//
//  AssemblyBuilder.swift
//  MyNotes
//
//  Created by Халим Магомедов on 24.03.2022.
//

import Foundation
import  UIKit

protocol AssemblyBuiderProtocol: AnyObject {
    func createMainModule (router: RouterProtocol) -> UIViewController
}

class AssemblyModuleBuilder: AssemblyBuiderProtocol {
    
    func createMainModule(router: RouterProtocol) -> UIViewController  {
        let mainView = MainViewController()
        let presenter = MainPresenter(view: mainView, router: router)
        mainView.presenter = presenter
        return mainView
    }
    
}
