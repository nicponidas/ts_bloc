import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:time_sheet/models/client_model.dart';
import 'package:time_sheet/repositories/client_repository.dart';

part 'client_event.dart';

part 'client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  final ClientRepository _clientRepository;

  ClientBloc({required ClientRepository clientRepository})
      : _clientRepository = clientRepository,
        super(ClientInitial()) {
    on<ClientLoad>((event, emit) async {
      emit(ClientLoading());
      try {
        final clients = await _clientRepository.getClients();
        emit(ClientLoaded(clients: clients));
      } catch (e) {
        emit(ClientError(error: e.toString()));
      }
    });

    on<ClientAdd>((event, emit) async {
      try {
        _clientRepository.addClient(event.client);
        final client = await _clientRepository.getClients();
        emit(ClientLoaded(clients: client));
      } catch (e) {
        emit(ClientError(error: e.toString()));
      }
    });

    on<ClientUpdate>((event, emit) async {
      _clientRepository.updateClient(event.client);
      final clients = await _clientRepository.getClients();
      emit(ClientLoaded(clients: clients));
    });

    on<ClientDelete>((event, emit) async {
      _clientRepository.removeClient(event.clientId);
      final clients = await _clientRepository.getClients();
      emit(ClientLoaded(clients: clients));
    });
  }
}
