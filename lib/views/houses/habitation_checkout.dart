import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:insurrance/src/config/app_colors.dart';
import 'package:insurrance/src/model/habitation.dart';
import 'package:insurrance/src/model/habitation_devis.dart';
import 'package:insurrance/src/model/offer.dart';
import 'package:insurrance/views/car_inssurance/car_devis_form.dart';
import 'package:insurrance/views/houses/habitation_devis.dart';


class HabitationCheckout extends StatefulWidget {
 final Habitation habitation;

  Offer? offer;
  HabitationCheckout({super.key, required this.habitation, this.offer});

  @override
  State<HabitationCheckout> createState() => _HabitationCheckoutState();
}

class _HabitationCheckoutState extends State<HabitationCheckout> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double total = widget.habitation.tarif +
        double.parse(widget.offer != null ? widget.offer!.price : "0");

    double tax = 10;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text(
          'Checkout !',
          style: TextStyle(
              color: AppColors.primaryColor, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
            size: 25,
          ),
          onPressed: () async {
            Navigator.pop(context);
          },
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      body: Align(
        alignment: AlignmentDirectional(0, -1),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 24),
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  direction: Axis.horizontal,
                  runAlignment: WrapAlignment.start,
                  verticalDirection: VerticalDirection.down,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: 750,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4,
                            color: Color(0x33000000),
                            offset: Offset(
                              0,
                              2,
                            ),
                          )
                        ],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Your Cart',
                              style: TextStyle(
                                fontFamily: 'Outfit',
                                letterSpacing: 0,
                              ),
                            ),
                            const Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 4, 0, 12),
                              child: Text(
                                'Below is the list of items in your cart.',
                                style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0,
                                ),
                              ),
                            ),
                            ListView(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              children: [
                                PurchaseList(
                                  name: widget.habitation.nom,
                                  price: widget.habitation.tarif.toString(),
                                  desc: widget.habitation.nom,
                                  showRemove: false,
                                  onclick: () {},
                                ),
                                if (widget.offer != null)
                                  PurchaseList(
                                    name: widget.offer!.name,
                                    price: widget.offer!.price,
                                    desc: widget.offer!.attributes.first.title,
                                    showRemove: true,
                                    onclick: () {
                                      setState(() {
                                        widget.offer = null;
                                      });
                                    },
                                  )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      constraints: const BoxConstraints(
                        maxWidth: 430,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 4,
                            color: Color(0x33000000),
                            offset: Offset(
                              0,
                              2,
                            ),
                          )
                        ],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 24),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Order Summary',
                              style: TextStyle(
                                fontFamily: 'Outfit',
                                letterSpacing: 0,
                              ),
                            ),
                            const Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 4, 0, 12),
                              child: Text(
                                'Below is a list of your items.',
                                style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0,
                                ),
                              ),
                            ),
                            Divider(
                              height: 32,
                              thickness: 2,
                              color: Colors.green,
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 12),
                                    child: Text(
                                      'Price Breakdown',
                                      style: TextStyle(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 8),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Base Price',
                                          style: TextStyle(
                                            fontFamily: 'Outfit',
                                            color: Colors.grey,
                                            fontSize: 14,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Text(
                                          '$total €',
                                          textAlign: TextAlign.end,
                                          style: const TextStyle(
                                            fontFamily: 'Readex Pro',
                                            letterSpacing: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 8),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Service fee',
                                          style: TextStyle(
                                            fontFamily: 'Outfit',
                                            color: Colors.grey,
                                            fontSize: 14,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Text(
                                          '${tax.toString()} €',
                                          textAlign: TextAlign.end,
                                          style: const TextStyle(
                                            fontFamily: 'Readex Pro',
                                            letterSpacing: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 8, 0, 8),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            const Text(
                                              'Total',
                                              style: TextStyle(
                                                fontFamily: 'Outfit',
                                                color: Colors.grey,
                                                fontSize: 20,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            IconButton(
                                              // borderColor: Colors.transparent,
                                              // borderRadius: 30,
                                              // borderWidth: 1,
                                              // buttonSize: 36,
                                              icon: const Icon(
                                                Icons.info_outlined,
                                                color: Colors.grey,
                                                size: 18,
                                              ),
                                              onPressed: () {
                                                print('IconButton pressed ...');
                                              },
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '${total + tax} €',
                                          style: const TextStyle(
                                            fontFamily: 'Outfit',
                                            letterSpacing: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HabitationDevisForm(
                                            tarif: total.toInt(),
                                          )),
                                );
                              },
                              child: Text('Continue to Checkout'),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(double.infinity, 50),
                                padding: EdgeInsets.all(0),
                                // primary: Theme.of(context).primaryColor, // Set the primary color
                                //onPrimary: Theme.of(context).colorScheme.onPrimary, // Set the text color when pressed
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      fontFamily: 'Readex Pro',
                                      letterSpacing: 0,
                                    ),
                                elevation: 2,
                                side: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                // onSurface: Theme.of(context).colorScheme.onPrimary, // Set the text color when the button is disabled
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
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

class PurchaseList extends StatelessWidget {
  final String name;
  final String price;
  final String desc;
  final VoidCallback onclick;
  final bool showRemove;
  const PurchaseList(
      {super.key,
      required this.name,
      required this.price,
      required this.desc,
      required this.onclick,
      required this.showRemove});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 0,
              color: Color(0xFFF1F4F8),
              offset: Offset(
                0,
                1,
              ),
            )
          ],
          borderRadius: BorderRadius.circular(0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 12),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 1, 1, 1),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/icons/insurance.png',
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(8, 0, 4, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              fontFamily: 'Outfit',
                              letterSpacing: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                    child: Text(
                      '$price USD',
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        fontFamily: 'Outfit',
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 8, 12),
              child: AutoSizeText(
                desc,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontFamily: 'Readex Pro',
                  letterSpacing: 0,
                ),
              ),
            ),
            if (showRemove)
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                child: GestureDetector(
                  onTap: onclick,
                  child: const Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                        size: 24,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                        child: Text(
                          'Remove',
                          style: TextStyle(
                            fontFamily: 'Readex Pro',
                            color: Colors.red,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
