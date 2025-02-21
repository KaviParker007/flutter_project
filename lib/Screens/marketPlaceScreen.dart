import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:task_application/Screens/singlePostScreen.dart';


class MarketplaceScreen extends StatefulWidget {
  const MarketplaceScreen({super.key});

  @override
  State<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  List<dynamic> marketplaceRequests = [];
  bool isLoading = true;
  String errorMessage = '';


  @override
  void initState() {
    super.initState();
    fetchMarketplaceRequests();
  }

  Future<void> fetchMarketplaceRequests() async {
    final url = Uri.parse(
        'https://staging3.hashfame.com/api/v1/interview.mplist?page=1');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          snackMsg("Success!");
          marketplaceRequests = data['marketplace_requests'];
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

  snackMsg(String Msg) {
    var snackBar = SnackBar(content: Text('Info: $Msg'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: HexColor("#FFFFFF"),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : errorMessage.isNotEmpty
            ? Center(child: Text(errorMessage))
            : Column(
          children: [
            Container(
              height: 75,
              padding: const EdgeInsets.all(14),
              child: TextField(
                // enabled: false,
                //  onChanged: '',
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(width: 1, color: HexColor("#CACACA")),
                  ),
                  labelText: ' Type your requirement here . . .',
                  labelStyle: TextStyle(
                    color: HexColor("#7E7E7E"),
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                  prefixIcon: CircleAvatar(
                      radius: (20),
                      backgroundColor: Colors.transparent,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.asset("assets/images/men.png",
                          width: 35,
                          height: 35,
                          fit: BoxFit.cover,
                        ),
                      )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 0, 0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        snackMsg("No DATA");
                        // Your onPressed logic here
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.red,
                        backgroundColor: HexColor("#FFFFFF"), // Text color
                        side: BorderSide(
                          color: HexColor("#E8E7EA"), // Border color
                          width: 1.0, // Border width
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35), // Border radius
                        ),
                      ),
                      child: Text('For You',
                          style: TextStyle(
                            color: HexColor("#1F1F1F"),
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          )),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        snackMsg("No DATA");
                        // Your onPressed logic here
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.red,
                        backgroundColor: HexColor("#FFEFEF"), // Text color
                        side: BorderSide(
                          color: HexColor("#FE4545"), // Border color
                          width: 1.0, // Border width
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35), // Border radius
                        ),
                      ),
                      child: Text('Recent',
                          style: TextStyle(
                            color: HexColor("#1F1F1F"),
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          )),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        snackMsg("No DATA");
                        // Your onPressed logic here
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.red,
                        backgroundColor: HexColor("#FFFFFF"), // Text color
                        side: BorderSide(
                          color: HexColor("#E8E7EA"), // Border color
                          width: 1.0, // Border width
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35), // Border radius
                        ),
                      ),
                      child: Text('My Requests',
                          style: TextStyle(
                            color: HexColor("#1F1F1F"),
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          )),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        snackMsg("No DATA");
                        // Your onPressed logic here
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.red,
                        backgroundColor: HexColor("#FFFFFF"), // Text color
                        side: BorderSide(
                          color: HexColor("#E8E7EA"), // Border color
                          width: 1.0, // Border width
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35), // Border radius
                        ),
                      ),
                      child: Row(
                        children: [
                          Image.asset("assets/images/Vector1.png",
                            width: 12,
                            height: 12,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text('Top Deals',
                              style: TextStyle(
                                color: HexColor("#1F1F1F"),
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: marketplaceRequests.length,
                itemBuilder: (context, index) {
                  final request = marketplaceRequests[index];
                  return MarketplaceRequestCard(request: request);
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(

        onPressed: () {
          // Add your onPressed logic here
          snackMsg("Floating Action Button Pressed");
        },
        label:  Text('Post Request',style: TextStyle(
          color: HexColor("#FFFFFF"),
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ) ),
        icon:  Icon(Icons.add,size: 20,color: HexColor("#FFFFFF"),),
        backgroundColor: HexColor("#FE4545"), // Customize the color
      ),
    );
  }
}

class MarketplaceRequestCard extends StatelessWidget {
  final dynamic request;

  const MarketplaceRequestCard({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Singlepostscreen(request['id_hash'])),
        );

      },
      child: Card(
        color: HexColor("#FFFFFF"),
        margin: const EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: HexColor("#E9E9E9"), // Border color
            width: 1.0, // Border width
          ),
          borderRadius: BorderRadius.circular(16.0), // Optional: if you want rounded corners
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                      radius: (30),
                      backgroundColor: Colors.transparent,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: request['user_details']['profile_image'] == null
                              ? Image.asset("assets/images/noimage.png",
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                              : Image.network('${request['user_details']['profile_image']}',
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ))),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          request['user_details']['name'] ?? 'No Name',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: HexColor("#1F1F1F")),
                        ),
                        Row(
                          children: [
                            Text(
                              '${request['service_type']}',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: HexColor("#7E7E7E")),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            Icon(Icons.arrow_forward_ios,
                              size: 12,
                              color: HexColor("#7E7E7E"),)
                          ],
                        ),
                        Row(
                          children: [
                            Icon(TablerIcons.clock,
                              color: HexColor("#7E7E7E"),
                              size: 12,
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              '${request['created_at']}',
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
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
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
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: HexColor("#1F1F1F")),
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
              Text(
                request['description'] ?? 'No Description',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: HexColor("#1F1F1F")),
              ),
              const SizedBox(height: 8),
              Container(
                width: 100,
                height: 30,
                decoration: BoxDecoration(
                  color: HexColor("#F5F6FB"),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    Icon(Icons.location_pin, color: HexColor("#1C1B1F"), size: 12),
                    const SizedBox(width: 10),
                    Expanded( // Add Expanded here
                      child: Text(
                        request['request_details'] != null && request['request_details']['cities'] != null
                            ? request['request_details']['cities'].join(', ')
                            : "No Data",
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: HexColor("#1F1F1F")),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Row(
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
                        Icon(TablerIcons.brand_instagram, color: HexColor("#1C1B1F"), size: 14),
                        const SizedBox(width: 10),
                        Expanded( // Add Expanded here
                          child: Text(
                            request['request_details'] != null && request['request_details']['platform'] != null
                                ? request['request_details']['platform'].join(', ')
                                : "No Data",
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: HexColor("#1F1F1F")),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 100,
                    height: 30,
                    decoration: BoxDecoration(
                      color: HexColor("#F5F6FB"),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        Icon(Icons.style_outlined, color: HexColor("#1C1B1F"), size: 14),
                        const SizedBox(width: 10),
                        Expanded( // Add Expanded here
                          child: Text(
                            request['request_details'] != null && request['request_details']['categories'] != null
                                ? request['request_details']['categories'].join(', ')
                                : "No Data",
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: HexColor("#1F1F1F")),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}