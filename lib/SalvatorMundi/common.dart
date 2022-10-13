import 'dart:async';

import 'package:flutter/material.dart';
import 'package:funvas/funvas.dart';
import 'dart:math';

class ExampleFunvas extends Funvas {
  @override
  void u(double t) {
    c.drawCircle(
      Offset(x.width / 2, x.height / 2),
      S(t).abs() * x.height / 4 + 42,
      Paint()..color = R(C(t) * 255, 42, 60 + T(t)),
    );
  }
}

class WaveFunvas extends Funvas {
  @override
  void u(double t) {
    c.scale(x.width / 1920, x.height / 1080);

    for (var i = 0; i < 64; i++) {
      c.drawRect(
        Rect.fromLTWH(
          i * 30.0,
          400 + C(4 * t + (i * 3)) * 100,
          27,
          200,
        ),
        Paint(),
      );
    }
  }
}

class One extends Funvas {
  @override
  void u(double t) {
    final s = s2q(750), w = s.width, h = s.height;
    final center = Offset(w / 2, h / 2);

    // Draw background.
    c.drawPaint(Paint()..color = R(242, 227, 193));

    final outer = 750 * (.42 + C(t / 3) * 5e-2);

    // Draw background circle.
    c.drawCircle(
      center,
      outer,
      Paint()..color = R(50, 71, 104),
    );

    const padding = 8;

    // Draws a small circle.
    void sc(double delta, double radius) {
      void draw(double minorDelta) {
        c.drawCircle(
          center +
              Offset.fromDirection(
                  T(S(t + pow(.2, delta))) * pi * 2 + minorDelta / 100,
                  outer - padding - radius - minorDelta / 10),
          radius - minorDelta / 10,
          Paint()
            ..color = R(200 + delta * 40, 100 + delta * 80, 100 - minorDelta,
                .1 + delta / 5),
        );
      }

      for (var i = 0; i < delta * 10; i++) {
        draw(i * 7.0);
      }
    }

    for (var i = 0; i < 16; i++) {
      sc(i / 2 / 10, 120.0 - i * 7);
    }
  }
}

class Eleven extends Funvas {
  @override
  String get tweet =>
      'https://twitter.com/creativemaybeno/status/1346101868079042561?s=20';

  @override
  void u(double t) {
    final s = s2q(750), w = s.width, h = s.height;

    c.drawPaint(Paint()..color = const Color(0xfffaddaa));

    const foregroundColor = Color(0xffff6a50);
    c.translate(w / 2, h / 2);
    c.drawCircle(Offset.zero, 76, Paint()..color = foregroundColor);

    const outerRadius = 108.0, step = 40, orbits = 7;
    for (var i = orbits - 1; i >= 0; i--) {
      final radius = outerRadius + step * i;

      c.drawCircle(
        Offset.zero,
        radius,
        Paint()
          ..color = foregroundColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3,
      );

      c.save();
      c.rotate(sin((t + i * 4.242424) * pi / 5) * 2 * pi);
      c.drawCircle(
        Offset.fromDirection(-pi / 2, radius),
        11,
        Paint()..color = foregroundColor,
      );
      c.restore();
    }
  }
}

class Twelve extends Funvas {
  @override
  void u(double t) {
    final s = s2q(750), w = s.width, h = s.height;

    // Background
    c.drawPaint(Paint()..color = const Color(0xffffffff));

    const sideLength = 50.0;

    // Draws a square of squares at the current canvas center that is 100x100.
    void drawSS(double t, Color color) {
      // Cannot quickly find a formula for making the correct rect spin, so
      // I will just quickly hard code all the cases.
      final spinAddend = Curves.linearToEaseOut.transform(t % 1) * pi / 2;
      final rectSpins = <int, List<double>>{
        0: [0, 0, spinAddend],
        1: [0, spinAddend, pi / 2],
        2: [spinAddend, pi / 2, pi / 2],
        3: [pi / 2, pi / 2, pi / 2 + spinAddend],
      };
      final currentSpins = rectSpins[(t % rectSpins.length).floor()]!;
      for (var i = 0; i < 3; i++) {
        final spin = currentSpins[i];

        c.save();
        c.rotate(pi / 2 * i + spin);
        c.drawRect(
          Offset.zero & const Size(sideLength, sideLength),
          Paint()
            ..color = color
            ..style = PaintingStyle.stroke
            ..strokeWidth = 5,
        );
        c.restore();
      }
    }

    for (var i = 0.0; i < w; i += sideLength * 3) {
      for (var j = 0.0; j < h; j += sideLength * 3) {
        c.save();
        c.translate(i + sideLength * 1.5, j + sideLength * 1.5);
        drawSS(
          t - i / sideLength - j / sideLength,
          HSVColor.fromAHSV(
            1,
            i / w * 180 + j / h * 180,
            1,
            .76,
          ).toColor(),
        );
        c.restore();
      }
    }
  }
}

