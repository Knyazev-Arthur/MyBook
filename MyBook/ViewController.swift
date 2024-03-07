import UIKit

class ViewController: UIViewController {
    
    private let myView = MyView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = myView
    }

}

