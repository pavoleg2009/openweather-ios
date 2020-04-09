//
//  GridViewController.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 07.04.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import UIKit

final class GridViewController: UIViewController {
    
    let colCount = 8
    var rowCount: Int {
        logic.displayData.count
    }
    let space: CGFloat = 8
    
    typealias Logic = GridViewOutput & GridDataSource
    
    var logic: Logic!
    
    // MARK: Outlets
    private lazy var sourcesSegmetedConrol: UISegmentedControl = {
        let sc = UISegmentedControl(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: 200,
                                                  height: 40))
        
        return sc
    }()
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            collectionView.collectionViewLayout = layout
            
            collectionView.owa_register(cellType: WeatherCell.self)
            
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
        
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.reloadData()
    }
}

// MARK: - GridViewInput
extension GridViewController: GridViewInput {
    func configure() {
        loadViewIfNeeded()
        configureSegmentedContol()
        
    }
    func showActivityIndicator() {
        print("!!! \(type(of: self)).\(#function): Show activity indicator here")
    }
    
    func hideActivityIndicator() {
        print("!!! \(type(of: self)).\(#function): Hide activity indicator here")
    }
    
    func showError(errorDescription: String) {
        print("!!! \(type(of: self)).\(#function): Error: \(errorDescription)")
    }
     
    func update() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
extension GridViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        logic.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: WeatherCell = collectionView.owa_dequeueReusableCell(for: indexPath)
        
        let col = indexPath.item / rowCount
        let row = indexPath.item % rowCount
        let displayData = logic.displayData[row][col]
        
        cell.configure(with: displayData)
        
        return cell
    }
}

// move to layout
extension GridViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = (collectionView.bounds.height / CGFloat(rowCount)) - space
        return CGSize(width: height * .cellHeightToWidthRation, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return space
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return space
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        UIEdgeInsets(top: space / 2.0,
                     left: space / 2.0,
                     bottom: space / 2.0,
                     right: space / 2.0)
    }
}

final class GridLayout: UICollectionViewFlowLayout {
    
    private let rowCount: Int
    
    init(rowCount: Int) {
        self.rowCount = rowCount
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Private Methods
private extension GridViewController {
    
    func configureSegmentedContol() {
        print("!!! \(type(of: self)).\(#function): ")
        self.navigationItem.titleView = sourcesSegmetedConrol

        for (index, title) in ["Online API", "JSON File"].enumerated() {
            sourcesSegmetedConrol.insertSegment(withTitle: title,
                                                at: index,
                                                animated: false)
        }
        sourcesSegmetedConrol.selectedSegmentIndex = 0
//        sourcesSegmetedConrol.removeAllSegments()
//
//        guard !logic.datasourceTitles.isEmpty else { return }
//
//        for (index, title) in logic.datasourceTitles.enumerated() {
//            sourcesSegmetedConrol.insertSegment(withTitle: title,
//                                                at: index,
//                                                animated: false)
//        }
//        sourcesSegmetedConrol.selectedSegmentIndex = 0
    }
    
}

private extension CGFloat {
    static let cellHeightToWidthRation: CGFloat = 1
}
