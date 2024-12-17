import '../../../../utils/status.dart';

abstract class ReciteEvent {}


class CheckPermissionEvent extends ReciteEvent{}
class InitialControllers extends ReciteEvent{}
class PlayAndPauseEvent extends ReciteEvent{}
class PlayerAttachToListeners extends ReciteEvent{}
class RecorderAttachToListeners extends ReciteEvent{}
class StartRecordEvent extends ReciteEvent{}
class StopRecordEvent extends ReciteEvent{}
class DeleteRecordEvent extends ReciteEvent{}
class SendRecordEvent extends ReciteEvent{}


// class UpdateSeekPositionEvent extends AudioEvent {
//   final Duration position;
//
//   UpdateSeekPositionEvent({required this.position});
// }
// class GetAudioEvent extends AudioEvent{}
//
// class UpdatePlayButtonEvent extends AudioEvent{
//   final ButtonState buttonState;
//
//   UpdatePlayButtonEvent({required this.buttonState});
// }
// class UpdateRecordButtonEvent extends AudioEvent{
//   final RecordButtonState buttonState;
//   UpdateRecordButtonEvent({required this.buttonState});
// }

class DisposeEvent extends ReciteEvent{}
