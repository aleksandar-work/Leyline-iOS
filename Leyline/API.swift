// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetUserInfoQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetUserInfo {
      user {
        __typename
        leylinePoints
        dailySleepAvailable
        dailyExerciseAvailable
      }
    }
    """

  public let operationName: String = "GetUserInfo"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("user", type: .object(User.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(user: User? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "user": user.flatMap { (value: User) -> ResultMap in value.resultMap }])
    }

    public var user: User? {
      get {
        return (resultMap["user"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "user")
      }
    }

    public struct User: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("leylinePoints", type: .scalar(Int.self)),
          GraphQLField("dailySleepAvailable", type: .scalar(Bool.self)),
          GraphQLField("dailyExerciseAvailable", type: .scalar(Bool.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(leylinePoints: Int? = nil, dailySleepAvailable: Bool? = nil, dailyExerciseAvailable: Bool? = nil) {
        self.init(unsafeResultMap: ["__typename": "User", "leylinePoints": leylinePoints, "dailySleepAvailable": dailySleepAvailable, "dailyExerciseAvailable": dailyExerciseAvailable])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var leylinePoints: Int? {
        get {
          return resultMap["leylinePoints"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "leylinePoints")
        }
      }

      public var dailySleepAvailable: Bool? {
        get {
          return resultMap["dailySleepAvailable"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "dailySleepAvailable")
        }
      }

      public var dailyExerciseAvailable: Bool? {
        get {
          return resultMap["dailyExerciseAvailable"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "dailyExerciseAvailable")
        }
      }
    }
  }
}

public final class IsSleepAvailableQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query IsSleepAvailable {
      user {
        __typename
        dailySleepAvailable
      }
    }
    """

  public let operationName: String = "IsSleepAvailable"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("user", type: .object(User.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(user: User? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "user": user.flatMap { (value: User) -> ResultMap in value.resultMap }])
    }

    public var user: User? {
      get {
        return (resultMap["user"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "user")
      }
    }

    public struct User: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("dailySleepAvailable", type: .scalar(Bool.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(dailySleepAvailable: Bool? = nil) {
        self.init(unsafeResultMap: ["__typename": "User", "dailySleepAvailable": dailySleepAvailable])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var dailySleepAvailable: Bool? {
        get {
          return resultMap["dailySleepAvailable"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "dailySleepAvailable")
        }
      }
    }
  }
}

public final class IsExerciseAvailableQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query IsExerciseAvailable {
      user {
        __typename
        dailyExerciseAvailable
      }
    }
    """

  public let operationName: String = "IsExerciseAvailable"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("user", type: .object(User.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(user: User? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "user": user.flatMap { (value: User) -> ResultMap in value.resultMap }])
    }

    public var user: User? {
      get {
        return (resultMap["user"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "user")
      }
    }

    public struct User: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("dailyExerciseAvailable", type: .scalar(Bool.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(dailyExerciseAvailable: Bool? = nil) {
        self.init(unsafeResultMap: ["__typename": "User", "dailyExerciseAvailable": dailyExerciseAvailable])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var dailyExerciseAvailable: Bool? {
        get {
          return resultMap["dailyExerciseAvailable"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "dailyExerciseAvailable")
        }
      }
    }
  }
}

public final class DailyExerciseMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation DailyExercise {
      dailyExercise
    }
    """

  public let operationName: String = "DailyExercise"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("dailyExercise", type: .scalar(Bool.self)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(dailyExercise: Bool? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "dailyExercise": dailyExercise])
    }

    public var dailyExercise: Bool? {
      get {
        return resultMap["dailyExercise"] as? Bool
      }
      set {
        resultMap.updateValue(newValue, forKey: "dailyExercise")
      }
    }
  }
}

public final class DailySleepMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation DailySleep {
      dailySleep
    }
    """

  public let operationName: String = "DailySleep"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("dailySleep", type: .scalar(Bool.self)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(dailySleep: Bool? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "dailySleep": dailySleep])
    }

    public var dailySleep: Bool? {
      get {
        return resultMap["dailySleep"] as? Bool
      }
      set {
        resultMap.updateValue(newValue, forKey: "dailySleep")
      }
    }
  }
}
