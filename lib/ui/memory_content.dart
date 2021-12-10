import 'dart:async';
import 'dart:io';

import 'package:fileshare/changeNotifiers/memory_details_notifier.dart';
import 'package:fileshare/uiUtils/custom_divider.dart';
import 'package:fileshare/uiUtils/item.dart';


import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class MemoryContent extends StatefulWidget {
  const MemoryContent({Key? key}) : super(key: key);



  @override
  _MemoryContentState createState() => _MemoryContentState();
}

class _MemoryContentState extends State<MemoryContent> {

  refresh(BuildContext context) async {
    await Provider.of<MemoryDetailsNotifier>(context, listen: false).checkSpace();
  }

  @override
  void initState() {
    super.initState();
    refresh(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'FileShare',
          style: TextStyle(fontSize: 25.0),
        ),

      ),
      body: RefreshIndicator(
        onRefresh: () => refresh(context),
        child: ListView(
          padding: EdgeInsets.only(left: 20.0),
          children: <Widget>[
            SizedBox(height: 20.0),
            _SectionTitle('Storage Devices'),
            _StorageSection(),
          ],
        ),
      ),

    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12.0,
      ),
    );
  }
}

class _StorageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MemoryDetailsNotifier>(
      builder: (BuildContext context, memoryNotifier, Widget? child) {

        return ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: memoryNotifier.availableStorage.length,
          itemBuilder: (BuildContext context, int index) {
            FileSystemEntity item = memoryNotifier.availableStorage[index];

            String path = item.path.split('Android')[0];
            return Item(
              path: path,
              title: index == 0 ? 'Device' : 'SD Card',
              icon: index == 0 ? Feather.smartphone : Icons.sd_storage,
              color: index == 0 ? Colors.green : Colors.red,
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return CustomDivider();
          },
        );
      },
    );
  }
}
