import 'package:cashual/cash_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:cash_ui/cash_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(CashualApplication());
}

class CashualApplication extends StatelessWidget {
  const CashualApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp.router(
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
        brightness: Brightness.light,
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(
            fontFamily: "Rubik",
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      builder: (context, child) =>
          CashTheme(mode: CashThemeMode.light, child: child!),
      routerConfig: createRouter(),
    );
  }
}
