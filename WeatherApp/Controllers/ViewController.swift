import UIKit
import CoreLocation

class ViewController: UIViewController {
    private var hourlyItems = Array<HourlyWeather>()
    private var dailyItems = Array<DailyWeather>()
    
    private let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.register(UITableViewCell.self, forCellReuseIdentifier: "simplecell")
        view.register(DaysWeatherTableViewCell.self, forCellReuseIdentifier: "dayscell")
        view.backgroundColor = .clear
        view.separatorStyle = .singleLine
        view.separatorColor = .white
        
        return view
    }()
    
    private var headerView: HeaderView!
    private let collectionCell: HoursWeatherCell = {
        return HoursWeatherCell()
    }()
    
    private let refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.attributedTitle = NSAttributedString(string: "Updating data")
        control.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        return control
    }()
    
    private let barButtonItem: UIBarButtonItem = {
        let item = UIBarButtonItem(image: UIImage(named: "burger.png"), style: UIBarButtonItem.Style.done, target: self, action: #selector(menuBarButtonTapped))
        item.tintColor = .white
        return item
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        refresh(self)
    }
    
    @objc
    func menuBarButtonTapped() {
        
    }
    
    @objc
    func refresh(_ sender: Any) {
        LocationService.shared.updateLocation()
        APIClient.shared.reverseGeoCoding(LocationService.shared.currentLocation.coordinate.latitude, LocationService.shared.currentLocation.coordinate.longitude, completion: { [self] result in
            switch result {
            case .success(let string):
                DispatchQueue.main.async {
                    headerView.setCity(string)
                }
            case .failure(let error):
                print(error)
            }
            
        })
        
        APIClient.shared.oneCall(LocationService.shared.currentLocation.coordinate.latitude, LocationService.shared.currentLocation.coordinate.longitude, completion: { [self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    headerView.configure(with: data.current)
                    hourlyItems = data.hourly
                    dailyItems = data.daily
                    collectionCell.collection.reloadData()
                    tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        })
        refreshControl.endRefreshing()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configure() {
        view.backgroundColor = UIColor(patternImage: UIImage())
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.addSubview(refreshControl)
        headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 300))
        tableView.tableHeaderView = headerView
        tableView.backgroundColor = .clear
        setGradientBackground()
        setupNavigationBar()
    }
    
    private func setGradientBackground() {
        let colorTop =  UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 58.0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .clear
        navigationItem.leftBarButtonItem = barButtonItem
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithTransparentBackground()
        navigationItem.scrollEdgeAppearance = navigationBarAppearance
        navigationItem.standardAppearance = navigationBarAppearance
        navigationItem.compactAppearance = navigationBarAppearance
    }
    
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyItems.count + 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = collectionCell
            cell.collection.dataSource = self
            cell.collection.delegate = self
            return cell
        case 1...dailyItems.count:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "dayscell") as? DaysWeatherTableViewCell else {
                return DaysWeatherTableViewCell()
            }
            cell.configure(with: dailyItems[indexPath.row-1])
            cell.isUserInteractionEnabled = false
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "simplecell") else {
                return UITableViewCell()
            }
            cell.isUserInteractionEnabled = false
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 125
        default:
            return 50
        }
    }
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 100, height: collectionView.frame.height)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionCell.collection.dequeueReusableCell(withReuseIdentifier: "collectioncell", for: indexPath) as! WeatherCollectionViewCell
        cell.configure(with: hourlyItems[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5.0
    }
    
    
}
