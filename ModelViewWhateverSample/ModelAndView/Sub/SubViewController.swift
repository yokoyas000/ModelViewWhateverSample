import UIKit

class SubViewController: UIViewController {

    @IBOutlet var starButton: UIButton!
    private var viewHandler: SubViewHandler!
    private var model: StarModel!

    static func create(model: StarModel) -> SubViewController? {
        let storyboard = UIStoryboard(name: "Sub", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as? SubViewController
        vc?.model = model

        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewHandler = SubViewHandler(
            handle: self.starButton,
            notifyTo: self.model
        )
    }

}
