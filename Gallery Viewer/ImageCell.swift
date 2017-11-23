//
//  Created by ViXette on 23/11/2017.
//

import UIKit

class ImageCell: UITableViewCell {

	@IBOutlet weak var thumbnail: UIImageView!
	@IBOutlet weak var filename: UILabel!
	@IBOutlet weak var filesize: UILabel!

	func configureCell (image: UIImage, filename: String, filesize: String) {
		thumbnail.image = image
		self.filename.text = filename
		self.filesize.text = "\(filesize) bytes"
	}
	
}
