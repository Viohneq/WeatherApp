import UIKit

final class WeatherCollectionViewCell: UICollectionViewCell {
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en-US")
        return formatter
    }()
    
    var time: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var icon: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    var degrees: UILabel = {
        let label = UILabel()
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
    
    func configure(with hourlyWeather: HourlyWeather) {
        degrees.text = "\(Int(hourlyWeather.temp))°C"
        dateFormatter.dateFormat = "HH:mm"
        time.text = dateFormatter.string(from: NSDate(timeIntervalSince1970: TimeInterval(hourlyWeather.dt)) as Date)
        switch hourlyWeather.weather[0].main {
        case "Snow":
            icon.image = UIImage(named: "snow.png")
        case "Clouds":
            icon.image = UIImage(named: "clouds.png")
        default:
            icon.image = UIImage(named: "sun.png")
        }
    }
    
    private func setupViews() {
        addSubview(degrees)
        addSubview(icon)
        addSubview(time)
        backgroundColor = .clear
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
