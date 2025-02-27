import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_sheet/bloc/client_bloc.dart';
import 'package:time_sheet/pages/client_page.dart';
import 'package:time_sheet/widgets/add_client_form.dart';
import 'package:time_sheet/widgets/client_tile.dart';
import 'package:time_sheet/widgets/my_drawer.dart';

class ClientsListPage extends StatelessWidget {
  const ClientsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: const Text('Clients'),
      ),
      body: BlocBuilder<ClientBloc, ClientState>(
        builder: (context, state) {
          if (state is ClientInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ClientLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ClientLoaded) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: state.clients.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ClientPage(
                              client: state.clients.elementAt(index).id)));
                    },
                    child: Card(
                      child: ClientTile(
                        clientModel: state.clients.elementAt(index),
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is ClientError) {
            return Center(child: Text(state.error));
          } else {
            return const Center(child: Text('Nieznany stan'));
          }
        },
      ),
      floatingActionButton: IconButton.filledTonal(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: const AddClientForm(),
            ),
          );
        },
        icon: Icon(Icons.add),
      ),
    );
  }
}
