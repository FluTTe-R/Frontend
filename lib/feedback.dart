import 'package:flutter/material.dart';
import 'package:first_app/profile.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
void main() => runApp(
  const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: feedback(),
  )
);
class feedback extends StatefulWidget {
  const feedback({super.key});

  @override
  State<feedback> createState() => _feedbackState();
}

class _feedbackState extends State<feedback> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          //  Navigator.pop(context, MaterialPageRoute(builder: (context)=>profile()));
        }, icon: Icon(Icons.arrow_back_ios,color: Colors.black,)),
        title:Center(child:Text('Feedback',
        style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black,),)),
        actions: [
          TextButton(onPressed: (){}, child: Text("Send",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20),))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
               children: [
                SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(child: Text("Do you find this app useful?",style: TextStyle(fontSize: 20))),
                    LiteRollingSwitch(
                      value: true,
                      textOn: "Yes",
                      textOff: "No",
                      
                      colorOn: Colors.green,
                      colorOff: Colors.red,
                      iconOn: Icons.done,
                      iconOff: Icons.alarm_off,
                      textSize: 15,
                      onChanged: (bool position){
                        print("The button is $position");
                      },
                      onTap: (){},
                      onDoubleTap: (){},
                      onSwipe: (){},
                    )
                  ],
                ),
                SizedBox(height: 40,),
               Text("How could we make this app more useful",style: TextStyle(fontSize: 20)),
                SizedBox(height: 20,),
                TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Suggestions',
            ),
          ),
                
               ],
        ),
      ),
      );
  }
}