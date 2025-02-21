import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;




class Singlepostscreen extends StatefulWidget {
  String Id;

   Singlepostscreen(this.Id);

  @override
  State<Singlepostscreen> createState() => _SinglepostscreenState();
}



class _SinglepostscreenState extends State<Singlepostscreen> {
  Map<String, dynamic> singleRequest = {};
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchsingleRequest();
  }



  Future<void> fetchsingleRequest() async {
    final url = Uri.parse(
        'https://staging3.hashfame.com/api/v1/interview.mplist?id_hash=${widget.Id}');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          snackMsg("Success!");
          singleRequest = data['web_marketplace_requests']; // Update this line
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load data';
          snackMsg(errorMessage);
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'An error occurred: $e';
        snackMsg(errorMessage);
        isLoading = false;
      });
    }
  }


  snackMsg(String Msg){
    var snackBar =   SnackBar(content: Text('Info: $Msg'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        leading: IconButton(
          icon: const Icon(TablerIcons.arrow_left, size: 24),
          color: HexColor("#1F1F1F"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(TablerIcons.trash,
              color: HexColor("#FE4545"),
              size: 20,
            ),
            const SizedBox(width: 10),
            Container(
              height: 30,
              width: 35,
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [HexColor("#FF7304"), HexColor("#FB2A77")],
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(TablerIcons.share,
                color: HexColor("#FFFFFF"),
                size: 16,
              ),
            ),
          ],
        ),
        gradient: LinearGradient(
          colors: [HexColor("#FFFFFF"), HexColor("#FFFFFF")],
        ),
      ),
      body: Container(
        color: HexColor("#F5F6FB"),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : errorMessage.isNotEmpty
            ? Center(child: Text(errorMessage))
            : SingleChildScrollView(
              child: Column(
              
                        children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
              
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.transparent,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: singleRequest['user_details']['profile_image'] == null
                                ? Image.asset("assets/images/noimage.png",
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            )
                                : Image.network(singleRequest['user_details']['profile_image'],
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    singleRequest['user_details']['name'] ?? 'No Name',
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: HexColor("#1F1F1F")),
                                  ),
                                  const SizedBox(width: 120),
                                  Text(
                                    singleRequest['created_at'] ?? 'No Date',
                                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: HexColor("#7E7E7E")),
                                  ),
                                ],
                              ),
                              Text(
                                singleRequest['service_type'] ?? 'No Data',
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: HexColor("#7E7E7E")),
                              ),
                              Row(
                                children: [
                                  Icon(TablerIcons.building_skyscraper,
                                    color: HexColor("#7E7E7E"),
                                    size: 12,
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    singleRequest['target_audience'] ?? 'No Date',
                                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: HexColor("#7E7E7E")),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Card(
                      color: HexColor("#FFFFFF"),
                      margin: const EdgeInsets.all(0.0),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: HexColor("#E9E9E9"), // Border color
                          width: 1.0, // Border width
                        ),
                        borderRadius: BorderRadius.circular(1.0), // Optional: if you want rounded corners
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8,0,0,0),
                              child: Text(
                                "Looking for",
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400,color: HexColor("#7E7E7E")),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(8,0,0,0),
                                  child: Image.asset("assets/images/Vector3.png",
                                    width: 14,
                                    height: 14,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
              
                                Expanded(
                                  child: Text(
                                    "Looking for Influencer marketing agency",
                                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600,color: HexColor("#1F1F1F")),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Divider(
                              thickness: 1,
                              color: HexColor("#E9E9E9"),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8,0,0,0),
                              child: Text(
                                "Highlights",
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600,color: HexColor("#7E7E7E")),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8,0,0,0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 160,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: HexColor("#F5F6FB"),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 10),
                                        Text("₹",
                                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: HexColor("#1F1F1F")),
              
                                        ),
                                        const SizedBox(width: 5),
                                        Expanded( // Add Expanded here
                                          child: Text(
                                            "Budget: 1,45,000",
                                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: HexColor("#7E7E7E")),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: 160,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: HexColor("#F5F6FB"),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 10),
                                        Icon(Icons.mic,
                                          color: HexColor("#1F1F1F"),
                                          size: 14,
                                        ),
                                        const SizedBox(width: 5),
                                        Expanded( // Add Expanded here
                                          child: Text(
                                            "Brand: Swiggy",
                                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: HexColor("#7E7E7E")),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8,0,0,0),
                              child: Text(
                                singleRequest['description'] ?? 'No Description',
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400,color: HexColor("#1F1F1F")),
                              ),
                            ),
              
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8,0,0,0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 160,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: HexColor("#0BDC4E").withOpacity(0.12),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 10),
                                        CircleAvatar(
                                          radius: 10,
                                          backgroundColor: Colors.transparent,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(5),
                                            child: Image.asset("assets/images/whatsapp.png",
                                              width: 25,
                                              height: 25,
                                              fit: BoxFit.cover,
                                            )
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Expanded( // Add Expanded here
                                          child: Text(
                                            "Share via WhatsApp",
                                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: HexColor("#1F1F1F")),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: 160,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: HexColor("#0066C8").withOpacity(0.12),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 10),
                                        CircleAvatar(
                                          radius: 10,
                                          backgroundColor: Colors.transparent,
                                          child: ClipRRect(
                                              borderRadius: BorderRadius.circular(5),
                                              child: Image.asset("assets/images/linkedin.png",
                                                width: 25,
                                                height: 25,
                                                fit: BoxFit.cover,
                                              )
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Expanded( // Add Expanded here
                                          child: Text(
                                            "Share on LinkedIn",
                                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: HexColor("#1F1F1F")),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 13),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8,0,0,0),
                              child: Text(
                                "Key Highlighted Details",
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600,color: HexColor("#7E7E7E")),
                              ),
                            ),
                            SizedBox(height: 15),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8,0,0,0),
                              child: Table(
                                columnWidths: const {
                                  0: FixedColumnWidth(160), // Width of the first column
                                  1: FixedColumnWidth(150), // Width of the second column
                                },// Optional: Add borders for better visualization
                                children: [
                                  TableRow(
                                    children: [
                                      Text(
                                        "Category",
                                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: HexColor("#1F1F1F")),
                                      ),
                                      Text(
                                        "Platform",
                                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: HexColor("#1F1F1F")),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Text(
                                        "Lifestyle, Fashion",
                                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: HexColor("#AAAAAA")),
                                      ),
                                      Text(
                                        "Instagram, Youtube",
                                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: HexColor("#AAAAAA")),
                                      ),
                                    ],
                                  ),
                                  // Add more TableRow widgets as needed
              
                                  // Repeat the above pattern for other rows
                                ],
                              ),
                            ),
              
              
                            SizedBox(height: 15),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8,0,0,0),
                              child: Table(
                                columnWidths: const {
                                  0: FixedColumnWidth(160), // Width of the first column
                                  1: FixedColumnWidth(150), // Width of the second column
                                },// Optional: Add borders for better visualization
                                children: [
                                  TableRow(
                                    children: [
                                      Text(
                                        "Language",
                                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: HexColor("#1F1F1F")),
                                      ),
                                      Text(
                                        "Location",
                                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: HexColor("#1F1F1F")),
                                      ),
                                    ],
                                  ),
              
                                  TableRow(
                                    children: [
                                      Text(
                                        "Hindi, Kannada, Malayalam, Tamil & Telugu",
                                      //  softWrap: true,
                                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: HexColor("#AAAAAA")),
                                      ),
                                      Text(
                                        "Bangalore, Tamilnadu, Kerala, GoaBangalore, Tamilnadu,",
                                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: HexColor("#AAAAAA")),
                                      ),
                                    ],
                                  ),
                                  // Add more TableRow widgets as needed
              
                                  // Repeat the above pattern for other rows
                                ],
                              ),
                            ),
              
                            SizedBox(height: 15),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8,0,0,0),
                              child: Table(
                                columnWidths: const {
                                  0: FixedColumnWidth(160), // Width of the first column
                                  1: FixedColumnWidth(150), // Width of the second column
                                },// Optional: Add borders for better visualization
                                children: [
                                  TableRow(
                                    children: [
                                      Text(
                                        "Required count",
                                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: HexColor("#1F1F1F")),
                                      ),
                                      Text(
                                        "Our Budget",
                                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: HexColor("#1F1F1F")),
                                      ),
                                    ],
                                  ),
              
                                  TableRow(
                                    children: [
                                      Text(
                                        "15 - 20",
                                        //  softWrap: true,
                                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: HexColor("#AAAAAA")),
                                      ),
                                      Text(
                                        "₹1,45,000",
                                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: HexColor("#AAAAAA")),
                                      ),
                                    ],
                                  ),
                                  // Add more TableRow widgets as needed
              
                                  // Repeat the above pattern for other rows
                                ],
                              ),
                            ),
              
                            SizedBox(height: 15),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8,0,0,0),
                              child: Table(
                                columnWidths: const {
                                  0: FixedColumnWidth(160), // Width of the first column
                                  1: FixedColumnWidth(150), // Width of the second column
                                },// Optional: Add borders for better visualization
                                children: [
                                  TableRow(
                                    children: [
                                      Text(
                                        "Brand collab with",
                                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: HexColor("#1F1F1F")),
                                      ),
                                      Text(
                                        "Required followers",
                                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: HexColor("#1F1F1F")),
                                      ),
                                    ],
                                  ),
              
                                  TableRow(
                                    children: [
                                      Text(
                                        "Swiggy",
                                        //  softWrap: true,
                                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: HexColor("#AAAAAA")),
                                      ),
              
                                      Row(
                                        children: [
                                          Icon(TablerIcons.brand_instagram,
                                            color: HexColor("#AAAAAA"),
                                            size: 12,
                                          ),
                                          Text(
                                            "500k - 1M+",
                                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: HexColor("#AAAAAA")),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Text(
                                        "",
                                        //  softWrap: true,
                                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: HexColor("#AAAAAA")),
                                      ),
              
                                      Row(
                                        children: [
                                          Icon(TablerIcons.brand_youtube,
                                            color: HexColor("#AAAAAA"),
                                            size: 12,
                                          ),
                                          Text(
                                            "500k - 1M+",
                                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: HexColor("#AAAAAA")),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  // Add more TableRow widgets as needed
              
                                  // Repeat the above pattern for other rows
                                ],
                              ),
                            ),
                            SizedBox(height: 70),

                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: HexColor("#FFFFFF"),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(4, 7), // changes position of shadow
                          ),
                        ],
                      ),
                      height: 108,
                      width: 380,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15,10,0,0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(TablerIcons.clock,
                                  color: HexColor("#3F51B5"),
                                  size: 15,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Your post has will be expired on 26 july",
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400,color: HexColor("#1F1F1F")),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      snackMsg("No DATA");
                                      // Your onPressed logic here
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.red,
                                      backgroundColor: HexColor("#FFFFFF"), // Text color
                                      side: BorderSide(
                                        color: HexColor("#FE4545"), // Border color
                                        width: 1.0, // Border width
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(35), // Border radius
                                      ),
                                    ),
                                    child: Text('Edit',
                                        style: TextStyle(
                                          color: HexColor("#FE4545"),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                        )
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                SizedBox(
                                  width: 150,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      snackMsg("No Data");
                                      // Your onPressed logic here
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.red,
                                      backgroundColor: HexColor("#FE4545"), // Text color
                                      side: BorderSide(
                                        color: HexColor("#FE4545"), // Border color
                                        width: 1.0, // Border width
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(35), // Border radius
                                      ),
                                    ),
                                    child: Text('Close',
                                        style: TextStyle(
                                          color: HexColor("#FFFFFF"),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                        )
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 6,
                                ),



                              ],
                            ),
                          ],
                        ),
                      ),
                    )
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
