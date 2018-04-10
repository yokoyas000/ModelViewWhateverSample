import UIKit

class MainViewController: UIViewController {

    @IBOutlet var starButton: UIButton!
    @IBOutlet var navigateToSubViewButton: UIButton!

    private var viewHandler: MainViewHandler?
    private let model = StarModel(initialStared: false)

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewHandler = MainViewHandler(
            handle: (
                starButton: starButton,
                navigateToSubViewButton: navigateToSubViewButton
            ),
            notify: self.model,
            navigateBy: Navigater(using: self)
        )
    }

}
