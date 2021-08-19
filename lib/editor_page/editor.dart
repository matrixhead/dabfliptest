import 'dart:typed_data';

import 'package:extended_image/extended_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import 'bloc/editor_bloc_bloc.dart';


class EditorPage extends StatelessWidget {
  const EditorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditorBloc(),
      child: EditorPageView(),
    );
  }
}

class EditorPageView extends StatefulWidget {
  const EditorPageView({Key? key}) : super(key: key);

  @override
  _EditorPageViewState createState() => _EditorPageViewState();
}

class _EditorPageViewState extends State<EditorPageView> {
  final GlobalKey<ExtendedImageEditorState> editorKey =
      GlobalKey<ExtendedImageEditorState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("editor"),
        actions: [
          IconButton(
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  withData: true,
                  type: FileType.custom,
                  allowedExtensions: [
                    'jpg',
                  ],
                );
                if (result != null) {
                  Uint8List? fileBytes = result.files.first.bytes;
                  context.read<EditorBloc>().add(FilePickedEvent(fileBytes));
                }
              },
              icon: Icon(Icons.photo_library_outlined)),
          IconButton(
              onPressed: () async {
                var status = await Permission.storage.status;
                if (status.isDenied) {
                  await Permission.storage.request();
}else{
context.read<EditorBloc>().add(ExportEvent(editorKey));
}
                
              },
              icon: Icon(Icons.done))
        ],
      ),
      body: BlocBuilder<EditorBloc, EditorBlocState>(
        builder: (context, state) {
          return Container(
              child: state.file == null
                  ? ExtendedImage.asset(
                      'assets/spadaman.jpg',
                      extendedImageEditorKey: editorKey,
                      fit: BoxFit.contain,
                      cacheRawData: true,
                      mode: ExtendedImageMode.editor,
                    )
                  : ExtendedImage.memory(
                      state.file!,
                      extendedImageEditorKey: editorKey,
                      fit: BoxFit.contain,
                      mode: ExtendedImageMode.editor,
                    ));
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: () {
                  editorKey.currentState!.flip();
                },
                icon: Icon(Icons.flip)),
            IconButton(
                onPressed: () {
                  editorKey.currentState!.rotate(right: false);
                },
                icon: Icon(Icons.rotate_left)),
            IconButton(
                onPressed: () {
                  editorKey.currentState!.rotate(right: true);
                },
                icon: Icon(Icons.rotate_right)),
          ],
        ),
      ),
    );
  }
}
