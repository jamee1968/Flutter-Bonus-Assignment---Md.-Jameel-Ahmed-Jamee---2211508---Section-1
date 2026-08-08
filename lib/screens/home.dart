import 'package:flutter/material.dart';
import 'package:summer_iub_app/screens/coffe_records_screen.dart';
import 'package:summer_iub_app/screens/create_coffee_record_screen.dart';
import 'package:summer_iub_app/state_management/coffee_state_management.dart';
import 'package:summer_iub_app/widgets/app_backgroud_design_widget.dart';
import 'package:summer_iub_app/screens/coffee_records_firebase_screen.dart';

// ACM

class HomePage extends StatefulWidget {
  // Attribute
  final String pageTitle;

  // Constructor
  const HomePage({super.key, required this.pageTitle});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  int _coffeeCount = 0;

  void incrememntCoffeeCount() {
    _coffeeCount++;
    setState((){}); // For giving user some feedba
    print("Coffee Count: $_coffeeCount");
  }

  void navigateToCoffeeRecordsScreen() {
   Navigator.of(context)
   .push(MaterialPageRoute(builder: (context) =>  CoffeRecordsScreen()));
  }

   void navigateToCreateCoffeeRecordScreen() {
   Navigator.of(context)
   .push(MaterialPageRoute(builder: (context) =>  CreateCoffeeRecordScreen()));
  }

  void navigateToFirebaseRecordsScreen() {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => const CoffeeRecordsFirebaseScreen()),
  );
}



  // Methods
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.pageTitle,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.00,
          ),
        ),
        backgroundColor: Colors.brown,
      ),


      // * * * * -> Row

      // * 
      // * 
      // *
      // Column

      body: AppBackgroudDesignWidget(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.brown.shade600,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 10.00,
                  horizontal: 20.00,
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: 25.00,
                ),
                child: Column(
                  children: [
                    Text(
                      "Welcome To Coffe House",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.00,
                        fontWeight: FontWeight.bold,
                      )
                    ),
      
                    // ---------------------------------------------------------
                    SizedBox(height: 10.00),
                    // ---------------------------------------------------------
      
                    // Row for "Order Now" + Arrow button
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    ElevatedButton.icon(
      onPressed: () {
        navigateToCreateCoffeeRecordScreen();
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20.00),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      icon: const Icon(
        Icons.shopping_cart,
        color: Colors.brown,
      ),
      label: const Text(
        "Order Now",
        style: TextStyle(
          color: Colors.brown,
          fontSize: 16.00,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    const SizedBox(width: 10.00),
    IconButton.filled(
      onPressed: () {
        navigateToCoffeeRecordsScreen();
      },
      style: IconButton.styleFrom(
        backgroundColor: Colors.brown.shade800,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      icon: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.white,
        size: 20.00,
      ),
    ),
  ],
),

const SizedBox(height: 10.00),

// Full-width "Check Firebase" button matching your teacher's layout
SizedBox(
  width: double.infinity,
  child: ElevatedButton.icon(
    onPressed: () {
      navigateToFirebaseRecordsScreen();
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color.fromARGB(255, 242, 233, 231),
      padding: const EdgeInsets.symmetric(vertical: 12.00),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    icon: const Icon(
      Icons.filter_list,
      color: Colors.brown,
    ),
    label: const Text(
      "Check Firebase",
      style: TextStyle(
        color: Colors.brown,
        fontSize: 16.00,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
),
                  ],
                ),
              ),
      
              SizedBox(height: 30.00),
      
      
              // --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
              Text(
                  "How many coffee cups did you drink today?",
                  style: TextStyle(
                    color: Colors.brown,
                    fontSize: 18.00,
                  )
                ),
        
              // --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
              Text(
                _coffeeCount.toString(),
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 36.00,
                  fontWeight: FontWeight.bold,
                )
              ),
            
            ],
          )
        ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          incrememntCoffeeCount();
        },
        child: Icon(Icons.local_cafe),
      ),
    );
  }
}
