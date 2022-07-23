import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:http/http.dart' as http;

class ShowImage extends StatefulWidget {
  int attachment_id;

  ShowImage(this.attachment_id, {Key? key}) : super(key: key);

  @override
  State<ShowImage> createState() => _ShowImageState();
}

class _ShowImageState extends State<ShowImage> {
  var image = null;

  @override
  initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: image != null
          ? PhotoView(
              imageProvider: MemoryImage(image),
        minScale: PhotoViewComputedScale.contained * 0.8,
        maxScale: PhotoViewComputedScale.covered * 2,
        // enableRotation: true,
            )
          : const CircularProgressIndicator(),
    ));
  }

  void getData() async {
    debugPrint(widget.attachment_id.toString());
    var response = await http.get(
        Uri.parse(
            "https://technofino.in/community/api/attachments/${widget.attachment_id}/data"),
        headers: {
          "XF-Api-Key": "p-rQmDsW41tBC768faylyvJcd8KOnp3g",
          "XF-Api-User": "625"
        });
    image = response.bodyBytes;
    setState(() {});
    debugPrint(image.toString());
  }
}
