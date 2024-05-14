import 'package:flutter/material.dart';
import '../../../util/string/strings.dart';
import '../../../util/theme/theme_constants.dart';

class DialogInformation extends StatelessWidget {
  const DialogInformation(
      {super.key, required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, actionCancel),
          child: const Text(actionCancel),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, actionOk),
          child: const Text(actionOk),
        ),
      ],
    );
  }
}

class AlertInformation {
  const AlertInformation({required this.title, required this.description});

  final String title;
  final String description;

  Future showError(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return _buildAlert(context, colorError, Icons.error_outline);
      },
    );
  }

  Future showSuccess(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return _buildAlert(context, colorSuccess, Icons.check_circle_outline_outlined);
      },
    );
  }

  Future showConfirm(BuildContext context, Function clickConfirm) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return _buildAlertConfirm(context, colorInfo, Icons.warning_amber_outlined, clickConfirm);
      },
    );
  }

  Widget _buildAlert(BuildContext context, Color color, IconData icon) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      contentPadding: const EdgeInsets.only(top: 0.0),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
            decoration:  BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0)),
            ),
            child: Icon(
               icon,
              color: Colors.white,
              size: 50,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                  child: Text(
                    description,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.normal),
                    textAlign: TextAlign.center,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, actionOk);
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: color,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(60),
                      textStyle:
                      const TextStyle(fontWeight: FontWeight.bold)),
                  child: const Text(actionOk),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertConfirm(BuildContext context, Color color, IconData icon, Function clickConfirm) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      contentPadding: const EdgeInsets.only(top: 0.0),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
            decoration:  BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0)),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 50,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                  child: Text(
                    description,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.normal),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child:ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, actionCancel);
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            backgroundColor: color,
                            foregroundColor: Colors.white,
                            minimumSize: const Size.fromHeight(60),
                            textStyle:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        child: const Text(actionCancel),
                      ),
                    ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child:ElevatedButton(
                        onPressed: () {
                          clickConfirm();
                          Navigator.pop(context, actionConfirm);
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            backgroundColor: Theme.of(context).colorScheme.surface,
                            foregroundColor: Colors.black,
                            minimumSize: const Size.fromHeight(60),
                            textStyle:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        child: const Text(actionConfirm),
                      ),
                    ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
