import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

import '../../app.dart';
import 'bloc/my_page.dart';

@RoutePage(name: 'MyPageRoute')
class MyPagePage extends StatefulWidget {
  const MyPagePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyPagePageState();
  }
}

class _MyPagePageState extends BasePageState<MyPagePage, MyPageBloc> {
  LanguageCode languageCode = LanguageCode.defaultValue;


  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              BlocBuilder<AppBloc, AppState>(
                buildWhen: (previous, current) => previous.isDarkTheme != current.isDarkTheme,
                builder: (context, state) {
                  return SwitchListTile.adaptive(
                    title: Text(
                      localisation.darkTheme,
                      style: AppTextStyles.s14w400Primary(),
                    ),
                    tileColor: AppColors.current.primaryColor,
                    value: state.isDarkTheme,
                    onChanged: (isDarkTheme) => appBloc.add(
                      AppThemeChanged(isDarkTheme: isDarkTheme),
                    ),
                  );
                },
              ),
              BlocBuilder<AppBloc, AppState>(
                buildWhen: (previous, current) => previous.languageCode != current.languageCode,
                builder: (context, state) {
                  return SizedBox(
                    height: 400,
                    child: ListView(
                      children: LanguageCode.values
                          .map((value) => RadioListTile.adaptive(
                              value: value,
                              groupValue: languageCode,
                              title: Text(value.serverValue),
                              onChanged: (currentLanguageCode) {
                                languageCode = currentLanguageCode!;
                                appBloc.add(AppLanguageChanged(
                                    languageCode: currentLanguageCode));
                              }))
                          .toList(),
                    ),
                  );
                },
              ),
              SizedBox(height: Dimens.d15.responsive()),
              ElevatedButton(
                onPressed: () => bloc.add(const LogoutButtonPressed()),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(AppColors.current.primaryColor),
                ),
                child: Text(
                  localisation.logout,
                  style: AppTextStyles.s14w400Primary(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
