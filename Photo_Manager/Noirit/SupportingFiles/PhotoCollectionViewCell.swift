import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
  static let reuseIdentifier = "photoCell"
  @IBOutlet weak var photoView: UIImageView!
  @IBOutlet weak var livePhotoIndicator: UIImageView!

  override func prepareForReuse() {
    super.prepareForReuse()
    photoView.image = nil
    livePhotoIndicator.isHidden = true
  }
}
