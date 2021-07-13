enum AlbumCollectionSectionType: Int, CustomStringConvertible {
  case all, smartAlbums, userCollections

  var description: String {
    switch self {
    case .all: return "All Photos"
    case .smartAlbums: return "Smart Albums"
    case .userCollections: return "User Collections"
    }
  }
}
