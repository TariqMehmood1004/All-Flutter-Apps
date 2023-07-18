<table>
<h1>Output</h1>
    <tr>
        <th>Screen 1</th>
        <th>Screen 2</th>
        <th>Screen 3</th>
        <th>Screen 4</th>
    </tr>
    <tr>
        <td><img src= "https://github.com/TariqMehmood1004/FlutterApp/blob/main/Output/1.jpg" alt="Output results"></td>
        <td><img src= "https://github.com/TariqMehmood1004/FlutterApp/blob/main/Output/2.jpg" alt="Output results"></td>
        <td><img src= "https://github.com/TariqMehmood1004/FlutterApp/blob/main/Output/3.jpg" alt="Output results"></td>
        <td><img src= "https://github.com/TariqMehmood1004/FlutterApp/blob/main/Output/4.jpg" alt="Output results"></td>
    </tr>
</table>
</hr>
<h1>Documentation</h1>
<h2>1. Splash Screen Widget</h2>
<em>
        <b>Timer() method get duration, and navigator</b>.<br>
        Duration - After how many seconds the navigated page route opens.<br>
        MaterialPageRoute() method get contex to returns screen route.<br>
</em>
<pre>
@override
        void initState() {
        super.initState();
        Timer(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
        context,
        //MaterialPageRoute() method get contex to returns screen route.
        MaterialPageRoute(
        builder: (context) =>
        const DashboardScreen(title: "Dashboard Screen"),
        ),
        );
    }
);
</pre>