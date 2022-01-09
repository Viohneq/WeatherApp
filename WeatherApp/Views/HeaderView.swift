import UIKit

final class HeaderView: UIView {
    
    var town: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .headline).withSize(20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var degrees: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle).withSize(50)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var icon: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    var desc: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var feels: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let separator: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configure(with currentWeather: CurrentWeather) {
            degrees.text = "\(Int(currentWeather.temp)) °C"
            feels.text = "Feels like \(Int(currentWeather.feels_like)) °C"
            desc.text = currentWeather.weather[0].description
            switch currentWeather.weather[0].main {
            case "Snow":
                icon.image = UIImage(named: "snow.png")
            case "Clouds":
                icon.image = UIImage(named: "clouds.png")
            default:
                icon.image = UIImage(named: "sun.png")
            }
    }
    
    func setCity(_ city: String) {
        town.text = city
    }
    
    private func setupViews() {
        addSubview(town)
        addSubview(icon)
        addSubview(desc)
        addSubview(feels)
        addSubview(degrees)
        addSubview(separator)
        constrains()
    }
    
    private func constrains() {
        let townConstrains = [
            town.heightAnchor.constraint(equalToConstant: 50),
            town.centerXAnchor.constraint(equalTo: centerXAnchor),
        ]
        let iconConstrains = [
            icon.centerXAnchor.constraint(equalTo: centerXAnchor),
            icon.topAnchor.constraint(equalTo: topAnchor, constant: 80),
            icon.widthAnchor.constraint(equalToConstant: 50),
            icon.heightAnchor.constraint(equalToConstant: 50)
        ]
        let degreesConstrains = [
            degrees.centerXAnchor.constraint(equalTo: centerXAnchor),
            degrees.topAnchor.constraint(equalTo: topAnchor, constant: 155)
        ]
        let descConstrains = [
            desc.centerXAnchor.constraint(equalTo: centerXAnchor),
            desc.topAnchor.constraint(equalTo: topAnchor, constant: 225)
        ]
        let feelsConstrains = [
            feels.centerXAnchor.constraint(equalTo: centerXAnchor),
            feels.topAnchor.constraint(equalTo: topAnchor, constant: 130)
        ]
        let separatorConstrains = [
            separator.widthAnchor.constraint(equalTo: widthAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1.0),
            separator.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        NSLayoutConstraint.activate(townConstrains)
        NSLayoutConstraint.activate(iconConstrains)
        NSLayoutConstraint.activate(degreesConstrains)
        NSLayoutConstraint.activate(descConstrains)
        NSLayoutConstraint.activate(feelsConstrains)
        NSLayoutConstraint.activate(separatorConstrains)
    }
}
