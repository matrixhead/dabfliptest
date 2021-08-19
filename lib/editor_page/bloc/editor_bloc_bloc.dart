import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:image_editor/image_editor.dart';

part 'editor_bloc_event.dart';
part 'editor_bloc_state.dart';

class EditorBloc extends Bloc<EditorBlocEvent, EditorBlocState> {
  EditorBloc() : super(EditorBlocState());

  @override
  Stream<EditorBlocState> mapEventToState(
    EditorBlocEvent event,
  ) async* {
    if (event is FilePickedEvent) {
      yield filePickedEventToState(event);
    } else if (event is ExportEvent) {
      yield await exportImage(event);
    }
  }

  EditorBlocState filePickedEventToState(FilePickedEvent event) {
    return state.copyWith(file: event.file);
  }

  Future<EditorBlocState> exportImage(ExportEvent event) async {
    ExtendedImageEditorState editorstate = event.editorKey.currentState!;
    final Rect? cropRect = editorstate.getCropRect();
    final EditActionDetails action = editorstate.editAction!;
    final int rotateAngle = action.rotateAngle.toInt();
    final bool flipHorizontal = action.flipY;
    final bool flipVertical = action.flipX;
    final Uint8List img = editorstate.rawImageData;
    final ImageEditorOption option = ImageEditorOption();
    if (action.needCrop) {
    option.addOption(ClipOption.fromRect(cropRect!));
  }
  if (action.needFlip) {
    option.addOption(
        FlipOption(horizontal: flipHorizontal, vertical: flipVertical));
  }
  if (action.hasRotateAngle) {
    option.addOption(RotateOption(rotateAngle));
  }
  final Uint8List? result = await ImageEditor.editImage(
    image: img,
    imageEditorOption: option,
  );
    File file = File("/storage/emulated/0/Download/file.jpg");
    file.writeAsBytes(result!);
    return EditorBlocState();
  }
}
