import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:time_sheet/bloc/client_bloc.dart';
import 'package:time_sheet/models/client_model.dart';
import 'package:time_sheet/repositories/client_repository.dart';

class AddClientForm extends StatefulWidget {
  const AddClientForm({super.key, this.client});

  final ClientModel? client;

  @override
  State<AddClientForm> createState() => _AddClientFormState();
}

class _AddClientFormState extends State<AddClientForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _clientNameController = TextEditingController();
  final clientRepository = ClientRepository();
  final TextEditingController _clientShortNameController =
      TextEditingController();
  Color _color = Colors.green;


  @override
  void initState() {
    super.initState();
    if (widget.client != null) {
      _color = Color(widget.client!.clientColor);
      _clientNameController.text = widget.client!.name;
      _clientShortNameController.text = widget.client!.shortName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientBloc, ClientState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 16.0,
            children: [
              widget.client == null
                  ? Text(
                      'Add Client',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headlineSmall,
                    )
                  : Text(
                      'Update Client',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Client Name',
                ),
                controller: _clientNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Client Name';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Client Short Name',
                ),
                controller: _clientShortNameController,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter Client Short Name'
                    : null,
              ),
              ColorPicker(
                enableAlpha: false,
                pickerColor: _color,
                onColorChanged: (value) {
                  setState(() {
                    _color = value;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    label: const Text('Cancel'),
                    icon: const Icon(Icons.cancel),
                  ),
                  widget.client != null
                      ? ElevatedButton.icon(
                          onPressed: () {

                            if (_formKey.currentState!.validate()) {
                              final client = ClientModel(
                                id: widget.client!.id,
                                name: _clientNameController.text,
                                shortName: _clientShortNameController.text.toUpperCase(),
                                clientColor: _color.toARGB32().toInt(),
                              );
                              context.read<ClientBloc>().add(
                                    ClientUpdate(client: client),
                                  );
                              context.read<ClientBloc>().add(ClientLoad());
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Processing Data ...')),
                              );
                              Navigator.of(context).pop();
                            }
                          },
                          label: const Text('Update'),
                          icon: const Icon(Icons.update),
                        )
                      : ElevatedButton.icon(
                          onPressed: () {
                            debugPrint(_color.toARGB32().toString());
                            if (_formKey.currentState!.validate()) {
                              final client = ClientModel(
                                id: DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toInt(),
                                name: _clientNameController.text,
                                shortName: _clientShortNameController.text.toUpperCase(),
                                clientColor: _color.toARGB32().toInt(),
                              );
                              context.read<ClientBloc>().add(
                                    ClientAdd(client: client),
                                  );
                              context.read<ClientBloc>().add(ClientLoad());
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Processing Data ...')),
                              );
                              Navigator.of(context).pop();
                            }
                          },
                          label: const Text('Add'),
                          icon: const Icon(Icons.add),
                        ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
