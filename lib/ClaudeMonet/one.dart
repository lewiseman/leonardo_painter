import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

void main() {
  Duration? startDuration;

  window.onBeginFrame = (duration) {
    double devicePixelRatio = window.devicePixelRatio;
    Size size = window.physicalSize / devicePixelRatio;

    PictureRecorder pictureRecorder = PictureRecorder();
    Canvas canvas = Canvas(pictureRecorder, Offset.zero & size);

    var A = .0, q = 123;
    double boxPos = 0.0;

    //Duration difference since start in seconds
    double t = (duration - (startDuration ??= duration)).inMicroseconds / 1e6;

    canvas.drawPaint(Paint()..color = const Color(0xff000000));
    for (int i = 756; i > 0; i--) {
      canvas.drawRect(
        Rect.fromLTWH(
          size.width / 2 + A * sin(boxPos),
          size.height / 2 + A * cos(boxPos),
          i / 84,
          i / 84,
        ),
        Paint()..color = Color.fromRGBO(i % 99 + 156, q - i % q, q, 1),
      );
      boxPos = i / 9;
      A = (9 * sin(t * boxPos / 20) + cos(20 * boxPos) + 6) * 21;
    }

    var picture = pictureRecorder.endRecording();
    var sceenBuilder = SceneBuilder();
    sceenBuilder.pushTransform(
      Float64List(16)
        ..[0] = devicePixelRatio
        ..[5] = devicePixelRatio
        ..[10] = 1
        ..[15] = 1,
    );
    sceenBuilder.addPicture(Offset.zero, picture);
    sceenBuilder.pop();
    var scene = sceenBuilder.build();
    window.render(scene);

    // calls to refresh the scene
    // window.scheduleFrame();
    Future.delayed(const Duration(milliseconds: 00))
        .then((value) => window.scheduleFrame());
  };

  // this calls the onBeginFrame or onDrawFrame the first time so that the code above can work/reached
  window.scheduleFrame();
}
