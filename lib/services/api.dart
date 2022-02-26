import 'dart:convert';

import 'package:graphql_flutter/graphql_flutter.dart';

class Api {
  // API class for handling all the network functions
  final HttpLink httpLink = HttpLink(
    'https://countries.trevorblades.com/graphql',
  );

  final AuthLink authLink = AuthLink(
    getToken: () => "",
  );
  late Link link;
  late GraphQLClient client;

  Api() {
    link = authLink.concat(httpLink);
    client = GraphQLClient(link: link, cache: GraphQLCache());
  }

  Future getCountries() async {
    const String query = '''
     query Countries {
      countries {
        emoji
        name
        continent {
          name
        }
        phone 
        currency
        languages {
          name
        }        
      }
    }
  ''';
    final QueryResult result = await client.query(
      QueryOptions(
        document: gql(query),
      ),
    );

    return jsonEncode(result.data);
  }

  Future getCountryByCode({String? code}) async {
    final String query = '''
    query Query {
      country(code: "$code") {
      name
      }
    }
  ''';
    final QueryResult result = await client.query(
      QueryOptions(
        document: gql(query),
      ),
    );

    return json.encode(result.data);
  }
}
