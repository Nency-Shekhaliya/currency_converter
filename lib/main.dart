import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/helpers/api_helper.dart';
import 'models/helpers/currency_class.dart';

void main() {
  runApp(
    const MyCurrencyapp(),
  );
}

class MyCurrencyapp extends StatefulWidget {
  const MyCurrencyapp({Key? key}) : super(key: key);

  @override
  State<MyCurrencyapp> createState() => _MyCurrencyappState();
}

class _MyCurrencyappState extends State<MyCurrencyapp> {
  String from = 'Selected country';
  String To = 'Selected country';
  String amount = "amount";
  String hintf = "From";
  String hintt = "To";
  int from1 = 0;
  int To1 = 0;

  String amount1 = '0';
  bool isandroid = true;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return isandroid
        ? MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Builder(
              builder: (context) => Scaffold(
                appBar: AppBar(
                  title: const Text("Currency Converter"),
                  centerTitle: true,
                  backgroundColor: Colors.teal,
                  actions: [
                    const SizedBox(
                      width: 40,
                    ),
                    Switch(
                        activeColor: Colors.white,
                        trackColor: MaterialStateProperty.all(
                            Colors.white.withOpacity(0.5)),
                        value: isandroid,
                        onChanged: (val) {
                          setState(() {
                            isandroid = val;
                          });
                        })
                  ],
                ),
                resizeToAvoidBottomInset: false,
                body: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(bottom: 20),
                        height: 30,
                        width: 300,
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                spreadRadius: 1,
                                blurRadius: 5,
                                color: Colors.grey)
                          ],
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.teal,
                        ),
                        child: const Text(
                          "Select Country",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: DropdownButton(
                                isExpanded: true,
                                dropdownColor: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                elevation: 10,
                                menuMaxHeight: 350,
                                hint: Text(
                                  hintf ?? "From",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                items: Currency.Currencydata.map(
                                    (e) => DropdownMenuItem(
                                        onTap: () {
                                          hintf = e['country'];
                                        },
                                        value: e['currency_code'],
                                        child: Text(e['country']))).toList(),
                                onChanged: (val) {
                                  setState(() {
                                    from = val.toString();
                                  });
                                }),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 2,
                            child: DropdownButton(
                                // value: To,
                                elevation: 10,
                                isExpanded: true,
                                menuMaxHeight: 350,
                                hint: Text(
                                  hintt ?? "From",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                items: Currency.Currencydata.map(
                                    (e) => DropdownMenuItem(
                                        onTap: () {
                                          hintt = e['country'];
                                        },
                                        value: e['currency_code'],
                                        child: Text(e['country']))).toList(),
                                onChanged: (val) {
                                  setState(() {
                                    To = val.toString();
                                  });
                                }),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        onChanged: (val) {
                          setState(() {
                            amount = val;
                          });
                        },
                        cursorColor: Colors.teal,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 5)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.teal, width: 1.5)),
                            hintText: "₹ Amount",
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "${from}",
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const Icon(Icons.arrow_right_alt),
                          Text(
                            " ${To}",
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      Expanded(
                        child: FutureBuilder(
                          future: Apihelper.apihelper.getdata(
                              from: '${from}',
                              to: '${To}',
                              amount: '${amount}'),
                          builder: (context, snapShot) {
                            if (snapShot.hasError) {
                              return Text("${snapShot.error}");
                            } else if (snapShot.hasData) {
                              Map? p = snapShot.data;
                              return Column(children: [
                                const SizedBox(
                                  height: 100,
                                ),
                                Container(
                                  height: 50,
                                  width: 330,
                                  alignment: Alignment.center,
                                  child: Text.rich(TextSpan(children: [
                                    const TextSpan(
                                      text: "Result : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          letterSpacing: 2,
                                          color: Colors.teal),
                                    ),
                                    TextSpan(
                                      text: "${p!['new_amount']} ",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          letterSpacing: 3,
                                          color: Colors.black),
                                    ),
                                    TextSpan(
                                      text: "${To}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          letterSpacing: 3,
                                          color: Colors.grey),
                                    )
                                  ])),
                                ),
                              ]);
                            }
                            return Center(
                              child: Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(top: 30),
                                height: 50,
                                width: 200,
                                decoration: BoxDecoration(
                                    color: Colors.teal,
                                    borderRadius: BorderRadius.circular(25)),
                                child: const Text(
                                  "Convert",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      letterSpacing: 3,
                                      color: Colors.white),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : CupertinoApp(
            debugShowCheckedModeBanner: false,
            home: Builder(
              builder: (context) => CupertinoPageScaffold(
                  resizeToAvoidBottomInset: false,
                  navigationBar: CupertinoNavigationBar(
                    backgroundColor: Colors.teal,
                    middle: const Text(
                      "Currency Converter",
                      style: TextStyle(color: CupertinoColors.white),
                    ),
                    trailing: CupertinoSwitch(
                      onChanged: (val) {
                        setState(() {
                          isandroid = val;
                        });
                      },
                      value: isandroid,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(bottom: 20),
                          height: 30,
                          width: 300,
                          decoration: BoxDecoration(
                            boxShadow: [
                              const BoxShadow(
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  color: Colors.grey)
                            ],
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.teal,
                          ),
                          child: const Text(
                            "Select Country",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          height: 20,
                          width: 350,
                          child: const Text(
                            "From",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal),
                          ),
                        ),
                        SizedBox(
                          height: 130,
                          child: CupertinoPicker(
                            itemExtent: 30,
                            onSelectedItemChanged: (val) {
                              setState(() {
                                from1 = val;
                                print(from1);
                              });
                            },
                            children: Currency.Currencydata.map(
                              (e) => Text(
                                e['country'],
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ).toList(),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          height: 20,
                          width: 350,
                          child: const Text(
                            "To",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal),
                          ),
                        ),
                        SizedBox(
                            height: 130,
                            child: CupertinoPicker(
                              itemExtent: 30,
                              onSelectedItemChanged: (val) {
                                setState(() {
                                  To1 = val;
                                  print(To1);
                                });
                              },
                              children: Currency.Currencydata.map(
                                (e) => Text(
                                  e['country'],
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ).toList(),
                            )),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          height: 20,
                          width: 350,
                          child: const Text(
                            "Enter Amount",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CupertinoTextField(
                          placeholder: "₹ amount",
                          placeholderStyle: const TextStyle(
                              color: CupertinoColors.systemGrey),
                          cursorColor: CupertinoColors.black,
                          style: const TextStyle(color: CupertinoColors.black),
                          onChanged: (val) {
                            setState(() {
                              amount1 = val;
                            });
                          },
                        ),
                        Expanded(
                          child: FutureBuilder(
                            future: Apihelper.apihelper.getdata(
                              from:
                                  "${Currency.Currencydata[from1]['currency_code']}",
                              to: "${Currency.Currencydata[To1]['currency_code']}",
                              amount: amount1,
                            ),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              } else if (snapshot.hasData) {
                                Map? p = snapshot.data;
                                return Column(
                                  children: [
                                    const SizedBox(
                                      height: 50,
                                    ),
                                    Container(
                                      height: 50,
                                      width: 330,
                                      alignment: Alignment.center,
                                      child: Text.rich(TextSpan(children: [
                                        const TextSpan(
                                          text: "Result : ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              letterSpacing: 2,
                                              color: Colors.teal),
                                        ),
                                        TextSpan(
                                          text: "${p!['new_amount']} ",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              letterSpacing: 3,
                                              color: Colors.black),
                                        ),
                                      ])),
                                    ),
                                  ],
                                );
                              }
                              return Center(
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(top: 30),
                                  height: 50,
                                  width: 200,
                                  decoration: BoxDecoration(
                                      color: Colors.teal,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: const Text(
                                    "Convert",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        letterSpacing: 3,
                                        color: Colors.white),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  )),
            ),
          );
  }
}
