import UIKit
import Photos

class PhotosCollectionViewController: UICollectionViewController {
  var assets: PHFetchResult<PHAsset>

  required init?(coder: NSCoder) {
    fatalError("init(coder:) not implemented.")
  }

  init?(assets: PHFetchResult<PHAsset>, title: String, coder: NSCoder) {
    self.assets = assets
    super.init(coder: coder)
    self.title = title
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    PHPhotoLibrary.shared().register(self)
  }

  deinit {
    PHPhotoLibrary.shared().unregisterChangeObserver(self)
  }

  @IBSegueAction func makePhotoViewController(_ coder: NSCoder) -> PhotoViewController? {
    guard let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first else { return nil }
    return PhotoViewController(asset: assets[selectedIndexPath.item], coder: coder)
  }

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return assets.count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier,
      for: indexPath) as? PhotoCollectionViewCell else {
        fatalError("Unable to dequeue PhotoCollectionViewCell")
    }
    let asset = assets[indexPath.item]
    cell.photoView.fetchImageAsset(asset, targetSize: cell.photoView.bounds.size, completionHandler: nil)
    return cell
  }
}

extension PhotosCollectionViewController: PHPhotoLibraryChangeObserver {
  func photoLibraryDidChange(_ changeInstance: PHChange) {
    // 1
    guard let change = changeInstance.changeDetails(for: assets) else {
      return
    }
    DispatchQueue.main.sync {
      // 2
      assets = change.fetchResultAfterChanges
      collectionView.reloadData()
    }
  }
}
