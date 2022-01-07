import UIKit

final class DaysWeatherTableViewCell: UITableViewCell {
    
    var date: UILabel = {
        let label = UILabel()
        label.text = "7 January"
        label.textColor = .white.withAlphaComponent(0.5)
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var dayOfWeek: UILabel = {
        let label = UILabel()
        label.text = "Thursday"
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
    
    var degreesDay: UILabel = {
        let label = UILabel()
        label.text = "-5°"
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .subheadline).withSize(30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var degreesNight: UILabel = {
        let label = UILabel()
        label.text = "-8°"
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .subheadline).withSize(30)
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
            degreesDay.centerXAnchor.constraint(equalTo: centerXAnchor)
        ]
        let nightConstrains = [
            degreesNight.centerYAnchor.constraint(equalTo: centerYAnchor),
            degreesNight.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 75)
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
