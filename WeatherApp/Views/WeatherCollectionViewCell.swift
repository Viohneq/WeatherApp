import UIKit

final class WeatherCollectionViewCell: UICollectionViewCell {
    
    var time: UILabel = {
        let label = UILabel()
        label.text = "10:00"
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var icon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "snow.png")
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    var degrees: UILabel = {
        let label = UILabel()
        label.text = "-5 °C"
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        constrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(degrees)
        addSubview(icon)
        addSubview(time)
    }
    
    private func constrains() {
        let iconConstrains = [
            icon.centerXAnchor.constraint(equalTo: centerXAnchor),
            icon.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        let degreesConstrains = [
            degrees.centerXAnchor.constraint(equalTo: centerXAnchor),
            degrees.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ]
        let timeConstrains = [
            time.centerXAnchor.constraint(equalTo: centerXAnchor),
            time.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        ]
        NSLayoutConstraint.activate(iconConstrains)
        NSLayoutConstraint.activate(degreesConstrains)
        NSLayoutConstraint.activate(timeConstrains)
    }
}
