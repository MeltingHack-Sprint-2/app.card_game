import 'dart:convert';

import 'package:card_game/core/apis/api_client.dart';
import 'package:card_game/core/apis/api_request.dart';
import 'package:card_game/core/apis/api_request_extension.dart';
import 'package:card_game/core/errors/error_mapper.dart';
import 'package:either_dart/either.dart';

class JoinOrHostGameUsecase {
  Future<Either<GenericResponseError, ResponseModel>> execute({
    required String action,
    required String room,
    required String name,
    String? handSize,
  }) async {
    final request = APIRequest(
        route: "/api/game/allow",
        requestType: RequestType.post,
        params: action == "join"
            ? {
                "action": action,
                "name": name,
                "room": room,
              }
            : {
                "action": action,
                "name": name,
                "room": room,
                "hand_size": handSize ?? 7,
              });

    final response = await UnoClient().executeRequest(request: request);

    if (response.isSuccess()) {
      final Map<String, dynamic> decoded = json.decode(response.body);
      return Right(ResponseModel.fromJson(decoded));
    } else {
      final String errorMessage =
          ErrorMapper.mapStatusCodeToMessage(response.statusCode);
      return Left(GenericResponseError(errorMessage: errorMessage));
    }
  }
}

class ResponseModel {
  final bool allow;
  final String? reason;

  ResponseModel({required this.allow, required this.reason});

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      allow: json["allow"],
      reason: json["reason"],
    );
  }
}
