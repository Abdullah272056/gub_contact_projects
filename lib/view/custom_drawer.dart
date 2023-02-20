import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'developer_info_list.dart';



class CustomDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children:  [
              DrawerHeader(
                child: Center(
                  child: Image.asset(
                    "assets/images/gub_logo.png",
                    width: 150,
                    height: 46,
                    fit: BoxFit.fill,
                  ),
                ),
               // decoration: BoxDecoration(color: Colors.green),
              ),




              ListTile(
                leading: Icon(Icons.web_asset,
                  color: Colors.green,
                ),
                title: Text("Web Site",
                ),
                onTap: (){
                  _launchUrl("https://green.edu.bd/");
                },
              ),
              ListTile(
                leading: Icon(Icons.person_pin_outlined,
                  color: Colors.green,
                ),
                title: Text("Student Portal",
                ),
                onTap: (){
                  _launchUrl("https://studentportal.green.edu.bd/Account/login?ReturnUrl=%2F");
                },
              ),
              ListTile(
                leading: Icon(Icons.contact_support_rounded,
                  color: Colors.green,
                ),
                title: Text("Contact",
                ),
                onTap: (){
                  _launchUrl("https://green.edu.bd/contact/");
                },

              ),

              ListTile(
                leading: Icon(Icons.info_outline,
                  color: Colors.green,
                ),
                title: Text("Notice Board",
                ),
                onTap: (){
                  _launchUrl("https://green.edu.bd/notices/");
                },
              ),
              ListTile(
                leading: Icon(Icons.facebook,
                  color: Colors.green,
                ),
                title: Text("Facebook",
                ),
                onTap: (){
                  _launchUrl("https://web.facebook.com/greenuniversitybd/?_rdc=1&_rdr");
                },
              ),

              ListTile(
                leading: Icon(Icons.developer_board,
                  color: Colors.green,
                ),
                title: Text("Developer Info",
                ),
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>
                      DeveloperInfoListScreen()
                  ));
                },
              ),


            ],
          ),
        ),
      ),
    );
  }


  Future<void> _launchUrl(String urlString) async {
    Uri url=Uri.parse(urlString);
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

}