class Thirteen extends Funvas {
  @override
  void u(double t) {
    final s = s2q(750), d = s.width;

    const squareDimension = 24.0;
    const animationDuration = 8;
    const scale = 1.5;

    void drawSquare(double shift) {
      c.save();
      final progress = (t + shift) %
          animationDuration *
          // Make the squares cross the track exactly once (+ an extra width to
          // make the entrance seamless) in the given duration.
          ((d / squareDimension + 1) / animationDuration);
      c.translate(progress.floor() * squareDimension, 0);
      c.rotate(-pi / 2 * (progress % 1));
      c.translate(-squareDimension, 0);
      c.drawRRect(
        RRect.fromRectAndRadius(
          Offset.zero & const Size.square(squareDimension),
          const Radius.circular(4),
        ),
        Paint()
          ..color = const Color(0xffffffff)
          ..blendMode = BlendMode.difference,
      );
      c.restore();
    }

    void drawTrack() {
      c.drawLine(
        const Offset(0, 0),
        Offset(d, 0),
        Paint()
          ..color = const Color(0xaaffffff)
          ..strokeWidth = 2,
      );
    }

    // We paint the scaffold relative to the center and go from there.
    c.translate(d / 2, d / 2);
    c.scale(scale);
    c.rotate(2 * pi / animationDuration * t);

    // Background
    c.drawPaint(Paint()..color = const Color(0xffffffff));
    // The circle is technically redundant when using scale >= 1.5 :)
    c.drawCircle(Offset.zero, d / 2, Paint()..color = const Color(0xff000000));
    // We clip to the background circle in order to ensure that the squares are
    // not visible on the background when rolling in.
    c.clipPath(
      Path()..addOval(Rect.fromCircle(center: Offset.zero, radius: d / 2)),
    );

    // We want to draw the tracks in a circle from start to end. There will be
    // multiple rolling squares on each track because we go in a whole circle.
    const tracks = 8;
    for (var i = 0; i < tracks; i++) {
      c.save();
      c.rotate(pi * 2 / tracks * i);
      c.translate(-d / 2, 0);

      final shift = animationDuration / tracks / 2 * i;
      drawSquare(shift);
      // Can mirror the square here to the other side of the track when there
      // is enough space.
      // c.scale(1, -1);
      // drawSquare(shift);
      // This also creates a mirror in some way, just one going in the other
      // direction because we draw every track twice (when we go in a full
      // circle, we will draw them once from each direction).
      drawSquare(animationDuration / 2 + shift);
      c.restore();
    }
    // Draw the tracks above the squares. This will make them appear below the
    // squares because the squares use a difference blend mode.
    for (var i = 0; i < tracks; i++) {
      c.save();
      c.rotate(pi * 2 / tracks * i);
      drawTrack();
      c.restore();
    }
  }
}

class Fourteen extends Funvas {
  @override
  void u(double t) {
    final s = s2q(750), d = s.width;

    const squareDimension = 20.0;
    const animationDuration = 10;

    void drawSquare(double shift) {
      c.save();
      final progress = (t + shift) %
          animationDuration *
          // Make the squares cross the track exactly once (+ an extra width to
          // make the entrance seamless) in the given duration.
          ((d / squareDimension + 1) / animationDuration);
      c.translate(progress.floor() * squareDimension, 0);
      c.rotate(-pi / 2 * (progress % 1));
      c.translate(-squareDimension, 0);
      c.drawRRect(
        RRect.fromRectAndRadius(
          Offset.zero & const Size.square(squareDimension),
          const Radius.circular(4),
        ),
        Paint()
          ..color = const Color(0xffffffff)
          ..blendMode = BlendMode.difference,
      );
      c.restore();
    }

    void drawTrack(double shift) {
      c.save();
      c.drawLine(
        const Offset(0, 0),
        Offset(d, 0),
        Paint()..color = const Color(0x66ffffff),
      );

      drawSquare(shift);
      // Draw another square (mirrored) on the other side of the track.
      c.scale(1, -1);
      drawSquare(shift);
      c.restore();
    }

    // We paint the scaffold relative to the center and go from there.
    c.translate(d / 2, d / 2);
    c.scale(1.4 + sin(pi * 2 / animationDuration * t) / 2);
    c.rotate(2 * pi / animationDuration * t -
        // I like the square coming from the top better.
        pi / 2);

    // Background
    c.drawPaint(Paint()..color = const Color(0xffffffff));
    c.drawCircle(Offset.zero, d / 2, Paint()..color = const Color(0xff000000));
    // We clip to the background circle in order to ensure that the squares are
    // not visible on the background when rolling in.
    c.clipPath(
      Path()..addOval(Rect.fromCircle(center: Offset.zero, radius: d / 2)),
    );

    // We want to draw the tracks in a circle from start to end. There will be
    // multiple rolling squares on each track. Because we go in a whole
    const tracks = 40;
    for (var i = 0; i < tracks; i++) {
      c.save();
      c.rotate(pi * 2 / tracks * i);
      c.translate(-d / 2, 0);

      final shift = animationDuration / tracks / 2 * i;
      drawTrack(shift);
      drawTrack(animationDuration / 2 + shift);
      c.restore();
    }
  }
}

