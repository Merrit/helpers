import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// [ListTile] which displays text, and when clicked is a [TextInput].
class TextInputListTile extends StatefulWidget {
  final String? debugLabel;
  final bool? editingPlaceholderText;
  final double focusedOpacity;
  final Widget? leading;
  final String placeholderText;
  final bool retainFocus;
  final TextAlign textAlign;
  final double unfocusedOpacity;
  final Function(String value) callback;

  const TextInputListTile({
    Key? key,
    this.debugLabel,
    this.editingPlaceholderText = false,
    this.focusedOpacity = 1.00,
    this.leading,
    this.placeholderText = '',
    this.retainFocus = false,
    this.textAlign = TextAlign.start,
    this.unfocusedOpacity = 0.50,
    required this.callback,
  }) : super(key: key);

  @override
  State<TextInputListTile> createState() => _TextInputListTileState();
}

class _TextInputListTileState extends State<TextInputListTile> {
  final TextEditingController controller = TextEditingController();

  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    controller.text = widget.placeholderText;
    focusNode.debugLabel = widget.debugLabel;
    opacity = widget.unfocusedOpacity;
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  late double opacity;

  @override
  Widget build(BuildContext context) {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() => opacity = widget.focusedOpacity);
        if (widget.editingPlaceholderText == false) controller.text = '';
      } else {
        setState(() => opacity = widget.unfocusedOpacity);
        controller.text = widget.placeholderText;
      }
    });

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.escape): () {
          focusNode.unfocus();
        },
      },
      child: Opacity(
        opacity: opacity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: const InputDecorationTheme(
                border: InputBorder.none,
              ),
            ),
            child: ListTile(
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              leading: widget.leading,
              title: TextField(
                controller: controller,
                focusNode: focusNode,
                enableInteractiveSelection: true,
                textAlign: widget.textAlign,
                textCapitalization: TextCapitalization.sentences,
                onSubmitted: (String value) {
                  if (value.trim() == '') return;

                  widget.callback(value);

                  if (widget.retainFocus) {
                    setState(() => controller.text = '');
                    focusNode.requestFocus();
                  } else {
                    FocusManager.instance.primaryFocus?.unfocus();
                  }
                },
              ),
              onTap: () {
                focusNode.requestFocus();
              },
            ),
          ),
        ),
      ),
    );
  }
}
