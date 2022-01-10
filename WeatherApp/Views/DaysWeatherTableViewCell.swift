import UIKit

final class DaysWeatherTableViewCell: UITableViewCell {
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en-US")
        return formatter
    }()
    
    var date: UILabel = {
        let label = UILabel()
        label.textColor = .white.withAlphaComponent(0.5)
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var dayOfWeek: UILabel = {
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
    
    var degreesDay: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont.preferredFont(forTextStyle: .subheadline).withSize(25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var degreesNight: UILabel = {
        let label = UILabel()
        label.textColor = .white.withAlphaComponent(0.5)
        label.textAlignment = .right
        label.font = UIFont.preferredFont(forTextStyle: .subheadline).withSize(25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        constrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with dailyWeather: DailyWeather) {
        switch dailyWeather.weather[0].main {
        case "Snow":
            icon.image = UIImage(named: "snow.png")
        case "Clouds":
            icon.image = UIImage(named: "clouds.png")
        case "Rain":
            icon.image = UIImage(named: "rain.png")
        default:
            icon.image = UIImage(named: "sun.png")
        }
        dateFormatter.dateFormat = "D MMMM"
        date.text = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(dailyWeather.dt)))
        dateFormatter.dateFormat = "EEEE"
        dayOfWeek.text = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(dailyWeather.dt)))
        degreesDay.text = "\(Int(dailyWeather.temp.day))°"
        degreesNight.text = "\(Int(dailyWeather.temp.night))°"
    }
    
    private func setupViews() {
        backgroundColor = .clear
        addSubview(degreesDay)
        addSubview(degreesNight)
        addSubview(date)
        addSubview(dayOfWeek)
        addSubview(icon)
    }
    
    private func constrains() {
        let iconConstrains = [
            icon.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 140),
            icon.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        let dayConstrains = [
            degreesDay.centerYAnchor.constraint(equalTo: centerYAnchor),
            degreesDay.centerXAnchor.constraint(equalTo: centerXAnchor),
            degreesDay.widthAnchor.constraint(equalToConstant: 50)
        ]
        let nightConstrains = [
            degreesNight.centerYAnchor.constraint(equalTo: centerYAnchor),
            degreesNight.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 75),
            degreesNight.widthAnchor.constraint(equalToConstant: 50)
        ]
        let dateConstrains = [
            date.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            date.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ]
        let dayOfWeekConstrains = [
            dayOfWeek.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            dayOfWeek.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ]
        NSLayoutConstraint.activate(iconConstrains)
        NSLayoutConstraint.activate(dayConstrains)
        NSLayoutConstraint.activate(nightConstrains)
        NSLayoutConstraint.activate(dateConstrains)
        NSLayoutConstraint.activate(dayOfWeekConstrains)
    }
}
