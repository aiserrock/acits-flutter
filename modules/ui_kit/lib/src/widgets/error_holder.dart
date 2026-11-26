import 'dart:math';

import 'package:material_ui/material_ui.dart';
import 'package:lottie/lottie.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:util/util.dart';

import '../../gen/assets.gen.dart';
import '../components/primary_button.dart';

const _sizePart = .75;

class ErrorHolderWidget extends StatelessWidget {
  const ErrorHolderWidget({
    this.error,
    this.assetPath,
    this.onPressed,
    this.title,
    this.message,
    this.button,
    super.key,
  });

  final String? assetPath;
  final String? title;
  final String? message;
  final String? button;
  final Failure? error;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, cons) {
        final size = min(cons.maxHeight, cons.maxWidth) * _sizePart;
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(assetPath ?? Assets.lottie.crash1, height: size, width: size),
                const SizedBox(height: 24.0),
                Text(
                  title ?? error?.title ?? '',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16.0),
                Text(
                  message ?? error?.message ?? '',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24.0),
                PrimaryButton(onPressed: () => onPressed?.call(), text: button ?? 'commonReloadBtn'.tr()),
              ],
            ),
          ),
        );
      },
    );
  }
}

extension _FailureX on Failure {
  String get title => switch (this) {
    NoInternet() => 'errorInternetFail'.tr(),
    Timeout() => 'errorTimeoutFail'.tr(),
    // 4xx — запрос отклонён (валидация, конфликт), сервер жив. Говорить
    // «сервер недоступен» здесь неверно и уводит от реальной причины.
    ServerFailure(:final code) when code >= 400 && code < 500 => 'commonError'.tr(),
    ServerFailure() => 'errorServerFail'.tr(),
    AuthFailure() => 'errorAuthFail'.tr(),
    ForbiddenFailure() => 'errorForbidden'.tr(),
    ParseFailure() || UnknownFailure() || EmailLinkRejected() => 'commonError'.tr(),
  };

  String get message => switch (this) {
    NoInternet() => 'errorInternetFailMsg'.tr(),
    Timeout() => 'errorTimeoutFailMsg'.tr(),
    // Тело ответа объясняет, что именно не так (какое поле не прошло
    // валидацию) — показываем его вместо общей фразы, если сервер прислал.
    ServerFailure(:final code, :final note) when code >= 400 && code < 500 =>
      note?.isNotEmpty ?? false ? note! : 'errorDefaultMsg'.tr(),
    ServerFailure() => 'errorServerFailMsg'.tr(),
    AuthFailure() => 'errorAuthFailMsg'.tr(),
    ForbiddenFailure() => 'errorForbiddenMsg'.tr(),
    ParseFailure() || UnknownFailure() || EmailLinkRejected() => 'errorDefaultMsg'.tr(),
  };
}
