//
//  SplashVC.swift
//  GithubRepoApp
//
//  Created by mehmet duran on 18.01.2024.
//

import UIKit

class SplashVC: UIViewController {
    
    private let viewModel: SplashVM
    
    init(viewModel: SplashVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        if viewModel.firstLogin() {
            navigationController?.pushViewController(OnboardingVC(), animated: true)
        } else {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let sceneDelegate = windowScene.delegate as? SceneDelegate else {
                return
            }
            sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: HomeVC())
        }
    }
}
