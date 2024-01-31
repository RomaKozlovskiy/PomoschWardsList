// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class WardsListQuery: GraphQLQuery {
  public static let operationName: String = "WardsList"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query WardsList($first: Int, $after: String, $order: SortEnumType!) { wards( first: $first after: $after order: { publicInformation: { name: { displayName: $order } } } ) { __typename edges { __typename node { __typename id publicInformation { __typename name { __typename displayName } dateOfBirth dateOfDeath city photo { __typename url(variant: "small") } story } } cursor } pageInfo { __typename startCursor endCursor hasNextPage } } }"#
    ))

  public var first: GraphQLNullable<Int>
  public var after: GraphQLNullable<String>
  public var order: GraphQLEnum<SortEnumType>

  public init(
    first: GraphQLNullable<Int>,
    after: GraphQLNullable<String>,
    order: GraphQLEnum<SortEnumType>
  ) {
    self.first = first
    self.after = after
    self.order = order
  }

  public var __variables: Variables? { [
    "first": first,
    "after": after,
    "order": order
  ] }

  public struct Data: WardsAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { WardsAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("wards", Wards?.self, arguments: [
        "first": .variable("first"),
        "after": .variable("after"),
        "order": ["publicInformation": ["name": ["displayName": .variable("order")]]]
      ]),
    ] }

    /// Подопечные
    public var wards: Wards? { __data["wards"] }

    /// Wards
    ///
    /// Parent Type: `WardsConnection`
    public struct Wards: WardsAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { WardsAPI.Objects.WardsConnection }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("edges", [Edge]?.self),
        .field("pageInfo", PageInfo.self),
      ] }

      /// A list of edges.
      public var edges: [Edge]? { __data["edges"] }
      /// Information to aid in pagination.
      public var pageInfo: PageInfo { __data["pageInfo"] }

      /// Wards.Edge
      ///
      /// Parent Type: `WardsEdge`
      public struct Edge: WardsAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { WardsAPI.Objects.WardsEdge }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("node", Node.self),
          .field("cursor", String.self),
        ] }

        /// The item at the end of the edge.
        public var node: Node { __data["node"] }
        /// A cursor for use in pagination.
        public var cursor: String { __data["cursor"] }

        /// Wards.Edge.Node
        ///
        /// Parent Type: `Ward`
        public struct Node: WardsAPI.SelectionSet {
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

          /// Wards.Edge.Node.PublicInformation
          ///
          /// Parent Type: `WardPublicInformation`
          public struct PublicInformation: WardsAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { WardsAPI.Objects.WardPublicInformation }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("name", Name.self),
              .field("dateOfBirth", WardsAPI.Date.self),
              .field("dateOfDeath", WardsAPI.Date?.self),
              .field("city", String.self),
              .field("photo", Photo.self),
              .field("story", String.self),
            ] }

            /// Имя
            public var name: Name { __data["name"] }
            /// Дата рождения
            public var dateOfBirth: WardsAPI.Date { __data["dateOfBirth"] }
            /// Дата смерти
            public var dateOfDeath: WardsAPI.Date? { __data["dateOfDeath"] }
            /// Населённый пункт проживания
            public var city: String { __data["city"] }
            /// Фотография подопечного
            public var photo: Photo { __data["photo"] }
            /// История подопечного
            public var story: String { __data["story"] }

            /// Wards.Edge.Node.PublicInformation.Name
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

            /// Wards.Edge.Node.PublicInformation.Photo
            ///
            /// Parent Type: `FileInformation`
            public struct Photo: WardsAPI.SelectionSet {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public static var __parentType: ApolloAPI.ParentType { WardsAPI.Objects.FileInformation }
              public static var __selections: [ApolloAPI.Selection] { [
                .field("__typename", String.self),
                .field("url", String.self, arguments: ["variant": "small"]),
              ] }

              /// Ссылка для отображения или скачивания файла
              public var url: String { __data["url"] }
            }
          }
        }
      }

      /// Wards.PageInfo
      ///
      /// Parent Type: `PageInfo`
      public struct PageInfo: WardsAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { WardsAPI.Objects.PageInfo }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("startCursor", String?.self),
          .field("endCursor", String?.self),
          .field("hasNextPage", Bool.self),
        ] }

        /// When paginating backwards, the cursor to continue.
        public var startCursor: String? { __data["startCursor"] }
        /// When paginating forwards, the cursor to continue.
        public var endCursor: String? { __data["endCursor"] }
        /// Indicates whether more edges exist following the set defined by the clients arguments.
        public var hasNextPage: Bool { __data["hasNextPage"] }
      }
    }
  }
}
