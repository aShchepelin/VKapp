// PhotoService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation

/// Протокол для унифицирования обновлений
protocol DataReloadable {
    func reloadRow(atIndexpath indexPath: IndexPath)
}

/// Сервис для загрузки и кэширования фотографий
final class PhotoService {
    // MARK: - Constants

    private enum Constants {
        static let imagesText = "images"
        static let cacheLifeTime = 30.0 * 24.0 * 60.0 * 60.0
        static let separatorText: Character = "/"
        static let defaultText: Substring = "default"
        static let fileManagerDefault = FileManager.default
    }

    // MARK: - Private Properties

    private let cacheLifeTime: TimeInterval = Constants.cacheLifeTime
    private let container: DataReloadable

    private static let pathName: String = {
        let pathName = Constants.imagesText
        guard
            let cachesDirectory = Constants.fileManagerDefault.urls(for: .cachesDirectory, in: .userDomainMask).first
        else { return pathName }
        let url = cachesDirectory.appendingPathComponent(pathName, isDirectory: true)
        if !Constants.fileManagerDefault.fileExists(atPath: url.path) {
            try? Constants.fileManagerDefault.createDirectory(
                at: url,
                withIntermediateDirectories: true,
                attributes: nil
            )
        }
        return pathName
    }()

    private var imagesMap: [String: UIImage] = [:]

    // MARK: - Initializers

    init(container: UICollectionView) {
        self.container = Collection(collectionView: container)
    }

    init(container: UICollectionViewController) {
        self.container = CollectionViewController(collectionViewController: container)
    }

    // MARK: - Public Methods

    func photo(atIndexpath indexPath: IndexPath, byUrl url: String) -> UIImage? {
        var image: UIImage?
        if let photo = imagesMap[url] {
            image = photo
        } else if let photo = getImageFromCache(url: url) {
            image = photo
        } else {
            loadPhoto(atIndexpath: indexPath, byUrl: url)
        }
        return image
    }

    // MARK: - Private Methods

    private func getFilePath(url: String) -> String? {
        guard
            let cachesDirectory = Constants.fileManagerDefault.urls(for: .cachesDirectory, in: .userDomainMask).first
        else { return nil }
        let hashName = url.split(separator: Constants.separatorText).last ?? Constants.defaultText
        return cachesDirectory.appendingPathComponent("\(PhotoService.pathName)\(Constants.separatorText)\(hashName)")
            .path
    }

    private func saveImageToCache(url: String, image: UIImage) {
        guard
            let fileName = getFilePath(url: url),
            let data = image.pngData()
        else { return }
        Constants.fileManagerDefault.createFile(atPath: fileName, contents: data, attributes: nil)
    }

    private func getImageFromCache(url: String) -> UIImage? {
        guard
            let fileName = getFilePath(url: url),
            let info = try? Constants.fileManagerDefault.attributesOfItem(atPath: fileName),
            let modificationDate = info[FileAttributeKey.modificationDate] as? Date
        else { return nil }
        let lifeTime = Date().timeIntervalSince(modificationDate)
        guard
            lifeTime <= cacheLifeTime,
            let image = UIImage(contentsOfFile: fileName)
        else { return nil }
        DispatchQueue.main.async {
            self.imagesMap[url] = image
        }
        return image
    }

    private func loadPhoto(atIndexpath indexPath: IndexPath, byUrl url: String) {
        AF.request(url).responseData(queue: DispatchQueue.global()) { [weak self] response in
            guard
                let data = response.data,
                let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self?.imagesMap[url] = image
            }
            self?.saveImageToCache(url: url, image: image)
            DispatchQueue.main.async {
                self?.container.reloadRow(atIndexpath: indexPath)
            }
        }
    }
}
