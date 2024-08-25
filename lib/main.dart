import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("Payment Successful: ${response.paymentId}");
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Payment Successful"),
        content: Text("Payment ID: ${response.paymentId}"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Error: ${response.code} - ${response.message}");
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Payment Error"),
        content: Text("Error: ${response.message}"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("External Wallet: ${response.walletName}");
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("External Wallet"),
        content: Text("Wallet Name: ${response.walletName}"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  void openCheckout() {
    var options = {
      'key': 'rzp_test_PZ8aYGY7pJrzX2',
      'amount': 100, // Amount in paise (100 paise = 1 INR)
      'name': 'Razorpay Test',
      'description': 'Test Payment',
      'prefill': {
        'contact': '8888888888',
        'email': 'test@razorpay.com'
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Razorpay Payment Example'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: openCheckout,
            child: Text('Open Razorpay Checkout'),
          ),
        ),
      ),
    );
  }
}
