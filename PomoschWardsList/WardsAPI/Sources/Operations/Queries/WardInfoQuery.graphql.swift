// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class WardInfoQuery: GraphQLQuery {
  public static let operationName: String = "WardInfo"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query WardInfo($id: ID!) { wardById(id: $id) { __typename id publicInformation { __typename name { __typename displayName } photo { __typename url } story } } }"#
    ))

  public var id: ID

  public init(id: ID) {
    self.id = id
  }

  public var __variables: Variables? { ["id": id] }

  public struct Data: WardsAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { WardsAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("wardById", WardById?.self, arguments: ["id": .variable("id")]),
    ] }

    /// Подопечный с указанным идентификатором
    public var wardById: WardById? { __data["wardById"] }

    /// WardById
    ///
    /// Parent Type: `Ward`
    public struct WardById: WardsAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { WardsAPI.Objects.Ward }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", WardsAPI.ID.self),
        .field("publicInformation", PublicInformation.self),
      ] }

      /// Уникальный идентификатор
      public var id: WardsAPI.ID { __data["id"] }
      /// Общедоступная информация о подопечном
      public var publicInformation: PublicInformation { __data["publicInformation"] }

      /// WardById.PublicInformation
      ///
      /// Parent Type: `WardPublicInformation`
      public struct PublicInformation: WardsAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { WardsAPI.Objects.WardPublicInformation }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("name", Name.self),
          .field("photo", Photo.self),
          .field("story", String.self),
        ] }

        /// Имя
        public var name: Name { __data["name"] }
        /// Фотография подопечного
        public var photo: Photo { __data["photo"] }
        /// История подопечного
        public var story: String { __data["story"] }

        /// WardById.PublicInformation.Name
        ///
        /// Parent Type: `Nomen`
        public struct Name: WardsAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { WardsAPI.Objects.Nomen }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("displayName", String.self),
          ] }

          /// Имя для отображения (Имя Фамилия)
          public var displayName: String { __data["displayName"] }
        }

        /// WardById.PublicInformation.Photo
        ///
        /// Parent Type: `FileInformation`
        public struct Photo: WardsAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { WardsAPI.Objects.FileInformation }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("url", String.self),
          ] }

          /// Ссылка для отображения или скачивания файла
          public var url: String { __data["url"] }
        }
      }
    }
  }
}
