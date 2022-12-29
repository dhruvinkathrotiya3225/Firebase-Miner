import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    dynamic res = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Note"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 5),
              Text(
                "Title:-",
                style: GoogleFonts.actor(fontSize: 23),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 12,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    "${res["title"]}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 20,
                    softWrap: false,
                    style: GoogleFonts.actor(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 5),
              Text(
                "Note:-",
                style: GoogleFonts.actor(fontSize: 23),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 12,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    "${res["note"]}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 20,
                    softWrap: false,
                    style: GoogleFonts.actor(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
