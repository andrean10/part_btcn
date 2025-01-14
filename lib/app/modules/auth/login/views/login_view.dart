import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:part_btcn/app/modules/widgets/textformfield/custom_textform_field.dart';
import 'package:part_btcn/utils/constants_assets.dart';

import '../../../../../shared/shared_theme.dart';
import '../../../../helpers/validations.dart';
import '../../../widgets/buttons/buttons.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = context.textTheme;
    final size = context.mediaQuerySize;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              ConstantsAssets.imgSplash,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Positioned.fill(
              top: size.height / 5,
              child: ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  color: theme.colorScheme.surface,
                  padding: EdgeInsets.fromLTRB(
                    size.width * 0.1,
                    size.height / 8,
                    size.width * 0.1,
                    24,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Selamat Datang Kembali',
                          style: textTheme.headlineSmall?.copyWith(
                            fontWeight: SharedTheme.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Masuk ke akun anda',
                          style: textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 24),
                        _builderForm(),
                        const SizedBox(height: 32),
                        _builderButton(),
                        const SizedBox(height: 62),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 62),
                          child: SvgPicture.asset(
                            ConstantsAssets.icLogoApp,
                            height: 62,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _builderForm() {
    return Form(
      key: controller.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _builderEmail(),
          const SizedBox(height: 21),
          _builderPassword(),
          // const Spacer(),
        ],
      ),
    );
  }

  Widget _builderButton() {
    return Obx(
      () {
        final isEnabled = controller.email.value.isNotEmpty &&
            controller.password.value.isNotEmpty;
        final isLoading = controller.isLoading.value;

        return Buttons.filled(
          width: double.infinity,
          state: isEnabled && isLoading,
          onPressed: isEnabled && !isLoading ? controller.confirm : null,
          child: const Text('Login'),
        );
      },
    );
  }

  Widget _builderEmail() {
    return Obx(
      () => CustomTextFormField(
        controller: controller.emailC,
        focusNode: controller.emailF,
        title: 'Email',
        // hintText: ConstantsStrings.hintUsernameOrEmail,
        isFilled: true,
        isLabel: true,
        prefixIcon: Icons.person_rounded,
        suffixIconState: controller.email.value.isNotEmpty,
        keyboardType: TextInputType.emailAddress,
        textCapitalization: TextCapitalization.none,
        maxLines: 1,
        validator: (value) => Validation.formField(
          value: value,
          titleField: 'Email',
          isEmail: true,
        ),
        errorText: controller.errMsg.value != null ? '' : null,
        onFieldSubmitted: (_) => controller.nextFocus(controller.passwordF),
      ),
    );
  }

  Widget _builderPassword() {
    return Obx(
      () => CustomTextFormField(
        controller: controller.passwordC,
        focusNode: controller.passwordF,
        title: 'Password',
        isFilled: true,
        isLabel: true,
        prefixIcon: Icons.lock_rounded,
        suffixIconState: controller.password.value.isNotEmpty,
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.done,
        suffixIcon: IconButton(
          onPressed: controller.setHidePassword,
          icon: Icon(
            controller.isHidePassword.value
                ? Icons.visibility_off_rounded
                : Icons.visibility_rounded,
          ),
        ),
        obscureText: controller.isHidePassword.value,
        validator: (value) => Validation.formField(
          value: value,
          titleField: 'Password',
          minLengthChar: 6,
        ),
        errorText: controller.errMsg.value,
        onFieldSubmitted: (_) => controller.confirm(),
      ),
    );
  }
}

// Clipper untuk membentuk lengkungan
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 0);

    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.15,
      size.width * 0.5,
      size.height * 0.1,
    );

    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.05,
      size.width,
      size.height * 0.15,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
