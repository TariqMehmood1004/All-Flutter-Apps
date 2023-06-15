import 'package:app/screens/unlock_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_screen/flutter_secure_screen.dart';
import 'package:lottie/lottie.dart';
import '../common/common.dart';
import '../db/loaded_account.dart';
import '../pmp/theme.dart';
import '../pmp/widgets/padding.dart';
import '../pmp/widgets/three_widget_button.dart';
import 'login_screen.dart';
import 'payment_cards_screen.dart';
import 'passwords_screen.dart';
import 'settings_screen.dart';
import 'id_cards_screen.dart';
import 'identities_screen.dart';
import 'notes_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  static const routeName = '/main';

  @override
  State<StatefulWidget> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver, RouteAware {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final LoadedAccount _account = data.loadedAccount!;
  bool _unlockScreenOn = false;

  void _logOut() {
    data.unloadAccount();
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }

  Future<bool> _onWillPop() {
    _logOut();
    return Future.value(false);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (_unlockScreenOn) return;
    _unlockScreenOn = true;
    Navigator.pushNamed(context, UnlockScreen.routeName)
        .then((value) => _unlockScreenOn = false);
  }

  @override
  Future<bool> didPushRoute(String route) {
    if (route == UnlockScreen.routeName) _unlockScreenOn = true;
    return Future.value(true);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    routeObserver.unsubscribe(this);
  }

  @override
  void initState() {
    super.initState();
    FlutterSecureScreen.singleton
        .setAndroidScreenSecure(_account.protectScreen);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: PmpTheme.appbarcolor,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text('PMP',
              style: TextStyle(
                color: Color.fromARGB(255, 250, 250, 250),
              )),
          leading: IconButton(
            splashRadius: PmpTheme.appBarButtonSplashRadius,
            padding: PmpTheme.appBarButtonPadding,
            icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
            onPressed: _logOut,
          ),
          actions: [
            IconButton(
              padding: PmpTheme.appBarButtonPadding,
              onPressed: () =>
                  Navigator.pushNamed(context, SettingsScreen.routeName),
              icon: const Icon(Icons.settings, color: Colors.white),
              splashRadius: PmpTheme.appBarButtonSplashRadius,
            ),
          ],
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.29,
                child: Image.asset(
                  "assets/images/hbg.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.593,
                child: GridView(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 1.2),
                  children: [
                    PmpPadding(ThreeWidgetButton(
                      right: const Text('Passwords',
                          style: TextStyle(
                              color: PmpTheme.appbarcolor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      center: Padding(
                        padding: const EdgeInsets.only(),
                        child: Lottie.asset("assets/images/password.json"),
                      ),
                      onPressed: () => Navigator.pushNamed(
                          context, PasswordsScreen.routeName),
                    )),
                    PmpPadding(ThreeWidgetButton(
                      center: Lottie.asset("assets/images/payment.json"),
                      right: const Text('Payment cards',
                          style: TextStyle(
                              color: PmpTheme.appbarcolor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      onPressed: () => Navigator.pushNamed(
                          context, PaymentCardsScreen.routeName),
                    )),
                    PmpPadding(ThreeWidgetButton(
                      center: Lottie.asset("assets/images/notes.json"),
                      right: const Text('Notes',
                          style: TextStyle(
                              color: PmpTheme.appbarcolor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      onPressed: () =>
                          Navigator.pushNamed(context, NotesScreen.routeName),
                    )),
                    PmpPadding(ThreeWidgetButton(
                      center: Lottie.asset("assets/images/id.json"),
                      right: const Text('ID cards',
                          style: TextStyle(
                              color: PmpTheme.appbarcolor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      onPressed: () =>
                          Navigator.pushNamed(context, IDCardsScreen.routeName),
                    )),
                    PmpPadding(ThreeWidgetButton(
                      center: Lottie.asset("assets/images/identity.json"),
                      right: const Text('Identities',
                          style: TextStyle(
                              color: PmpTheme.appbarcolor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      onPressed: () => Navigator.pushNamed(
                          context, IdentitiesScreen.routeName),
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
