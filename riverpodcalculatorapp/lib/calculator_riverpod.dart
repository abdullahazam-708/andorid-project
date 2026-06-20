import 'package:flutter_riverpod/flutter_riverpod.dart';
final calculatorProvider = StateNotifierProvider<CalculatorProvider, double>(
    (_)=>CalculatorProvider(),
);
//calculatorProvider user define

//jo double ha wo return ho ga  iss example ma calulator sy
// koi vale retun ho gi too iss leya double use ho ga
class CalculatorProvider extends StateNotifier<double>{
  CalculatorProvider(): super(0);
  // ager koi result koi na ya to by default Super0 ko use keya ha
 void addition(String num1, String num2){
   state= (double.tryParse(num1)??0) + (double.tryParse(num2)??0);
 }
 void subtract(String num1, String num2){
   state= (double.tryParse(num1)??0) - (double.tryParse(num2)??0);
 }
  void multiplication(String num1, String num2){
    state= (double.tryParse(num1)??0) * (double.tryParse(num2)??0);
  }
  void division(String num1,String num2){
   double n2= double.tryParse(num2)??0;
   double n1= double.tryParse(num1)??0;
   if(n2==0){
     state=0;
   }else
    state= n1/n2;
  }
  void modolus (String num1,String num2){
    double n2= double.tryParse(num2)??0;
    double n1= double.tryParse(num1)??0;
    if(n2==0){
      state=0;
    }else
      state= n1%n2;
  }
}