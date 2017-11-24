//
//  Created by ViXette on 23/11/2017.
//

import UIKit

class ImageCell: UITableViewCell {

	@IBOutlet weak var thumbnail: UIImageView!
	@IBOutlet weak var filename: UILabel!
	@IBOutlet weak var filesize: UILabel!
	@IBOutlet weak var md5: UILabel!
	
	func configureCell (image: UIImage, filename: String, filesize: String, md5: String) {
		thumbnail.image = image
		self.filename.text = filename
		self.filesize.text = "\(filesize) bytes"
		self.md5.text = md5
	}
	
}
