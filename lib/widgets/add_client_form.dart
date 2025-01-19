import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  TextEditingController setClientName(ClientModel? client) {
    if (client == null) {
      return _clientNameController;
    }
    _clientNameController.text = client.name;
    return _clientNameController;
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
              widget.client == null ? Text(
                'Add Client', textAlign: TextAlign.left, style: Theme
                  .of(context)
                  .textTheme
                  .headlineSmall,) :  Text(
          'Update Client', textAlign: TextAlign.left, style: Theme
            .of(context)
            .textTheme
            .headlineSmall,),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Client Name',
                ),
                controller: setClientName(widget.client),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Client Name';
                  }
                  return null;
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
                      if (_formKey.currentState!.validate()) {
                        final client = ClientModel(
                          id: DateTime
                              .now()
                              .millisecondsSinceEpoch
                              .toString(),
                          name: _clientNameController.text,
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
