part of 'client_bloc.dart';

abstract class ClientState extends Equatable {
  const ClientState();

  @override
  List<Object> get props => [];
}

class ClientInitial extends ClientState {}

class ClientLoading extends ClientState {}

class ClientLoaded extends ClientState {
  final List<ClientModel> clients;

  const ClientLoaded({required this.clients});

  @override
  List<Object> get props => [clients];
}

class ClientError extends ClientState {
  final String error;

  const ClientError({required this.error});

  @override
  List<Object> get props => [error];
}