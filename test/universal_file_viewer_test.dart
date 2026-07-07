import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:universal_file_viewer/universal_file_viewer.dart';

void main() {
  group('PowerPoint files', () {
    test('are detected as supported system-preview files', () {
      expect(detectFileType('/tmp/demo.ppt'), FileType.ppt);
      expect(detectFileType('/tmp/demo.PPTX'), FileType.ppt);
      expect(supportedFile('/tmp/demo.pptx'), isTrue);
    });

    testWidgets('show a system preview fallback instead of unsupported text',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: UniversalFileViewer(file: File('/tmp/demo.pptx')),
        ),
      );

      expect(find.text('File type not supported'), findsNothing);
      expect(find.text('PowerPoint inline preview is not supported yet.'),
          findsOneWidget);
      expect(find.text('Open in system preview'), findsOneWidget);
    });
  });
}
