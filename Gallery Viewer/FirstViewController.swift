//
//  Created by ViXette on 24/11/2017.
//

import UIKit
import Photos

class FirstViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let photos = PHPhotoLibrary.authorizationStatus()
		if photos == .notDetermined {
			PHPhotoLibrary.requestAuthorization({status in
			})
		}
	}
	
}
