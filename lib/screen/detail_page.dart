import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertest/models/User.dart';
import 'package:fluttertest/utils/utils.dart';
import '../widgets/common_text_field.dart';

class DetailPage extends ConsumerStatefulWidget {
  const DetailPage({super.key, });

  @override
  _DetailPageState createState() => _DetailPageState();

}



class _DetailPageState extends ConsumerState<DetailPage> {
  @override
  Widget build(BuildContext context) {
    final color = context.colorScheme;
    return Scaffold(
        backgroundColor: color.background,
        appBar: AppBar(
          backgroundColor: color.primary,
          title: const Text('Detail Page'),
          centerTitle: true,
        ),
        body: Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: 40, width: 40,
                        child: CircleAvatar(
                          backgroundColor: color.secondary,
                          child: Image.asset(
                            'assets/image/user.png', height: 20, width: 20,
                          ),
                        )),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                    Expanded(
                        child: CommonTexField(

                        )
                    )]
              ))));
  }
}
