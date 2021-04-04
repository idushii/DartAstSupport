import 'package:project/imports.dart';
import 'package:project/screens/auth_screen.dart';
import 'package:project/screens/qr_scan_screen.dart';

class FirstScreen extends StatelessWidget {
  static const route = '/FirstScreen';

  static openPage(BuildContext context, {String payload}) {
    Navigator.of(context).pushNamed(
      route,
    );
  }


  @override
  Widget build(BuildContext context) {
    Api().ctxOpenNotification = context;

    if (Push().brone != null) {
      Navigator.pushNamedAndRemoveUntil(
          context, MyBookingScreen.route, ModalRoute.withName('/'), arguments: MyBookingScreenParams(Push().brone));
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              SizedBox(height: 24),
              Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur imperdiet ',
                      style: TextStyle(
                        fontWeight: AppFontWeight.w600,
                        color: AppColors.primaryBlack,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(child: Icon(Icons.logout), onTap: () {
                      logout();
                      Navigator.pushNamedAndRemoveUntil(context, AuthScreen.route, ModalRoute.withName('/'));
                    }),
                  ),
                ],
              ),
              SizedBox(height: 48),
              AppImages.qrCode,
              SizedBox(height: 24),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur imperdiet .',
                textAlign: TextAlign.center,
                style: AppTextStyles.TextParagraph3.copyWith(
                  color: AppColors.primaryBlack,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur imperdiet ',
                textAlign: TextAlign.center,
                style: AppTextStyles.TextParagraph4.copyWith(
                  color: AppColors.greyscaleGrey,
                ),
              ),
              Spacer(),
              MainBtn(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur imperdiet ',
                () {
                  Navigator.pushNamed(context, QrScanScreen.route);
                },
                invert: true,
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
