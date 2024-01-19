//
//  OnboardingVC.swift
//  GithubRepoApp
//
//  Created by mehmet duran on 17.01.2024.
//

import UIKit
import SnapKit

final class OnboardingVC: UIViewController {
    
    private lazy var skipButton: UIButton = {
        let button = UIButton(type: .custom)
        
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.frame.size = .init(width: 50, height: 30)
        button.isHidden = true
        button.addTarget(self, action: #selector(skipAction), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = """
Welcome, 
Let's check out the excellent repos below!
"""
        
        return label
    }()
    
    private lazy var peraImageContainer: OnboardingBrandView = {
        let view = OnboardingBrandView(title: "Pera Wallet", imageName: "perawallet")
        
        return view
    }()
    
    private lazy var algorandImageContainer: OnboardingBrandView = {
        let view = OnboardingBrandView(title: "Algorand", imageName: "algorand")
        
        return view
    }()
    
    private lazy var algoFoundImageContainer: OnboardingBrandView = {
        let view = OnboardingBrandView(title: "Algorand Foundation", imageName: "algofound")
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(welcomeLabel)
        view.addSubview(peraImageContainer)
        view.addSubview(algorandImageContainer)
        view.addSubview(algoFoundImageContainer)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: skipButton)
        navigationItem.hidesBackButton = true
        
        configLayout()
    }
    
    private func configLayout() {
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(-100)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        peraImageContainer.snp.makeConstraints { make in
            make.centerY.leading.equalToSuperview()
            make.height.equalTo(100)
            make.trailing.equalToSuperview().inset(500)
        }
        
        algorandImageContainer.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(120)
            make.leading.equalToSuperview()
            make.height.equalTo(100)
            make.trailing.equalToSuperview().inset(500)
        }
        
        algoFoundImageContainer.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(240)
            make.leading.equalToSuperview()
            make.height.equalTo(100)
            make.trailing.equalToSuperview().inset(500)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 2, animations: {
            self.peraImageContainer.snp.updateConstraints { make in
                make.trailing.equalToSuperview().inset(20)
            }
            
            self.algorandImageContainer.snp.updateConstraints { make in
                make.trailing.equalToSuperview().inset(20)
            }
            
            self.algoFoundImageContainer.snp.updateConstraints { make in
                make.trailing.equalToSuperview().inset(20)
            }
            
            self.welcomeLabel.snp.updateConstraints { make in
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(50)
            }
                        
            self.view.layoutIfNeeded()
        }) { _ in
            self.skipButton.isHidden = false
        }
    }
    
    @objc private func skipAction() {
        UserManager.shared.isFirstLogin = false
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let sceneDelegate = windowScene.delegate as? SceneDelegate else {
            return
        }
        sceneDelegate.window?.rootViewController = UINavigationController(rootViewController:
                                                                            HomeVC(viewModel:
                                                                                    HomeVM(networkService:
                                                                                            Networking.shared)))
    }
}
