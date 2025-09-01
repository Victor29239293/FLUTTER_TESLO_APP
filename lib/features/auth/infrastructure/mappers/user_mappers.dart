import 'package:flutter_teslo_app/features/auth/infrastructure/models/login_response.dart';

import '../../domain/domain.dart';

class UserMapper {
  static User toEntity(LoginResponse user) => User(
    id: user.id,
    email: user.email,
    fullname: user.fullName,
    roles: user.roles,
    token: user.token,
  );
}
