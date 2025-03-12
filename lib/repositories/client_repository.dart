import 'package:time_sheet/dummy_data/dummy_data.dart';
import 'package:time_sheet/models/client_model.dart';

class ClientRepository {

  final List<ClientModel> _clients =listOfClient;


  Future<List<ClientModel>> getClients() async => _clients..sort((elt1, elt2) => elt1.name.compareTo(elt2.name));

  Future<void> addClient(ClientModel client) async => _clients.add(client);

  void removeClient(int clientId) =>
      _clients.removeWhere((element) => element.id == clientId);

  void updateClient(ClientModel client) {
    final index = _clients.indexWhere((element) => element.id == client.id);
    if (index != -1) {
      _clients[index] = client;
    }
  }
}
