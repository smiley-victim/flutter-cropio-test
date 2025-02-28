import "package:flutter/material.dart";

class EventCard extends StatelessWidget {
  final Map event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.grey.shade400)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: Image.asset(
                        event["image"],
                        fit: BoxFit.contain,
                      ),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event["plantName"],
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                     Row(
                       children: [
                        Text(
                              'Condition: ',
                              style: TextStyle(fontWeight: FontWeight.w500,
                                  color:Colors.grey.shade500),
                            ),
                         Text(
                             ' ${event["condition"]}',
                              style: TextStyle(fontWeight: FontWeight.bold,
                                  color: _getConditionColor(event["condition"])),
                            ),
                       ],
                     ),
                  ],
                ),
              ),
            ],
          ),
         Row(
              children: List.generate(
                42,
                (index) => 
                     Container(
                        width: 6,
                        height: 1,
                        color: Colors.grey.shade400,
                      )
              ),
            ),
           Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('${event["careType"]}: ',style: TextStyle(color: Colors.grey.shade500,fontWeight: FontWeight.w500),),
              Text('${event["careDetails"]}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            ],
          ),            
          Row(
            children: [
              Text('Duration: ',style: TextStyle(fontWeight: FontWeight.w500,color:Colors.grey.shade500),),
              Text('${event["duration"]}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
              Spacer(),
              Icon(Icons.alarm, size: 16.0, color: Colors.grey),
              SizedBox(width: 4.0),
              Text(event["time"], style: TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  Color _getConditionColor(String condition) {
    switch (condition.toUpperCase()) {
      case 'EXCELLENT':
        return Colors.green;
      case 'GOOD':
        return Colors.blue;
      case 'BAD':
        return Colors.orange;
      default:
        return Colors.black54;
    }
  }
}
