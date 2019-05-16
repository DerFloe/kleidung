import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Overview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink =
        HttpLink(uri: "localhost");
    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        link: httpLink as Link,
        cache: OptimisticCache(
          dataIdFromObject: typenameDataIdFromObject,
        ),
      ),
    );
    return GraphQLProvider(
      child: HomePage(),
      client: client,
    );
  }
}

class HomePage extends StatelessWidget {
  final String items = """
  query Items {
    items {
      title
      image
      description
    }
  }                                   
  """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Query(
        options: QueryOptions(document: items),
        builder: (QueryResult result, {VoidCallback refetch}) {
          if (result.loading) {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.black,
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
            ));
          }
          if (result.errors != null) {
            print(result.errors.toString());
            return Text(result.errors.toString());
          }
          if (result.data == null) {
            return Text("No Data Found !");
          }

          var items = result.data.data.values.first;

          print(items);
          // your code here
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              var item = items[index];
              Item itemToDisplay = new Item();
              itemToDisplay.title = item['title'];
              itemToDisplay.description = item['description'];
              itemToDisplay.image = item['image'];
              return _buildNewsItem(itemToDisplay);
            },
          );
        },
      ),
    );
  }
}

Widget _buildNewsItem(Item item) {
  return Card(
    color: Colors.black,
    child: Column(
      children: <Widget>[
        ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            leading: Container(
              padding: EdgeInsets.only(right: 5.0),
              //decoration: new BoxDecoration(
              //border: new Border(
              //right: new BorderSide(width: 1.0, color: Colors.black))),
              child: Image(
                  image: new CachedNetworkImageProvider(item.image), width: 75),
            ),
            title: Text(
              item.title,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

            subtitle: Row(
              children: <Widget>[
                //Icon(Icons.linear_scale, color: Colors.black),
                Text(item.description.substring(0,21)+"...", style: TextStyle(color: Colors.white))
              ],
            ),
            trailing: Icon(Icons.keyboard_arrow_right,
                color: Colors.white, size: 30.0))
        //new Image(image: new CachedNetworkImageProvider(news.image),width: 100),
        //Text(news.title, style: TextStyle(color: Colors.deepPurple))
      ],
    ),
  );
}

class Item {
  String title;
  String image;
  String description;
}
