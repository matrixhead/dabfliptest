part of 'editor_bloc_bloc.dart';


abstract class EditorBlocEvent {}

class FilePickedEvent extends EditorBlocEvent{
  final Uint8List? file;
  FilePickedEvent(this.file);
}

class ExportEvent extends EditorBlocEvent{
  final GlobalKey<ExtendedImageEditorState> editorKey;
  ExportEvent(this.editorKey);
}
