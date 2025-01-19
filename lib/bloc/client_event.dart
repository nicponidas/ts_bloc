part of 'client_bloc.dart';


abstract class ClientEvent extends Equatable {
  const ClientEvent();

  @override
  List<Object> get props => [];
}


class ClientLoad extends ClientEvent {}

class ClientAdd extends ClientEvent {
  final ClientModel client;

  const ClientAdd({required this.client});

  @override
  List<Object> get props => [client];
}

class ClientUpdate extends ClientEvent {
  final ClientModel client;

  const ClientUpdate({required this.client});

  @override
  List<Object> get props => [client];
}

class ClientDelete extends ClientEvent {
  final String clientId;

  const ClientDelete({required this.clientId});

  @override
  List<Object> get props => [clientId];
}
