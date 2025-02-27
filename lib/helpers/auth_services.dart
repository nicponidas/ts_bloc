import 'package:supabase_flutter/supabase_flutter.dart';

class AuthServices {


  final SupabaseClient supabaseClient;

  AuthServices(this.supabaseClient);

  String userName() => supabaseClient.auth.currentUser?.userMetadata?['userName'];
  String userEmail() => supabaseClient.auth.currentUser!.email!;
  String userId() => supabaseClient.auth.currentUser!.id;

}
