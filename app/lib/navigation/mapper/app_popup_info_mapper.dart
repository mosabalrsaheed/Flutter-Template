import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:resources/resources.dart';
import 'package:shared/shared.dart';

import '../../app.dart';

@LazySingleton(as: BasePopupInfoMapper)
class AppPopupInfoMapper extends BasePopupInfoMapper {
  @override
  Widget map(AppPopupInfo appPopupInfo, AppNavigator navigator) {
    return appPopupInfo.when(
      confirmDialog: (message, onPressed) {
        return CommonDialog(
          actions: [
            PopupButton(
              text: localisation.ok,
              onPressed: onPressed ?? Func0(() => navigator.pop()),
            ),
          ],
          message: message,
        );
      },
      errorWithRetryDialog: (message, onRetryPressed) {
        return CommonDialog(
          actions: [
            PopupButton(
              text: localisation.cancel,
              onPressed: Func0(() => navigator.pop()),
            ),
            PopupButton(
              text: localisation.retry,
              onPressed: onRetryPressed ?? Func0(() => navigator.pop()),
              isDefault: true,
            ),
          ],
          message: message,
        );
      },
      requiredLoginDialog: () => CommonDialog.adaptive(
        title: localisation.login,
        message: localisation.login,
        actions: [
          PopupButton(
            text: localisation.cancel,
            onPressed: Func0(() => navigator.pop()),
          ),
          PopupButton(
            text: localisation.login,
            onPressed: Func0(() async {
              await navigator.pop();
              await navigator.push(const AppRouteInfo.login());
            }),
          ),
        ],
      ),
    );
  }
}
