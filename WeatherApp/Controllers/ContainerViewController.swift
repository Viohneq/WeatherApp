import UIKit

class ContainerViewController: UIViewController {
    
    
    
    let mainVC = ViewController()
    let sidebarVC = SideBarViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
    }
    
    func configureViewControllers() {
        let navigationController = UINavigationController(rootViewController:mainVC)
        addChild(navigationController)
        view.addSubview(navigationController.view)
        navigationController.didMove(toParent: self)
    }
}
