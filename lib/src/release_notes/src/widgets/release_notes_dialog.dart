import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' show ExtensionSet;

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
    super.key,
    required this.releaseNotes,
    this.showDonateButton = true,
    required this.donateCallback,
    required this.launchURL,
    required this.onClose,
  });

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
                OutlinedButton.icon(
                  icon: const Icon(Icons.favorite),
                  label: const Text('Donate'),
                  onPressed: donateCallback,
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      donateCard = const SizedBox.shrink();
    }

    return AlertDialog(
      // Reduce padding on mobile screens.
      insetPadding: isSmallScreen
          ? const EdgeInsets.only()
          : const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      scrollable: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      content: SizedBox(
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              titleWidget,
              donateCard,
              MarkdownBody(
                data: releaseNotes.notes,

                /// [ExtensionSet.gitHubWeb] enables rendering GitHub
                /// style emoji, among other things. Eg. :smile:
                extensionSet: ExtensionSet.gitHubWeb,

                // Alignment = start is required as a workaround for a bug when
                // an AlertDialog has a Row with crossAxisAlignment = baseline,
                // which the Markdown widget uses.
                // See: https://github.com/flutter/flutter/issues/96806
                listItemCrossAxisAlignment:
                    MarkdownListItemCrossAxisAlignment.start,

                onTapLink: (text, href, title) {
                  if (href == null) return;
                  launchURL(href);
                },
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
