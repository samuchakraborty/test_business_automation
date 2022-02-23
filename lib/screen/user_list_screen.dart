import 'package:flutter/material.dart';
import 'package:test_business_automation_ltd/model/user_model.dart';
import 'package:test_business_automation_ltd/screen/web_view_page.dart';
import 'package:test_business_automation_ltd/services/database_helper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late Future<List<UserList>?> listOfStoreData;

  void _handleURLButtonPress(BuildContext context, String url, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebViewPage(url,title
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    // DBHelper().initDb();
    refreshList();
    //  initDataBase()
    super.initState();
  }

  initDataBase() async {
    await DBHelper().initDb();
  }

  refreshList() async {
    //  setState(() {

    setState(() {
      listOfStoreData = DBHelper().getAllUser();
    });

    //   listOfStoreData.then((value) async {
    //     if(value!.isEmpty){
    //     await  storeData();
    //     setState(() {
    //
    //     });
    //     }
    //
    //
    //  // });
    //
    // });
  }

  storeData() async {
    await DBHelper().storeData(
      UserList(
        id: 1,
        userName: 'Sam Jhon',
        url: 'www.github.com',
        mobileNumber: '01851944605',
      ),
    );
    await DBHelper().storeData(
      UserList(
        id: 2,
        userName: 'Sam Jhon',
        url: 'www.youtube.com',
        mobileNumber: '01751944605',
      ),
    );
    await DBHelper().storeData(
      UserList(
        id: 3,
        userName: 'Sam Jhon',
        url: 'www.linkedin.com',
        mobileNumber: '01819632199',
      ),
    );
    await DBHelper().storeData(
      UserList(
        id: 4,
        userName: 'Sam Manik',
        url: 'www.facebook.com',
        mobileNumber: '01851944605',
      ),
    );
  }

  Widget dataTable(List<UserList> storeData) {
    // var kMinWidthOfLargeScreen =MediaQuery.of(context).size.width-10;
    // bool isScreenWide = MediaQuery.of(context).size.width >= kMinWidthOfLargeScreen;
    return
        // SingleChildScrollView(
        // physics: NeverScrollableScrollPhysics(),
        // scrollDirection: Axis.vertical,
        // child:
        //
        FittedBox(
      // width: MediaQuery.of(context).size.width,
      //margin: EdgeInsets.only(left: 10, right: 20),
      child: ConstrainedBox(
        constraints:
            BoxConstraints(minWidth: MediaQuery.of(context).size.width - 10),
        child: DataTable(
          columns: [
            DataColumn(
              label: Container(child: Text('id')),
            ),
            DataColumn(
              label: Container(
                  //  width: MediaQuery.of(context).size.width / 14,
                  child: Text('User Name')),
            ),
            DataColumn(
              label: Container(child: Text('Url')),
            ),
            DataColumn(
              label: Container(child: Text('Mobile Number')),
            ),
          ],
          rows: storeData
              .map(
                (element) => DataRow(cells: [
                  DataCell(
                    Container(
                      child: Text(
                        element.id.toString(),
                      ),
                    ),
                  ),
                  DataCell(
                    Text(
                      element.userName.toString(),
                      maxLines: 5,
                    ),
                  ),
                  DataCell(
                    GestureDetector(
                      onTap: () {
                        _handleURLButtonPress(context, element.url!, element.url!);
                      },

                      // => WebView(
                      //   javascriptMode: JavascriptMode.unrestricted,
                      //   initialUrl: element.url,
                      // ),
                      child: Text(
                        element.url.toString(),
                      ),
                    ),
                  ),
                  DataCell(
                    GestureDetector(
                      onTap: () {
                        launch("tel://${element.mobileNumber}");
                      },
                      child: Text(element.mobileNumber.toString()),
                    ),
                  ),
                ]),
              )
              .toList(),
        ),
      ),
    );
    //  );
    //,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('User List'),
          centerTitle: true,
        ),
        body: list());
  }

  list() {
    return FutureBuilder(
      future: listOfStoreData,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return dataTable(snapshot.data);
          // print(snapshot.data[0]);
          //  return ListView.builder(
          //    itemCount: snapshot.data.length,
          //    itemBuilder: (context, index) {
          //      return Text(snapshot.data[index].url.toString());
          //    },

          //   );
        }

        if (null == snapshot.data || snapshot.data.length == 0) {
          return Center(child: const Text("No Data Found"));
        }

        return Center(child: const CircularProgressIndicator());
      },
    );
  }
}
