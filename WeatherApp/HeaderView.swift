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
    
    private func setupViews() {
        addSubview(town)
        addSubview(icon)
        addSubview(desc)
        addSubview(feels)
        addSubview(degrees)
        addSubview(separator)
        constrains()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
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
