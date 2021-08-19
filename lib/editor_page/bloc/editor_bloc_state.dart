part of 'editor_bloc_bloc.dart';

 class EditorBlocState {
   final Uint8List? file;
   EditorBlocState({this.file});

   EditorBlocState copyWith({Uint8List? file}){
     return EditorBlocState(file: file?? this.file);
   }
 }


