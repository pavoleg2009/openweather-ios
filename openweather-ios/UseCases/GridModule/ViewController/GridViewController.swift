//
//  GridViewController.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 07.04.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import UIKit

final class GridViewController: UIViewController {
    
    typealias Presenter = GridViewOutput & GridDataSource
    
    var presenter: Presenter!
    
    // MARK: Outlets
    private lazy var sourcesSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        
        return segmentedControl
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
        configureSegmentedControl()
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int
    ) -> Int {
        presenter.getItemsCount(for: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: WeatherCell = collectionView.owa_dequeueReusableCell(for: indexPath)
        guard let gridItem = presenter.getGridItem(for: indexPath) else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: gridItem)
        
        return cell
    }
}

// move to layout
extension GridViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = (collectionView.bounds.height / CGFloat(presenter.rowCount)) - .defaultCellMargin
        return CGSize(width: height * .cellHeightToWidthRation, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return .defaultCellMargin
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return .defaultCellMargin
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        UIEdgeInsets(top: .defaultCellMargin / 2.0,
                     left: .defaultCellMargin / 2.0,
                     bottom: .defaultCellMargin / 2.0,
                     right: .defaultCellMargin / 2.0)
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
    
    @IBAction func sourceIndexDidChange(_ sender: Any
    ) {
        presenter.selectDataSource(index: sourcesSegmentedControl.selectedSegmentIndex)
    }
    
    func configureSegmentedControl() {
        
        self.navigationItem.titleView = sourcesSegmentedControl
        
        sourcesSegmentedControl.removeAllSegments()
        guard !presenter.datasourceTitles.isEmpty else { return }
        
        for (index, title) in presenter.datasourceTitles.enumerated() {
            sourcesSegmentedControl.insertSegment(withTitle: title,
                                                  at: index,
                                                  animated: false)
        }
        sourcesSegmentedControl.addTarget(self, action: #selector(sourceIndexDidChange), for: .valueChanged)
        sourcesSegmentedControl.selectedSegmentIndex = 0
        if #available(iOS 13.0, *) {
            sourcesSegmentedControl.selectedSegmentTintColor = .owa_primaryBrandColor
        } else {
            sourcesSegmentedControl.tintColor = .owa_primaryBrandColor
        }
        
    }
    
}

private extension CGFloat {
    static let cellHeightToWidthRation: CGFloat = 1
    static let defaultCellMargin: CGFloat = 8
}
