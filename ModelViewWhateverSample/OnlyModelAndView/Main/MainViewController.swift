import UIKit

class MainViewController: UIViewController {

    @IBOutlet var starButton: UIButton!
    @IBOutlet var navigateToSubViewButton: UIButton!

    private var viewHandler: MainViewHandler?
    private var model: StarModel?
    private var navigator: NavigatorProtocol?

    static func create(
        model: StarModel,
        navigator: NavigatorProtocol
    ) -> MainViewController? {
        let vc = UIStoryboard(name: "Main", bundle: nil)
            .instantiateInitialViewController() as? MainViewController
        vc?.model = model
        vc?.navigator = navigator

        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let model = self.model,
            let navigator = self.navigator else {
            return
        }

        self.viewHandler = MainViewHandler(
            handle: (
                starButton: starButton,
                navigateToSubViewButton: navigateToSubViewButton
            ),
            interchange: model,
            navigateBy: navigator
        )
    }

}
