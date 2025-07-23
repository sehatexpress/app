import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../widgets/inputs/message_input_widget.dart';
import '../../../widgets/inputs/mobile_input_widget.dart';
import '../../../widgets/inputs/name_input_widget.dart';

class RaiseQueryScreen extends HookWidget {
  const RaiseQueryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var loading = useState(false);
    var formKey = useMemoized(() => GlobalKey<FormState>());
    var name = useTextEditingController();
    var phone = useTextEditingController();
    var message = useTextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit Your Query'),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            NameInputWidget(controller: name),
            const SizedBox(height: 12),
            MobileInputWidget(controller: phone),
            const SizedBox(height: 12),
            MessageInputWidget(controller: message),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: TextButton(
          child: Text('Submit Query'),
          onPressed: () async {
            if (!formKey.currentState!.validate()) return;
            try {
              FocusScope.of(context).unfocus();
              loading.value = true;
              // await queryService.submitQuery(
              //   name: name.text.trim(),
              //   mobile: phone.text.trim(),
              //   message: message.text.trim(),
              // );
              loading.value = false;
              name.clear();
              phone.clear();
              message.clear();
              Navigator.pop(context);
            } catch (_) {
              loading.value = false;
            }
          },
        ),
      ),
    );
  }
}
