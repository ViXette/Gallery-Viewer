//
//  Created by ViXette on 23/11/2017.
//

import Foundation
import Photos

extension PHAsset {

	var originalFilename: String? {
		var fname:String?
		
		if #available(iOS 9.0, *) {
			let resources = PHAssetResource.assetResources(for: self)
			if let resource = resources.first {
				fname = resource.originalFilename
			}
		}
		
		if fname == nil {
			fname = self.value(forKey: "filename") as? String
		}
		
		return fname 
	}
	
}
