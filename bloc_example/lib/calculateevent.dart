abstract class CalculatorEvent{}
class AddEvent extends CalculatorEvent{
  final double num1;
  final double num2;

  AddEvent(this.num1,this.num2);
}
class SubtractEvent extends CalculatorEvent{
  final double num1;
  final double num2;

  SubtractEvent(this.num1,this.num2);
}
class MultiplicationEvent extends CalculatorEvent{
  final double num1;
  final double num2;

  MultiplicationEvent(this.num1,this.num2);
}
class DivisionEvent extends CalculatorEvent{
  final double num1;
  final double num2;

  DivisionEvent(this.num1,this.num2);
}
class ModolusEvent extends CalculatorEvent{
  final double num1;
  final double num2;
  ModolusEvent(this.num1,this.num2);

}
abstract class CalculatorResult {}
  class CalculatorState extends CalculatorResult{
    final double result;
    CalculatorState(this.result);`

}