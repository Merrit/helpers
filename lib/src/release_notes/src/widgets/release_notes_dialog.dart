import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../release_notes.dart';

const String _kDonateRequest =
    'If you find this app useful, please consider donating to support its development.';

/// ReleaseNotesDialog
///
/// This widget is used to display the release notes dialog.
///
/// The release text is rendered using the [MarkdownBody] widget.
class ReleaseNotesDialog extends StatelessWidget {
  const ReleaseNotesDialog({
    Key? key,
    required this.releaseNotes,
    this.showDonateButton = true,
    required this.donateCallback,
    required this.launchURL,
    required this.onClose,
  }) : super(key: key);

  /// The release notes to display.
  final ReleaseNotes releaseNotes;

  /// Whether to show the donate button.
  final bool showDonateButton;

  /// Called when the user taps the donate button.
  final VoidCallback donateCallback;

  /// Called when the user taps the full change log button.
  final void Function(String) launchURL;

  /// Called when the user closes the dialog.
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isSmallScreen = mediaQuery.size.width < 600;
    final double width = isSmallScreen ? mediaQuery.size.width : 500;

    final titleWidget = Text(
      'What\'s new in ${releaseNotes.version}',
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    );

    final Widget donateCard;
    if (showDonateButton) {
      donateCard = Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  _kDonateRequest,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: donateCallback,
                  child: const Text('Donate'),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      donateCard = const SizedBox.shrink();
    }

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: SizedBox(
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              titleWidget,
              donateCard,
              Expanded(
                child: Markdown(data: releaseNotes.notes),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => launchURL(releaseNotes.fullChangeLogUrl),
                    child: const Text(
                      'Full change log',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: onClose,
                    child: const Text(
                      'Close',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
