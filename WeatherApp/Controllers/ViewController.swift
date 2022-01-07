import UIKit

class ViewController: UIViewController {
    
    private var itemsForCollection = Array<HourlyWeather>()
    private var itemsForTable = Array<DailyWeather>()
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        return formatter
    }()
    
    private let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.register(UITableViewCell.self, forCellReuseIdentifier: "simplecell")
        view.register(HoursWeatherCell.self, forCellReuseIdentifier: "cell")
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentLocation = LocationService.shared.currentLocation
        configure()
        APIClient.shared.reverseGeoCoding(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude, completion: { [self] result in
            switch result {
            case .success(let string):
                DispatchQueue.main.async {
                    headerView.town.text = string
                }
            case .failure(let error):
                print(error)
            }
            
        })
        
        APIClient.shared.oneCall(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude, completion: { [self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    headerView.degrees.text = "\(Int(data.current.temp)) °C"
                    headerView.feels.text = "Feels like \(Int(data.current.feels_like)) °C"
                    headerView.desc.text = data.current.weather[0].description
                    switch data.current.weather[0].main {
                    case "Snow":
                        headerView.icon.image = UIImage(named: "snow.png")
                    case "Clouds":
                        headerView.icon.image = UIImage(named: "clouds.png")
                    default:
                        headerView.icon.image = UIImage(named: "sun.png")
                    }
                    itemsForCollection = data.hourly
                    itemsForTable = data.daily
                    collectionCell.collection.reloadData()
                    tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        })
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
        
        headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 300))
        tableView.tableHeaderView = headerView
        tableView.backgroundColor = .clear
        navigationController?.navigationBar.backgroundColor = .clear
        setGradientBackground()
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
    
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsForTable.count + 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = collectionCell
            cell.collection.dataSource = self
            cell.collection.delegate = self
            return cell
        case 1...itemsForTable.count:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "dayscell") as? DaysWeatherTableViewCell else {
                return DaysWeatherTableViewCell()
            }
            cell.isUserInteractionEnabled = false
            switch itemsForTable[indexPath.row-1].weather[0].main {
            case "Snow":
                cell.icon.image = UIImage(named: "snow.png")
            case "Clouds":
                cell.icon.image = UIImage(named: "clouds.png")
            default:
                cell.icon.image = UIImage(named: "sun.png")
            }
            dateFormatter.dateFormat = "D MMMM"
            cell.date.text = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(itemsForTable[indexPath.row-1].dt)))
            dateFormatter.dateFormat = "EEEE"
            cell.dayOfWeek.text = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(itemsForTable[indexPath.row-1].dt)))
            cell.degreesDay.text = "\(Int(itemsForTable[indexPath.row-1].temp.day))°"
            cell.degreesNight.text = "\(Int(itemsForTable[indexPath.row-1].temp.night))°"
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
        return itemsForCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionCell.collection.dequeueReusableCell(withReuseIdentifier: "collectioncell", for: indexPath) as! WeatherCollectionViewCell
        cell.backgroundColor = .clear
        cell.degrees.text = "\(Int(itemsForCollection[indexPath.row].temp))°C"
        dateFormatter.dateFormat = "HH:mm"
        cell.time.text = dateFormatter.string(from: NSDate(timeIntervalSince1970: TimeInterval(itemsForCollection[indexPath.row].dt)) as Date)
        switch itemsForCollection[indexPath.row].weather[0].main {
        case "Snow":
            cell.icon.image = UIImage(named: "snow.png")
        case "Clouds":
            cell.icon.image = UIImage(named: "clouds.png")
        default:
            cell.icon.image = UIImage(named: "sun.png")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5.0
    }
    
    
}

