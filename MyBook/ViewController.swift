import UIKit

class ViewController: UIViewController {
    
    private let myView: MyViewProtocol
    
    init() {
        myView = MyView()
        super.init(nibName: nil, bundle: nil)
        myView.viewController = self
        view.addSubview(myView)
        setupMyViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupMyViewConstraints() {
        myView.translatesAutoresizingMaskIntoConstraints = false
        
        let leading = myView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        let trailing = myView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        let top = myView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        let bottom = myView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        
        NSLayoutConstraint.activate([leading, trailing, top, bottom])
    }


}

