import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_sheet/bloc/client_bloc.dart';
import 'package:time_sheet/models/client_model.dart';
import 'package:time_sheet/widgets/add_client_form.dart';

class ClientTile extends StatelessWidget {
  const ClientTile({super.key, required this.clientModel});

  final ClientModel clientModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Color(clientModel.clientColor).withAlpha(150),
        child: Text(clientModel.shortName, textAlign: TextAlign.center,),
      ),
      title: Text(clientModel.name),
      trailing: Row(
        spacing: 5.0,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton.filledTonal(
            icon: const Icon(Icons.edit),
            color: Colors.green,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: AddClientForm(client: clientModel),
                ),
              );
            },
          ),
          IconButton.filledTonal(
            icon: const Icon(Icons.delete_outline),
            color: Colors.red,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Remove Client'),
                  content: Text(
                      'Are you sure you want to remove: \n"${clientModel.name}"?'),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel')),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        context
                            .read<ClientBloc>()
                            .add(ClientDelete(clientId: clientModel.id));
                        context.read<ClientBloc>().add(ClientLoad());
                      },
                      child: const Text('Remove'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
