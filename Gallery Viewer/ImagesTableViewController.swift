//
//  Created by ViXette on 23/11/2017.
//

import UIKit
import Photos

class ImagesTableViewController: UITableViewController {

	var allPhotos: PHFetchResult<PHAsset>!
	
	var activityIndicatorView: UIActivityIndicatorView!
	let dispatchQueue = DispatchQueue(label: "Dispatch Queue", attributes: [], target: nil)
	
	
	override func viewDidLoad() {
		super.viewDidLoad()

		activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
		tableView.backgroundView = activityIndicatorView
		
		activityIndicatorView.startAnimating()
		tableView.separatorStyle = .none
		
		dispatchQueue.async {
			OperationQueue.main.addOperation() {
				let allPhotosOptions = PHFetchOptions()
				allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
				self.allPhotos = PHAsset.fetchAssets(with: allPhotosOptions)
				
				self.tableView.separatorStyle = .singleLine
				self.activityIndicatorView.stopAnimating()
				
				self.tableView.reloadData()
			}
		}
	}
	
	
	func getAssetThumbnail(asset: PHAsset) -> UIImage {
		let manager = PHImageManager.default()
		let option = PHImageRequestOptions()
		var thumbnail = UIImage()
		
		option.isSynchronous = true
		manager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
			thumbnail = result!
		})
		
		return thumbnail
	}
	
	
	func getAssetFilesize(asset: PHAsset) -> Int64 {
		let resources = PHAssetResource.assetResources(for: asset)
		var sizeOnDisk: Int64? = 0
		
		if let resource = resources.first {
			let unsignedInt64 = resource.value(forKey: "fileSize") as? CLong
			sizeOnDisk = Int64(bitPattern: UInt64(unsignedInt64!))
		}

		return sizeOnDisk ?? 0
	}

	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return (allPhotos == nil) ? 0 : 1
	}
	
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return allPhotos.count
	}
	

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell") as? ImageCell else { return UITableViewCell () }
		
		cell.configureCell(
			image: getAssetThumbnail(asset: allPhotos[indexPath.row]),
			filename: allPhotos[indexPath.row].originalFilename!,
			filesize: String(getAssetFilesize(asset: allPhotos[indexPath.row]))
		)
	
		return cell
	}
	
}
