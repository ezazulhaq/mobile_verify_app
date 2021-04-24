// @dart = 2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobil_verify_app/screens/login_screen.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:toast/toast.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController amountController = TextEditingController();
  Razorpay razorpay;

  @override
  void initState() {
    super.initState();
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerPaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void openCheckOut() {
    var options = {
      "key": "rzp_test_xinn3aPAwxT7I1",
      "amount": num.parse(amountController.text) * 100,
      "name": "Sample App",
      "description": "Payment of some random Product",
      "prefill": {"contact": "", "email": "asfasdf@gmail.com"},
      "external": {
        "wallet": ["paytm"]
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void handlerPaymentSuccess() {
    print("Payment Successful");
    Toast.show("Payment Successful", context);
  }

  void handlerPaymentError() {
    print("Payment Failed");
    Toast.show("Payment Failed", context);
  }

  void handlerExternalWallet() {
    print("Payment Through External Wallet");
    Toast.show("Payment Through External Wallet", context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Razor Pay",
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Spacer(),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Amount",
              ),
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Container(
              height: 50.0,
              width: double.infinity,
              color: Colors.blue,
              child: TextButton(
                onPressed: () {
                  openCheckOut();
                },
                child: Text(
                  "PAY NOW",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Spacer(),
            SizedBox(
              height: 25.0,
            ),
            Spacer(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _auth.signOut();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        },
        child: Icon(Icons.logout),
      ),
    );
  }
}
