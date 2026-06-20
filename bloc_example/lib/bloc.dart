import 'package:flutter_bloc/flutter_bloc.dart';
import 'calculateevent.dart';
import 'calculatestate.dart';
class ClaculatorBLoc extends Bloc<CalculatorEvent,CalculatorState>{
  on<AddEvent>((event,emit){
    emit(ClaculatorState(result:add(event,num1,event,num2)))//result.event.num1+event.num2;
  });
}