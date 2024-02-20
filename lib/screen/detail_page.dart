import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailPage extends ConsumerStatefulWidget{
  const DetailPage({super.key});

  @override
  _DetailPageState createState()=> _DetailPageState();

}

class _DetailPageState extends ConsumerState<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 15,width: 15,
            child: Image.asset("assets/image/user.png"),
          ),

          Container(
            width: MediaQuery.of(context).size.width *0.5,
            decoration:  BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 2
              ),
              borderRadius: BorderRadius.circular(0.8),
            ),
            child: const Row(

            ),
          )
        ],
      ),
    );
  }
}