import 'package:mindtunes/features/meditation/data/models/meditation_model.dart';
import 'package:mindtunes/features/meditation/domain/repository/firebase_repository.dart';

class UpdateMeditationSession {
  final FirebaseRepository firebaseRepository;

  UpdateMeditationSession(this.firebaseRepository);
  void call(MeditationModel meditation) {
    firebaseRepository.updateMeditationdata(meditation);
  }
}
