const functions = require("firebase-functions");

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

const braintree = require('braintree');
const gateway = new braintree.BraintreeGateway({
    environment: braintree.Environment.Sandbox,
    merchantId: '5zmrfhddbdxxmt33',
    publicKey: '336bk4cbdz23bhcx',
    privateKey: '837055ee045b213512345486cbeb7c94'
});

exports.paypalPayment = functions.https.onRequest(async (req, res) => {
    const nonceFromTheClient = req.body.payment_method_nonce;
    const deviceData = req.body.device_data;
    const amount0 = req.body.amount;

    gateway.transaction.sale({
        amount: amount0,
        // for deployment paymentMethodNonce: nonceFromTheClient,
        //for testing
        paymentMethodNonce: 'fake-paypal-nonce',
        deviceData: deviceData,
        options:{
            submitForSettlement: true
        }
    }, (err, result) => {
        if(err != null){
            console.log(err);
        }
        //deployment use actual result from above
        else{
            res.json({
                result: 'success'
            });
        }
    }
    )
})