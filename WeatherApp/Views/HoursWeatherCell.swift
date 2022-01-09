import UIKit

final class HoursWeatherCell: UITableViewCell {
    
    var layout: UICollectionViewFlowLayout!
    
    var collection: UICollectionView!
    
    let separator: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        constrains()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        constrains()
    }
    
    private func setupViews() {
        layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 2.0
        layout.minimumInteritemSpacing = 2.0
        collection = UICollectionView(frame: .zero , collectionViewLayout: layout)
        collection.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: "collectioncell")
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        addSubview(collection)
        addSubview(separator)
    }
    
    override func layoutSubviews() {
        collection.frame = bounds
    }
    
    private func constrains() {
        let separatorConstrains = [
            separator.widthAnchor.constraint(equalTo: widthAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1.0),
            separator.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        NSLayoutConstraint.activate(separatorConstrains)
    }
    
}
