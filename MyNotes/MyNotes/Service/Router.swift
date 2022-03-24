//
//  Router.swift
//  MyNotes
//
//  Created by Халим Магомедов on 24.03.2022.
//

import Foundation
import UIKit

protocol MainRouterProtocol: AnyObject {
    var navigationController: UINavigationController? {get set}
    var assemblyBuilder: AssemblyModuleBuilder? {get set}
}

protocol RouterProtocol: MainRouterProtocol {
    func initialViewController()
}

class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyModuleBuilder?
    
    init (navigationController: UINavigationController, assemblyBuilder: AssemblyModuleBuilder){
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainVC = assemblyBuilder?.createMainModule(router: self) else {return}
//            navigationController.navigationBar.isHidden = true
            navigationController.viewControllers = [mainVC]
        }
    }
}
