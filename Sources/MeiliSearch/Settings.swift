import Foundation
#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif

/**
 Settings is a list of all the customization possible for an index.
 */
struct Settings {
  // MARK: Properties

  let request: Request

  // MARK: Initializers

  init (_ request: Request) {
    self.request = request
  }

  // MARK: All Settings

  func get(
    _ uid: String,
    _ completion: @escaping (Result<SettingResult, Swift.Error>) -> Void) {
      
    getSetting(uid: uid, key: nil, completion: completion)
  }

  func update(
    _ uid: String,
    _ setting: Setting,
    _ completion: @escaping (Result<TaskInfo, Swift.Error>) -> Void) {

    let data: Data
    do {
      data = try JSONEncoder().encode(setting)
    } catch {
      completion(.failure(error))
      return
    }

    self.request.patch(api: "/indexes/\(uid)/settings", data) { result in
      switch result {
      case .success(let data):
        do {
          let task: TaskInfo = try Constants.customJSONDecoder.decode(TaskInfo.self, from: data)
          completion(.success(task))
        } catch {
          completion(.failure(error))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  // can this be refactor
  func reset(
    _ uid: String,
    _ completion: @escaping (Result<TaskInfo, Swift.Error>) -> Void) {

    resetSetting(uid: uid, key: nil, completion: completion)
  }

  // MARK: Synonyms

  func getSynonyms(
    _ uid: String,
    _ completion: @escaping (Result<[String: [String]], Swift.Error>) -> Void) {

    getSetting(uid: uid, key: "synonyms", completion: completion)
  }

  func updateSynonyms(
    _ uid: String,
    _ synonyms: [String: [String]]? = [:],
    _ completion: @escaping (Result<TaskInfo, Swift.Error>) -> Void) {

    let data: Data
    do {
      data = try JSONEncoder().encode(synonyms)
    } catch {
      completion(.failure(error))
      return
    }
    self.request.put(api: "/indexes/\(uid)/settings/synonyms", data) { result in
      switch result {
      case .success(let data):
        do {
          let task: TaskInfo = try Constants.customJSONDecoder.decode(TaskInfo.self, from: data)
          completion(.success(task))
        } catch {
          completion(.failure(error))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func resetSynonyms(
    _ uid: String,
    _ completion: @escaping (Result<TaskInfo, Swift.Error>) -> Void) {

    resetSetting(uid: uid, key: "synonyms", completion: completion)
  }

  // MARK: Stop Words

  func getStopWords(
    _ uid: String,
    _ completion: @escaping (Result<[String], Swift.Error>) -> Void) {
      
    getSetting(uid: uid, key: "stop-words", completion: completion)
  }

  func updateStopWords(
    _ uid: String,
    _ stopWords: [String]? = [],
    _ completion: @escaping (Result<TaskInfo, Swift.Error>) -> Void) {

    let data: Data
    do {
      data = try JSONEncoder().encode(stopWords)
    } catch {
      completion(.failure(error))
      return
    }
    self.request.put(api: "/indexes/\(uid)/settings/stop-words", data) { result in
      switch result {
      case .success(let data):
        do {
          let task: TaskInfo = try Constants.customJSONDecoder.decode(TaskInfo.self, from: data)
          completion(.success(task))
        } catch {
          completion(.failure(error))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func resetStopWords(
    _ uid: String,
    _ completion: @escaping (Result<TaskInfo, Swift.Error>) -> Void) {

    resetSetting(uid: uid, key: "stop-words", completion: completion)
  }

  // MARK: Ranking

  func getRankingRules(
    _ uid: String,
    _ completion: @escaping (Result<[String], Swift.Error>) -> Void) {
      
    getSetting(uid: uid, key: "ranking-rules", completion: completion)
  }

  func updateRankingRules(
    _ uid: String,
    _ rankingRules: [String],
    _ completion: @escaping (Result<TaskInfo, Swift.Error>) -> Void) {

    let data: Data
    do {
      data = try JSONSerialization.data(withJSONObject: rankingRules, options: [])
    } catch {
      completion(.failure(error))
      return
    }

    self.request.put(api: "/indexes/\(uid)/settings/ranking-rules", data) { result in
      switch result {
      case .success(let data):
        do {
          let task: TaskInfo = try Constants.customJSONDecoder.decode(TaskInfo.self, from: data)
          completion(.success(task))
        } catch {
          completion(.failure(error))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func resetRankingRules(
    _ uid: String,
    _ completion: @escaping (Result<TaskInfo, Swift.Error>) -> Void) {

    resetSetting(uid: uid, key: "ranking-rules", completion: completion)
  }

  // MARK: Distinct attribute

  func getDistinctAttribute(
    _ uid: String,
    _ completion: @escaping (Result<String?, Swift.Error>) -> Void) {

    getSetting(uid: uid, key: "distinct-attribute", completion: completion)
  }

  func updateDistinctAttribute(
    _ uid: String,
    _ distinctAttribute: String,
    _ completion: @escaping (Result<TaskInfo, Swift.Error>) -> Void) {

    let data: Data
    do {
      data = try JSONEncoder().encode(distinctAttribute)
    } catch {
      completion(.failure(error))
      return
    }

    self.request.put(api: "/indexes/\(uid)/settings/distinct-attribute", data) { result in
      switch result {
      case .success(let data):
        do {
          let task: TaskInfo = try Constants.customJSONDecoder.decode(TaskInfo.self, from: data)
          completion(.success(task))
        } catch {
          completion(.failure(error))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func resetDistinctAttribute(
    _ uid: String,
    _ completion: @escaping (Result<TaskInfo, Swift.Error>) -> Void) {

    resetSetting(uid: uid, key: "distinct-attribute", completion: completion)
  }

  // MARK: Searchable attributes

  func getSearchableAttributes(
    _ uid: String,
    _ completion: @escaping (Result<[String], Swift.Error>) -> Void) {

    getSetting(uid: uid, key: "searchable-attributes", completion: completion)
  }

  func updateSearchableAttributes(
    _ uid: String,
    _ searchableAttributes: [String],
    _ completion: @escaping (Result<TaskInfo, Swift.Error>) -> Void) {

    let data: Data
    do {
      data = try JSONSerialization.data(withJSONObject: searchableAttributes, options: [])
    } catch {
      completion(.failure(error))
      return
    }
    self.request.put(api: "/indexes/\(uid)/settings/searchable-attributes", data) { result in
      switch result {
      case .success(let data):
        do {
          let task: TaskInfo = try Constants.customJSONDecoder.decode(TaskInfo.self, from: data)
          completion(.success(task))
        } catch {
          completion(.failure(error))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func resetSearchableAttributes(
    _ uid: String,
    _ completion: @escaping (Result<TaskInfo, Swift.Error>) -> Void) {

    resetSetting(uid: uid, key: "searchable-attributes", completion: completion)
  }

  // MARK: Displayed attributes

  func getDisplayedAttributes(
    _ uid: String,
    _ completion: @escaping (Result<[String], Swift.Error>) -> Void) {

    getSetting(uid: uid, key: "displayed-attributes", completion: completion)
  }

  func updateDisplayedAttributes(
    _ uid: String,
    _ displayedAttributes: [String],
    _ completion: @escaping (Result<TaskInfo, Swift.Error>) -> Void) {

    let data: Data
    do {
      data = try JSONSerialization.data(withJSONObject: displayedAttributes, options: [])
    } catch {
      completion(.failure(error))
      return
    }
    self.request.put(api: "/indexes/\(uid)/settings/displayed-attributes", data) { result in
      switch result {
      case .success(let data):
        do {
          let task: TaskInfo = try Constants.customJSONDecoder.decode(TaskInfo.self, from: data)
          completion(.success(task))
        } catch {
          completion(.failure(error))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func resetDisplayedAttributes(
    _ uid: String,
    _ completion: @escaping (Result<TaskInfo, Swift.Error>) -> Void) {

    resetSetting(uid: uid, key: "displayed-attributes", completion: completion)
  }

  // MARK: Filterable Attributes

  func getFilterableAttributes(
    _ uid: String,
    _ completion: @escaping (Result<[String], Swift.Error>) -> Void) {

    getSetting(uid: uid, key: "filterable-attributes", completion: completion)
  }

  func updateFilterableAttributes(
    _ uid: String,
    _ attributes: [String],
    _ completion: @escaping (Result<TaskInfo, Swift.Error>) -> Void) {

    let data: Data
    do {
      data = try JSONSerialization.data(withJSONObject: attributes, options: [])
    } catch {
      completion(.failure(error))
      return
    }

    self.request.put(api: "/indexes/\(uid)/settings/filterable-attributes", data) { result in
      switch result {
      case .success(let data):
        do {
          let task: TaskInfo = try Constants.customJSONDecoder.decode(TaskInfo.self, from: data)
          completion(.success(task))
        } catch {
          completion(.failure(error))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func resetFilterableAttributes(
    _ uid: String,
    _ completion: @escaping (Result<TaskInfo, Swift.Error>) -> Void) {

    resetSetting(uid: uid, key: "filterable-attributes", completion: completion)
  }

  // MARK: Sortable Attributes

  func getSortableAttributes(
    _ uid: String,
    _ completion: @escaping (Result<[String], Swift.Error>) -> Void) {

    getSetting(uid: uid, key: "sortable-attributes", completion: completion)
  }

  func updateSortableAttributes(
    _ uid: String,
    _ attributes: [String],
    _ completion: @escaping (Result<TaskInfo, Swift.Error>) -> Void) {

    let data: Data
    do {
      data = try JSONSerialization.data(withJSONObject: attributes, options: [])
    } catch {
      completion(.failure(error))
      return
    }

    self.request.put(api: "/indexes/\(uid)/settings/sortable-attributes", data) { result in
      switch result {
      case .success(let data):
        do {
          let task: TaskInfo = try Constants.customJSONDecoder.decode(TaskInfo.self, from: data)
          completion(.success(task))
        } catch {
          completion(.failure(error))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func resetSortableAttributes(
    _ uid: String,
    _ completion: @escaping (Result<TaskInfo, Swift.Error>) -> Void) {

    resetSetting(uid: uid, key: "sortable-attributes", completion: completion)
  }

  // MARK: Reusable Requests
  
  private func getSetting<ResponseType: Decodable>(
    uid: String,
    key: String?,
    completion: @escaping (Result<ResponseType, Swift.Error>) -> Void
  ) {
    // if a key is provided, path is equal to `/<key>`, else it's an empty string
    let path = key.map { "/" + $0 } ?? ""
    self.request.get(api: "/indexes/\(uid)/settings\(path)") { result in
      switch result {
      case .success(let data):
        guard let data: Data = data else {
          completion(.failure(MeiliSearch.Error.dataNotFound))
          return
        }
        do {
          let array: ResponseType = try Constants.customJSONDecoder.decode(ResponseType.self, from: data)
          completion(.success(array))
        } catch {
          completion(.failure(error))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  private func resetSetting(
    uid: String,
    key: String?,
    completion: @escaping (Result<TaskInfo, Swift.Error>) -> Void
  ) {
    // if a key is provided, path is equal to `/<key>`, else it's an empty string
    let path = key.map { "/" + $0 } ?? ""
    self.request.delete(api: "/indexes/\(uid)/settings\(path)") { result in
      switch result {
      case .success(let data):
        guard let data: Data = data else {
          completion(.failure(MeiliSearch.Error.dataNotFound))
          return
        }
        do {
          let task: TaskInfo = try Constants.customJSONDecoder.decode(TaskInfo.self, from: data)
          completion(.success(task))
        } catch {
          completion(.failure(error))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}
