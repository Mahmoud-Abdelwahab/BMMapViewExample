//
//  BranchCardView.swift
//  MapDemo
//
//  Created by Mahmoud Abdulwahab on 24/06/2023.
//

import UIKit

class BranchCardView: UIView {
    
    // MARK: - Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    // MARK: - Properties
    var didTapOnCard: ((BranchCardCellViewModel) -> ())?
    var animateCamera: ((BranchCardCellViewModel) -> ())?
    private var viewModel: [BranchCardCellViewModel]?
    private var lastIndex = 0
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: - Methods
    private func commonInit() {
        loadViewFromNib()
        setupUI()
    }
    
}

// MARK: - Configuration
extension BranchCardView: ReusableCardViewType {
    
    private func setupUI() {
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        let uiNib = UINib(nibName: String(describing: BranchCardCell.self), bundle: nil)
        collectionView.register(uiNib, forCellWithReuseIdentifier: String(describing: BranchCardCell.self))
        let flowLayout = CustomCollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = flowLayout
    }
    
    public func configureCell(viewModel: [BranchCardCellViewModel]) {
        self.viewModel = viewModel
        collectionView.reloadData()
    }
    
    public func scrollTo(desiredIndex: Int) {
        let indexPath = IndexPath(item: desiredIndex, section: 0)
        collectionView.delegate = nil
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) { [weak self] in
            self?.collectionView.delegate = self
        }
    }
}


// MARK: - CollectionView
extension BranchCardView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BranchCardCell.self), for: indexPath) as! BranchCardCell
        if let branchModel = viewModel?[indexPath.row] {
            cell.configureUI(branch: branchModel)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let viewModel = viewModel {
            didTapOnCard?(viewModel[indexPath.row])
        }
    }
}

// MARK: - CollectionView
extension BranchCardView: UIScrollViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let visibleRect = CGRect(origin: collectionView.contentOffset,
                                 size: collectionView.visibleSize)
        let centerPoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let indexPath = collectionView.indexPathForItem(at: centerPoint) {
            if indexPath.row != lastIndex {
                lastIndex = indexPath.row
                print("Fully displayed index ✅: \(indexPath.row)")
                if let viewModel = viewModel {
                    animateCamera?(viewModel[indexPath.row])
                }
            }
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            determineFullyDisplayedIndex()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        determineFullyDisplayedIndex()
    }
    
    
    private func determineFullyDisplayedIndex() {
        guard let collectionView = collectionView else {
            return
        }
        
        let visibleCells = collectionView.visibleCells
        
        guard  let lastVisibleCell = visibleCells.last else {
            return
        }
        
        guard let lastVisibleIndex = collectionView.indexPath(for: lastVisibleCell) else {
            return
        }
        let count = (viewModel?.count ?? 0 ) - 1
        let fullyDisplayedIndex: Int
     
        if  collectionView.contentOffset.x <= 37 {
            fullyDisplayedIndex = 0
            print("Fully displayed index 🚀: \(fullyDisplayedIndex)")
            lastIndex = fullyDisplayedIndex
            if let viewModel = viewModel {
                animateCamera?(viewModel[fullyDisplayedIndex])
            }
        } else if collectionView.contentOffset.x + collectionView.bounds.width >= lastVisibleCell.frame.maxX - 60    {
            if lastVisibleIndex.item == count {
                //            fullyDisplayedIndex = lastVisibleIndex.item
                fullyDisplayedIndex = count
                print("Fully displayed index 🚀: \(fullyDisplayedIndex)")
                lastIndex = fullyDisplayedIndex
                if let viewModel = viewModel {
                    animateCamera?(viewModel[fullyDisplayedIndex])
                }
            }
        }
    }
}

class CustomCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else {
            return
        }
        let availableWidth = collectionView.bounds.width + 10
        let itemWidth = availableWidth * (2/3)
        let itemHeight: CGFloat = 140
        itemSize = CGSize(width: itemWidth, height: itemHeight)
        minimumInteritemSpacing = 0
        minimumLineSpacing = 10
    }
}


extension UICollectionView {
    var visibleCurrentCellIndexPath: IndexPath? {
        for cell in self.visibleCells {
            let indexPath = self.indexPath(for: cell)
            return indexPath
        }
        
        return nil
    }
}
