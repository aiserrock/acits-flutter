import 'dart:math';

import 'package:acits_flutter/ui/screen/debug_screen/debug_screen.dart';
import 'package:acits_flutter/ui/screen/root_screen.dart';
import 'package:acits_flutter/util/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:shimmer/shimmer.dart';

import 'package:acits_flutter/api/openapi.swagger.dart';

import 'package:acits_flutter/domain/exception.dart';
import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/gen/assets.gen.dart';
import 'package:acits_flutter/generated/l10n.dart';
import 'package:acits_flutter/res/color.dart';
import 'package:acits_flutter/res/style.dart';
import 'package:acits_flutter/service/auth/auth_service.dart';
import 'package:acits_flutter/ui/screen/auth/pick_shelter_screen.dart';
import 'package:acits_flutter/ui/widget/button.dart';
import 'package:acits_flutter/ui/widget/debug_drawer.dart';

/// Экран входа по логину - паролю
class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final AuthService _authService;
  final loginFormKey = GlobalKey<FormState>();
  final passNode = FocusNode();
  final loginController = TextEditingController();
  final passController = TextEditingController();
  double _maxHeight = 0.0;
  bool _isObscure = true;
  String? _errorMessage;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _authService = getIt<AuthService>();
  }

  @override
  void dispose() {
    loginController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const Drawer(
        child: DebugDrawerContent(),
      ),
      appBar: AppBar(
        backgroundColor: ColorRes.foreground,
        shadowColor: Colors.transparent,
        title: Assets.image.logoBar.svg(),
        centerTitle: true,
      ),
      backgroundColor: ColorRes.background,
      body: KeyboardDismissOnTap(
        child: LayoutBuilder(builder: (_, cons) {
          _maxHeight = max(_maxHeight, cons.maxHeight);
          return SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: _buildContent(_maxHeight),
          );
        }),
      ),
    );
  }

  Widget _buildContent(double maxHeight) {
    return SizedBox(
      height: maxHeight,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 40.0),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildForm(),
              ),
            ),
            const SizedBox(height: 16.0),
            _buildLoginButton(),
            const SizedBox(height: 16.0),
            MaterialButton(
              onPressed: () {},
              child: Text(
                StringRes.current.loginToRegistration,
                style: const TextStyle(
                  color: ColorRes.accent,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            const Spacer(),
            Text(
              StringRes.current.loginDescribeMsg,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return !_isLoading
        ? PrimaryButton(
            onPressed: _submit,
            onLongPress: _openDebug,
            text: StringRes.current.loginEntryBtn.toUpperCase(),
          )
        : Shimmer.fromColors(
            baseColor: ColorRes.accent,
            highlightColor: ColorRes.background,
            child: PrimaryButton(
              onPressed: _submit,
              text: StringRes.current.loginEntryBtn.toUpperCase(),
            ),
          );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Form(
              key: loginFormKey,
              child: AutofillGroup(
                child: Column(
                  children: [
                    SizedBox(
                      height: 72.0,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: TextFormField(
                          controller: loginController,
                          validator: Validator.emptyValidator,
                          autofillHints: const [AutofillHints.email],
                          decoration: InputDecoration(
                            hintText: StringRes.current.loginLoginHint,
                            labelText: StringRes.current.loginLoginLabel,
                            floatingLabelStyle: const TextStyle(color: ColorRes.accent),
                            errorStyle: const TextStyle(fontSize: 0.0),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: ColorRes.accent, width: 2.0),
                            ),
                          ),
                          cursorColor: ColorRes.accent,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () {
                            TextInput.finishAutofillContext();
                            FocusScope.of(context).requestFocus(passNode);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 72.0,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: TextFormField(
                          controller: passController,
                          focusNode: passNode,
                          validator: Validator.emptyValidator,
                          autofillHints: const [AutofillHints.password],
                          decoration: InputDecoration(
                            labelText: StringRes.current.loginPassLabel,
                            floatingLabelStyle: const TextStyle(color: ColorRes.accent),
                            errorStyle: const TextStyle(fontSize: 0.0),
                            suffixIcon: CupertinoButton(
                              onPressed: () => setState(() => _isObscure = !_isObscure),
                              child: _isObscure
                                  ? Assets.icon.visible.svg()
                                  : Assets.icon.visibleOff.svg(),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: ColorRes.accent, width: 2.0),
                            ),
                          ),
                          obscureText: _isObscure,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          onEditingComplete: () {
                            TextInput.finishAutofillContext();
                            _submit();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (_errorMessage != null)
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  _errorMessage!,
                  style: StyleRes.error,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                ),
              ),
          ],
        ),
        Container(
          transform: Transform.translate(offset: const Offset(-16.0, 8.0)).transform,
          child: MaterialButton(
            padding: const EdgeInsets.all(16.0),
            onPressed: () {},
            child: Text(
              StringRes.current.loginForgetPass,
              style: const TextStyle(
                color: ColorRes.textSecondary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _submit() async {
    if (_isLoading) return;
    if (loginFormKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      await _authService
          .login(loginController.text, passController.text)
          .then((value) async => _pickShelter())
          .onError(
        (error, _) {
          if (error is NotAuthorizedException) {
            setState(() => _errorMessage = StringRes.current.loginAuthorizeError);
          } else {
            setState(() => _errorMessage = error.toString());
          }
        },
      ).whenComplete(() => setState(() => _isLoading = false));
    }
  }

  Future<void> _pickShelter() async {
    final list = await _authService.getShelterList().onError(
      (error, _) {
        if (error is NotAuthorizedException) {
          setState(() => _errorMessage = StringRes.current.loginAuthorizeError);
        } else {
          setState(() => _errorMessage = error.toString());
        }
      },
    );
    if (list != null) {
      final selectedShelter = await Navigator.of(context).push<ShelterShortSerializers?>(
          MaterialPageRoute(builder: (_) => PickShelterList(shelterList: list)));
      if (selectedShelter != null) {
        await _authService.setCurrentShelter(selectedShelter.id!);
        _onSuccess();
      }
    }
  }

  void _onSuccess() {
    setState(() => _errorMessage = null);
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const RootScreen()));
  }

  void _openDebug() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const DebugScreen()));
  }
}
