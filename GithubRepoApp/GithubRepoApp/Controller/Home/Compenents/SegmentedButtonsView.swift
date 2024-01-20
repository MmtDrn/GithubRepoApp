//
//  SegmentedButtonsView.swift
//  GithubRepoApp
//
//  Created by mehmet duran on 19.01.2024.
//

import UIKit

protocol FilterProtocol: AnyObject {
    func sendFiletCase(filterCase: FilterCases)
}

class SegmentedButtonsView: UIView {
    
    weak var delegate: FilterProtocol?
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
                
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        
        return scrollView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.spacing = 10

        return stackView
    }()
    
    private lazy var brandButton: UIButton = {
        let button = UIButton(type: .custom)
        
        button.setTitle("All", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = UIColor.black
        button.layer.cornerRadius = 10
        button.semanticContentAttribute = .forceRightToLeft
        button.backgroundColor = .withHex("F7F7F7")
        button.showsMenuAsPrimaryAction = true
        button.menu = brandMenuItems()
        
        return button
    }()
    
    private lazy var languageButton: UIButton = {
        let button = UIButton(type: .custom)
        
        button.setTitle("Language: All", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = UIColor.black
        button.layer.cornerRadius = 10
        button.semanticContentAttribute = .forceRightToLeft
        button.backgroundColor = .withHex("F7F7F7")
        button.showsMenuAsPrimaryAction = true
        button.menu = languageMenuItems()
        
        return button
    }()
    
    private lazy var sortButton: UIButton = {
        let button = UIButton(type: .custom)
        
        button.setTitle("Sort: Recently pushed", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = UIColor.black
        button.layer.cornerRadius = 10
        button.semanticContentAttribute = .forceRightToLeft
        button.backgroundColor = .withHex("F7F7F7")
        button.showsMenuAsPrimaryAction = true
        button.menu = sortMenuItems()
        
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(brandButton)
        stackView.addArrangedSubview(languageButton)
        stackView.addArrangedSubview(sortButton)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        brandButton.snp.makeConstraints { make in
            make.width.equalTo(60)
            make.height.equalTo(30)
        }
        
        languageButton.snp.makeConstraints { make in
            make.width.equalTo(120)
            make.height.equalTo(30)
        }
        
        sortButton.snp.makeConstraints { make in
            make.width.equalTo(180)
            make.height.equalTo(30)
        }
    }
    
    private func brandMenuItems() -> UIMenu {
        let menuItems = UIMenu(options: .displayInline, children: [
            UIAction(title: "All") { [weak self] value in
                self?.brandButton.setTitle(value.title, for: .normal)
                self?.updateButtonWidth(self?.brandButton, value: 50)
                self?.delegate?.sendFiletCase(filterCase: .allBrand)
                self?.reTitle1()
            },
            
            UIAction(title: "Pera Wallet") { [weak self] value in
                self?.brandButton.setTitle(value.title, for: .normal)
                self?.updateButtonWidth(self?.brandButton, value: 120)
                self?.delegate?.sendFiletCase(filterCase: .peraWallet)
                self?.reTitle1()
            },
            
            UIAction(title: "Algorand") {  [weak self] value in
                self?.brandButton.setTitle(value.title, for: .normal)
                self?.updateButtonWidth(self?.brandButton, value: 120)
                self?.delegate?.sendFiletCase(filterCase: .algorand)
                self?.reTitle1()
            },
            
            UIAction(title: "Algorand Foundatiton") { [weak self] value in
                self?.brandButton.setTitle(value.title, for: .normal)
                self?.updateButtonWidth(self?.brandButton, value: 180)
                self?.delegate?.sendFiletCase(filterCase: .algorandFoundatiton)
                self?.reTitle1()
            }
        ])
        
        return menuItems
    }
    
    private func languageMenuItems() -> UIMenu {
        let menuItems = UIMenu(options: .displayInline, children: [
            UIAction(title: "All") { [weak self] value in
                self?.languageButton.setTitle("Language: \(value.title)", for: .normal)
                self?.updateButtonWidth(self?.languageButton, value: 120)
                self?.delegate?.sendFiletCase(filterCase: .allLaunguage)
                self?.reTitle2()
            },
            
            UIAction(title: "Swift") { [weak self] value in
                self?.languageButton.setTitle("Language: \(value.title)", for: .normal)
                self?.updateButtonWidth(self?.languageButton, value: 160)
                self?.delegate?.sendFiletCase(filterCase: .swift)
                self?.reTitle2()
            },
            
            UIAction(title: "Python") { [weak self] value in
                self?.languageButton.setTitle("Language: \(value.title)", for: .normal)
                self?.updateButtonWidth(self?.languageButton, value: 160)
                self?.delegate?.sendFiletCase(filterCase: .python)
                self?.reTitle2()
            },
            
            UIAction(title: "Go") { [weak self] value in
                self?.languageButton.setTitle("Language: \(value.title)", for: .normal)
                self?.updateButtonWidth(self?.languageButton, value: 120)
                self?.delegate?.sendFiletCase(filterCase: .go)
                self?.reTitle2()
            }
        ])
        return menuItems
    }
    
    private func sortMenuItems() -> UIMenu {
        let menuItems = UIMenu(options: .displayInline, children: [
            UIAction(title: "Recently pushed") { [weak self] value in
                self?.sortButton.setTitle("Sort: \(value.title)", for: .normal)
                self?.updateButtonWidth(self?.sortButton, value: 180)
                self?.delegate?.sendFiletCase(filterCase: .recentlyPushed)
                self?.reTitle3()
            },
            
            UIAction(title: "Latest pushed") { [weak self] value in
                self?.sortButton.setTitle("Sort: \(value.title)", for: .normal)
                self?.updateButtonWidth(self?.sortButton, value: 170)
                self?.delegate?.sendFiletCase(filterCase: .latestPushed)
                self?.reTitle3()
            },
            
            UIAction(title: "Newest") {  [weak self] value in
                self?.sortButton.setTitle("Sort: \(value.title)", for: .normal)
                self?.updateButtonWidth(self?.sortButton, value: 120)
                self?.delegate?.sendFiletCase(filterCase: .newest)
                self?.reTitle3()
            },
            
            UIAction(title: "Oldest") { [weak self] value in
                self?.sortButton.setTitle("Sort: \(value.title)", for: .normal)
                self?.updateButtonWidth(self?.sortButton, value: 120)
                self?.delegate?.sendFiletCase(filterCase: .oldest)
                self?.reTitle3()
            }
        ])
        return menuItems
    }
    
    private func updateButtonWidth(_ button: UIButton?, value: CGFloat) {
        guard let button = button else { return }
        button.snp.updateConstraints { make in
            make.width.equalTo(value)
        }
    }
    
    private func reTitle1() {
        languageButton.setTitle("Language: All", for: .normal)
        sortButton.setTitle("Sort: Recently pushed", for: .normal)
        updateButtonWidth(languageButton, value: 120)
        updateButtonWidth(sortButton, value: 180)
    }
    
    private func reTitle2() {
        brandButton.setTitle("All", for: .normal)
        sortButton.setTitle("Sort: Recently pushed", for: .normal)
        updateButtonWidth(brandButton, value: 60)
        updateButtonWidth(sortButton, value: 180)
    }
    
    private func reTitle3() {
        brandButton.setTitle("All", for: .normal)
        languageButton.setTitle("Language: All", for: .normal)
        updateButtonWidth(brandButton, value: 60)
        updateButtonWidth(languageButton, value: 120)
    }
    
    func reConfigureButtons() {
        brandButton.setTitle("All", for: .normal)
        languageButton.setTitle("Language: All", for: .normal)
        sortButton.setTitle("Sort: Recently pushed", for: .normal)
        
        updateButtonWidth(brandButton, value: 60)
        updateButtonWidth(languageButton, value: 120)
        updateButtonWidth(sortButton, value: 180)
    }
}
