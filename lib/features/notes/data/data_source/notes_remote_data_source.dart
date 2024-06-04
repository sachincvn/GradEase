import 'package:dio/dio.dart';
import 'package:grad_ease/core/common/models/upload_file_response_model.dart';
import 'package:grad_ease/core/constants/rest_resources.dart';
import 'package:grad_ease/core/remote/gradease_rest_service.dart';
import 'package:grad_ease/features/notes/data/models/note_model.dart';
import 'package:grad_ease/features/notes/data/models/notes_response_model.dart';

abstract interface class NoteRemoteDataSource {
  Future<NotesResponseModel> getNotes(int year);
  Future<NoteModel> addNote(
    String title,
    String description,
    String filePath,
    String uploaderName,
    String uploaderEmail,
    String uploaderProfileImage,
    int year,
  );

  Future<UploadFileResponseModel> uploadNote(String fileName, String filePath);
  Future<NoteModel> deletedNote(String noteId);
}

class NotesRemoteDataSourceImpl extends GradEaseRestService
    implements NoteRemoteDataSource {
  @override
  Future<NotesResponseModel> getNotes(int year) async {
    final restRequest = createGetRequest(RestResources.notes);
    restRequest.headers = {"year": year};
    final notes = await executeRequest(restRequest);
    return NotesResponseModel.fromJson(notes.data);
  }

  @override
  Future<NoteModel> addNote(
      String title,
      String description,
      String filePath,
      String uploaderName,
      String uploaderEmail,
      String uploaderProfileImage,
      int year) async {
    final restRequest = createPostRequest(RestResources.notes, body: {
      "title": title,
      "description": description,
      "filepath": filePath,
      "uploadedBy": {
        "fullName": uploaderName,
        "email": uploaderEmail,
        "profileImage": uploaderProfileImage
      },
      "year": year
    });
    final response = await executeRequest(restRequest);
    return NoteModel.fromJson(response.data);
  }

  @override
  Future<UploadFileResponseModel> uploadNote(
      String fileName, String filePath) async {
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        filePath,
        filename: fileName,
      ),
    });
    final restRequest =
        createPostRequest(RestResources.uploadNote, body: formData);
    final response = await executeRequest(restRequest);
    return UploadFileResponseModel.fromJson(response.data);
  }

  @override
  Future<NoteModel> deletedNote(String noteId) async {
    final restRequest = createDeleteRequest("${RestResources.notes}/$noteId");
    final deletedNote = await executeRequest(restRequest);
    return NoteModel.fromJson(deletedNote.data);
  }
}
