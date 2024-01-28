// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public typealias ID = String

public protocol SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == WardsAPI.SchemaMetadata {}

public protocol InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == WardsAPI.SchemaMetadata {}

public protocol MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == WardsAPI.SchemaMetadata {}

public protocol MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == WardsAPI.SchemaMetadata {}

public enum SchemaMetadata: ApolloAPI.SchemaMetadata {
  public static let configuration: ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

  public static func objectType(forTypename typename: String) -> ApolloAPI.Object? {
    switch typename {
    case "Query": return WardsAPI.Objects.Query
    case "Ward": return WardsAPI.Objects.Ward
    case "WardPublicInformation": return WardsAPI.Objects.WardPublicInformation
    case "Nomen": return WardsAPI.Objects.Nomen
    case "FileInformation": return WardsAPI.Objects.FileInformation
    case "FileUploadInformation": return WardsAPI.Objects.FileUploadInformation
    case "WardsConnection": return WardsAPI.Objects.WardsConnection
    case "WardsEdge": return WardsAPI.Objects.WardsEdge
    case "PageInfo": return WardsAPI.Objects.PageInfo
    default: return nil
    }
  }
}

public enum Objects {}
public enum Interfaces {}
public enum Unions {}
