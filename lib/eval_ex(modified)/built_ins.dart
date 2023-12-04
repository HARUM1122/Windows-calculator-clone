/*
 * Copyright 2012-2020 Udo Klimaschewski
 *
 * http://about.me/udo.klimaschewski
 * http://UdoJava.com/
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

import 'dart:math' as math;
import 'package:dart_numerics/dart_numerics.dart' as n;
import 'package:decimal/decimal.dart';
import 'abstract_lazy_function.dart';
import 'abstract_function.dart';
import 'abstract_operator.dart';
import 'abstract_unary_operator.dart';
import 'expression.dart';

double _convertAngle(double angle,String currentAngleUnit,{ bool inverse = false}) {
  switch(currentAngleUnit){
    case 'D':
      return inverse?n.radianToDegree(angle):n.degreeToRadian(angle);
    case 'G':
      return inverse?n.radianToGrad(angle):n.degreeToRadian(n.gradToDegree(angle));
    default:
      return angle;
  }
} // ADDED A FUNCTION FOR CONVERTING ANGLE

void addBuiltIns(Expression e) {
  e.addOperator(OperatorImpl("+", Expression.operatorPrecedenceAdditive, true, fEval: (v1, v2) {
    Decimal n = v1 + v2;
    if(n.toDouble().isInfinite){
      throw const ExpressionException('Overflow');
    }    
    return n;
  }));

  e.addOperator(OperatorImpl("-", Expression.operatorPrecedenceAdditive, true,
      fEval: (v1, v2) {
    return v1 - v2;
  }));

  e.addOperator(OperatorImpl("×", Expression.operatorPrecedenceMultiplicative, true, fEval: (v1, v2) {
    Decimal n = v1 * v2;
    if(n.toDouble().isInfinite){
      throw const ExpressionException('Overflow');
    }    
    return n;
  })); // changed * to ×

  e.addOperator(OperatorImpl(
      "÷", Expression.operatorPrecedenceMultiplicative, true, fEval: (v1, v2) {
    if (v2 == Decimal.zero) {
      throw const ExpressionException("Cannot divide by 0");
    } // changed / to ÷
    return (v1 / v2).toDecimal(scaleOnInfinitePrecision: 32);
  }));

  e.addOperator(OperatorImpl(
      "mod", Expression.operatorPrecedenceMultiplicative, true, fEval: (v1, v2) {
    return v1 % v2;
  })); // changed % to mod

  e.addOperator(OperatorImpl(
      "%", Expression.operatorPrecedenceMultiplicative, true, fEval: (v1, v2) {
    return Decimal.parse((v1.toDouble()/100*v2.toDouble()).toString());
  })); // changed % to mod

  e.addOperator(OperatorImpl("logbase", 50, true, fEval: (v1, v2) {
    if(v1==Decimal.zero||v2==Decimal.zero){
      throw const ExpressionException('Invalid input');
    }
    if(v2==Decimal.one){
      throw const ExpressionException('Cannot divide by 0');
    }
    return Decimal.parse((math.log(v1.toDouble())/math.log(v2.toDouble())).toString());
  })); 
  e.addOperator(OperatorImpl(
    "yroot", 35, true, fEval: (v1, v2) {
      return Decimal.parse((math.pow(v1.toDouble(),1/v2.toDouble())).toString());
  })); 
  e.addOperator(
    OperatorImpl("^", e.powerOperatorPrecedence, false, fEval: (v1, v2) {
      double val = math.pow(v1.toDouble(), v2.toDouble()).toDouble();
      if (val.isInfinite){
        throw const ExpressionException("Overflow");
      } 
      else if (val.isNaN){
        throw const ExpressionException('Invalid input');
      }
      return Decimal.parse(val.toString());
  }));
  
  e.addOperator(UnaryOperatorImpl(
      "-", Expression.operatorPrecedenceUnary, false, fEval: (v1) {
    return v1 * Decimal.fromInt(-1);
  }));

  /// MODIFIED
  final Map<String,Function(List<Decimal>)> trigonometry = {
    // DEG
    'cosD': (List<Decimal> args) {
      final double val = args.first.toDouble();
      if(val<-1e60||val>1e60){
        throw const ExpressionException("Invalid input");
      }
      final double ans = n.cos(_convertAngle(val,'D'));
      return Decimal.parse(ans.toString());
    },
    'sinD': (List<Decimal> args) {
      final double val = args.first.toDouble();
      if(val<-1e60||val>1e60){
        throw const ExpressionException("Invalid input");
      }
      final double ans = n.sin(_convertAngle(val,'D'));
      return Decimal.parse(ans.toString());
    },

    'tanD': (List<Decimal> args) {
      final double val = args.first.toDouble();
      if(val<-1e60||val>1e60){
        throw const ExpressionException("Invalid input");
      }
      final double ans = n.tan(_convertAngle(val,'D'));
      return Decimal.parse(ans.toString());
    },

    'secD': (List<Decimal> args) {
      final double val = args.first.toDouble();
      if(val<-1e60||val>1e60){
        throw const ExpressionException("Invalid input");
      }
      
      final double ans = 1 / n.cos(_convertAngle(val,'D'));
      return Decimal.parse(ans.toString());
    },




    'cscD': (List<Decimal> args) {
      final double val = args.first.toDouble();
      if(val==0){
        throw const ExpressionException("Cannot divide by zero");
      }
      if(val<-1e60||val>1e60){
        throw const ExpressionException("Invalid input");
      }
      final double ans = 1 / n.sin(_convertAngle(val,'D'));
      return Decimal.parse(ans.toString());
    },


    'cotD': (List<Decimal> args){
      final double val = args.first.toDouble();
      if(val==0){
        throw const ExpressionException("Cannot divide by zero");
      }
      if(val<-1e60||val>1e60){
        throw const ExpressionException("Invalid input");
      }
      final double ans = 1 / n.tan(_convertAngle(val,'D'));
      return Decimal.parse(ans.toString());
    },
    
    'cosD_': (List<Decimal> args){
      final double val = args.first.toDouble();
      if(val<-1||val>1){
        throw const ExpressionException("Invalid input");
      }
      return Decimal.parse(_convertAngle(n.acos(val),'D',inverse:true).toString());
    },

    'sinD_': (List<Decimal> args){ 
      final double val = args.first.toDouble();
      if(val<-1||val>1){
        throw const ExpressionException("Invalid input");
      }
      return Decimal.parse(_convertAngle(n.asin(val),'D',inverse:true).toString());
    },


    'tanD_': (List<Decimal> args){
      final double val = args.first.toDouble();
      if(val<-1||val>1){
        throw const ExpressionException("Invalid input");
      }
      return Decimal.parse(_convertAngle(n.atan(val),'D',inverse:true).toString());
    },


    'secD_': (List<Decimal> args){
      final double val = args.first.toDouble();
      if(val==0){
        throw const ExpressionException("Cannot divide by zero");
      }
      if(val<-1||val>1){
        throw const ExpressionException("Invalid input");
      }
      return Decimal.parse(_convertAngle(n.asec(val),'D',inverse:true).toString());
    },



    'cscD_': (List<Decimal> args){
      final double val = args.first.toDouble();
      if(val==0){
        throw const ExpressionException("Cannot divide by zero");
      }
      if(val<-1||val>1){
        throw const ExpressionException("Invalid input");
      }
      return Decimal.parse(_convertAngle(n.acsc(val),'D',inverse:true).toString());
    },


    'cotD_': (List<Decimal> args){
      final double val = args.first.toDouble();
      if(val==0){
        throw const ExpressionException("Cannot divide by zero");
      }
      if(val<-1||val>1){
        throw const ExpressionException("Invalid input");
      }
      return Decimal.parse(_convertAngle(n.acot(val),'D',inverse:true).toString());
    },

    // RAD
    'cosR': (List<Decimal> args) {
      final double val = args.first.toDouble();
      if(val<-1e60||val>1e60){
        throw const ExpressionException("Invalid input");
      }
      final double ans = n.cos(_convertAngle(val,'R'));
      return Decimal.parse(ans.toString());
    },
    'sinR': (List<Decimal> args) {
      final double val = args.first.toDouble();
      if(val<-1e60||val>1e60){
        throw const ExpressionException("Invalid input");
      }
      final double ans = n.sin(_convertAngle(val,'R'));
      return Decimal.parse(ans.toString());
    },

    'tanR': (List<Decimal> args) {
      final double val = args.first.toDouble();
      if(val<-1e60||val>1e60){
        throw const ExpressionException("Invalid input");
      }
      final double ans = n.tan(_convertAngle(val,'R'));
      return Decimal.parse(ans.toString());
    },

    'secR': (List<Decimal> args) {
      final double val = args.first.toDouble();
      if(val<-1e60||val>1e60){
        throw const ExpressionException("Invalid input");
      }
      
      final double ans = 1 / n.cos(_convertAngle(val,'R'));
      return Decimal.parse(ans.toString());
    },

    'cscR': (List<Decimal> args) {
      final double val = args.first.toDouble();
      if(val==0){
        throw const ExpressionException("Cannot divide by zero");
      }
      if(val<-1e60||val>1e60){
        throw const ExpressionException("Invalid input");
      }
      final double ans = 1 / n.sin(_convertAngle(val,'R'));
      return Decimal.parse(ans.toString());
    },


    'cotR': (List<Decimal> args){
      final double val = args.first.toDouble();
      if(val==0){
        throw const ExpressionException("Cannot divide by zero");
      }
      if(val<-1e60||val>1e60){
        throw const ExpressionException("Invalid input");
      }
      final double ans = 1 / n.tan(_convertAngle(val,'R'));
      return Decimal.parse(ans.toString());
    },
    



    'cosR_': (List<Decimal> args){
      final double val = args.first.toDouble();
      if(val<-1||val>1){
        throw const ExpressionException("Invalid input");
      }
      return Decimal.parse(_convertAngle(n.acos(val),'R',inverse:true).toString());
    },

    'sinR_': (List<Decimal> args){ 
      final double val = args.first.toDouble();
      if(val<-1||val>1){
        throw const ExpressionException("Invalid input");
      }
      return Decimal.parse(_convertAngle(n.asin(val),'R',inverse:true).toString());
    },


    'tanR_': (List<Decimal> args){
      final double val = args.first.toDouble();
      if(val<-1||val>1){
        throw const ExpressionException("Invalid input");
      }
      return Decimal.parse(_convertAngle(n.atan(val),'R',inverse:true).toString());
    },


    'secR_': (List<Decimal> args){
      final double val = args.first.toDouble();
      if(val==0){
        throw const ExpressionException("Cannot divide by zero");
      }
      if(val<-1||val>1){
        throw const ExpressionException("Invalid input");
      }
      return Decimal.parse(_convertAngle(n.asec(val),'R',inverse:true).toString());
    },



    'cscR_': (List<Decimal> args){
      final double val = args.first.toDouble();
      if(val==0){
        throw const ExpressionException("Cannot divide by zero");
      }
      if(val<-1||val>1){
        throw const ExpressionException("Invalid input");
      }
      return Decimal.parse(_convertAngle(n.acsc(val),'R',inverse:true).toString());
    },


    'cotR_': (List<Decimal> args){
      final double val = args.first.toDouble();
      if(val==0){
        throw const ExpressionException("Cannot divide by zero");
      }
      if(val<-1||val>1){
        throw const ExpressionException("Invalid input");
      }
      return Decimal.parse(_convertAngle(n.acot(val),'R',inverse:true).toString());
    },

    // GRAD
    'cosG': (List<Decimal> args) {
      final double val = args.first.toDouble();
      if(val<-1e60||val>1e60){
        throw const ExpressionException("Invalid input");
      }
      final double ans = n.cos(_convertAngle(val,'G'));
      return Decimal.parse(ans.toString());
    },
    'sinG': (List<Decimal> args) {
      final double val = args.first.toDouble();
      if(val<-1e60||val>1e60){
        throw const ExpressionException("Invalid input");
      }
      final double ans = n.sin(_convertAngle(val,'G'));
      return Decimal.parse(ans.toString());
    },

    'tanG': (List<Decimal> args) {
      final double val = args.first.toDouble();
      if(val<-1e60||val>1e60){
        throw const ExpressionException("Invalid input");
      }
      final double ans = n.tan(_convertAngle(val,'G'));
      return Decimal.parse(ans.toString());
    },

    'secG': (List<Decimal> args) {
      final double val = args.first.toDouble();
      if(val<-1e60||val>1e60){
        throw const ExpressionException("Invalid input");
      }
      
      final double ans = 1 / n.cos(_convertAngle(val,'G'));
      return Decimal.parse(ans.toString());
    },




    'cscG': (List<Decimal> args) {
      final double val = args.first.toDouble();
      if(val==0){
        throw const ExpressionException("Cannot divide by zero");
      }
      if(val<-1e60||val>1e60){
        throw const ExpressionException("Invalid input");
      }
      final double ans = 1 / n.sin(_convertAngle(val,'G'));
      return Decimal.parse(ans.toString());
    },


    'cotG': (List<Decimal> args){
      final double val = args.first.toDouble();
      if(val==0){
        throw const ExpressionException("Cannot divide by zero");
      }
      if(val<-1e60||val>1e60){
        throw const ExpressionException("Invalid input");
      }
      final double ans = 1 / n.tan(_convertAngle(val,'G'));
      return Decimal.parse(ans.toString());
    },
    



    'cosG_': (List<Decimal> args){
      final double val = args.first.toDouble();
      if(val<-1||val>1){
        throw const ExpressionException("Invalid input");
      }
      return Decimal.parse(_convertAngle(n.acos(val),'G',inverse:true).toString());
    },

    'sinG_': (List<Decimal> args){ 
      final double val = args.first.toDouble();
      if(val<-1||val>1){
        throw const ExpressionException("Invalid input");
      }
      return Decimal.parse(_convertAngle(n.asin(val),'G',inverse:true).toString());
    },


    'tanG_': (List<Decimal> args){
      final double val = args.first.toDouble();
      if(val<-1||val>1){
        throw const ExpressionException("Invalid input");
      }
      return Decimal.parse(_convertAngle(n.atan(val),'G',inverse:true).toString());
    },


    'secG_': (List<Decimal> args){
      final double val = args.first.toDouble();
      if(val==0){
        throw const ExpressionException("Cannot divide by zero");
      }
      if(val<-1||val>1){
        throw const ExpressionException("Invalid input");
      }
      return Decimal.parse(_convertAngle(n.asec(val),'G',inverse:true).toString());
    },



    'cscG_': (List<Decimal> args){
      final double val = args.first.toDouble();
      if(val==0){
        throw const ExpressionException("Cannot divide by zero");
      }
      if(val<-1||val>1){
        throw const ExpressionException("Invalid input");
      }
      return Decimal.parse(_convertAngle(n.acsc(val),'G',inverse:true).toString());
    },


    'cotG_': (List<Decimal> args){
      final double val = args.first.toDouble();
      if(val==0){
        throw const ExpressionException("Cannot divide by zero");
      }
      if(val<-1||val>1){
        throw const ExpressionException("Invalid input");
      }
      return Decimal.parse(_convertAngle(n.acot(val),'G',inverse:true).toString());
    },

    // HYPERBOLIC
    'sinh': (List<Decimal> args){
      final double val = args.first.toDouble();
      if(val<-1e60||val>1e60){
        throw const ExpressionException("Invalid input");
      }
      return Decimal.parse(n.sinh(val).toString());
    },

    'cosh': (List<Decimal> args){
      final double val = args.first.toDouble();
      if(val<-1e60||val>1e60){
        throw const ExpressionException("Invalid input");
      }
      return Decimal.parse(n.cosh(val).toString());
    },


    'tanh': (List<Decimal> args){
      final double val = args.first.toDouble();
      if(val<-1e60||val>1e60){
        throw const ExpressionException("Invalid input");
      }
      return Decimal.parse(n.tanh(val).toString());
    },


    'sech': (List<Decimal> args) {
      final double val = args.first.toDouble();
      if(val<-1e60||val>1e60){
        throw const ExpressionException("Invalid input");
      }
      return Decimal.parse(n.sech(val).toString());
    },


    'csch': (List<Decimal> args){
      final double val = args.first.toDouble();
      if(val==0){
        throw const ExpressionException("Cannot divide by zero");
      }
      if(val<-1e60||val>1e60){
        throw const ExpressionException("Invalid input");
      }
      return Decimal.parse(n.csch(val).toString());
    },


    'coth': (List<Decimal> args){
      final double val = args.first.toDouble();
      if(val==0){
        throw const ExpressionException("Cannot divide by zero");
      }
      if(val<-1e60||val>1e60){
        throw const ExpressionException("Invalid input");
      }
      return Decimal.parse(n.coth(val).toString());
    },

    'sinh_': (List<Decimal> args){
      final double val = args.first.toDouble();
      if(val<-1e60||val>1e60){
        throw const ExpressionException("Invalid input");
      }
      return Decimal.parse(n.asinh(val).toString());
    },

    'cosh_': (List<Decimal> args){
      final double val = args.first.toDouble();
      if(val<1||val>1e60){
        throw const ExpressionException("Invalid input");
      }
      return Decimal.parse(n.acosh(val).toString());
    },

    'tanh_': (List<Decimal> args){
      final double val = args.first.toDouble();
      if(val==1){
        throw const ExpressionException("Cannot divide by zero");
      }
      if(val<0||val>1){
        throw const ExpressionException("Invalid input");
      }
      return Decimal.parse(n.atanh(val).toString());
    },

    'sech_': (List<Decimal> args){
      final double val = args.first.toDouble();
      if(val==0){
        throw const ExpressionException("Cannot divide by zero");
      }
      if(val>1||val<0){
        throw const ExpressionException("Invalid input");
      }
      return Decimal.parse(n.asech(val).toString());
    },

    'csch_': (List<Decimal> args){
      final double val = args.first.toDouble();
      if(val==0){
        throw const ExpressionException("Cannot divide by zero");
      }
      if(val<-1e60||val>1e60){
        throw const ExpressionException("Invalid input");
      }
      return Decimal.parse(n.acsch(val).toString());
    },

    'coth_': (List<Decimal> args){
      final double val = args.first.toDouble();
      if(val==0 || val==1){
        throw const ExpressionException("Cannot divide by zero");
      }
      if(val<1){
        throw const ExpressionException("Invalid input");
      }
      return Decimal.parse(n.acoth(val).toString());
    },
  };

  for(String funcName in trigonometry.keys){
    e.addFunc(
      FunctionImpl(
        funcName, 1, 
        booleanFunction: false, 
        fEval: trigonometry[funcName]!
      )
    );
  }
  e.addFunc(FunctionImpl("dms", 1, booleanFunction: false, fEval: (params) {
    num n = num.parse(params.first.toString());
    if(n.toInt()==n) return Decimal.parse(n.toString());
    int degrees = n.floor();
    double remainingMinutes = (n - degrees) * 60;
    int minutes = remainingMinutes.floor();
    double seconds = (remainingMinutes - minutes) * 60;
    return Decimal.parse((degrees + (minutes / 100) + (seconds / 10000)).toString());
  }));

  e.addFunc(FunctionImpl('fact', 1, booleanFunction: false, fEval: (params) {
    if (params.first.toDouble() > 170) {
      throw const ExpressionException('Overflow');
    }
    if(params.first.toDouble()<0){
      throw const ExpressionException('Invalid input');
    }
    int number = params.first.toBigInt().toInt();
    Decimal factorial = Decimal.one;
    for (int i = 1; i <= number; i++) {
      factorial = factorial * Decimal.fromInt(i);
    }
    return factorial;
  }));

  e.addFunc(FunctionImpl("sqrt", 1, fEval: (params) {
    if(params.first.toDouble()<0) {
      throw const ExpressionException('Invalid input');
    }
      return Decimal.parse(math.sqrt(params.first.toDouble()).toString());
    }
  ));
  
  e.addFunc(FunctionImpl("sqr", 1, fEval: (params){
    final Decimal n = params.first * params.first;
    if(n.toDouble().isInfinite){
      throw const ExpressionException('Overflow');
    }
    return n;
  }));

  e.addFunc(FunctionImpl("cube", 1, fEval: (params){
    final Decimal n = params.first * params.first * params.first;
    if(n.toDouble().isInfinite){
      throw const ExpressionException('Overflow');
    }
    return n;
  }));
  e.addFunc(FunctionImpl("cuberoot", 1, fEval: (params) {
    final double n = params.first.toDouble();
    if(n<0) {
      throw const ExpressionException('Invalid input');
    }
    return Decimal.parse((math.pow(n,1/3)).toString());
    }
  ));
  e.addFunc(FunctionImpl("abs", 1, fEval: (params)=> params.first.abs()));

  e.addFunc(FunctionImpl("floor", 1, fEval: (params)=> params.first.floor()));

  e.addFunc(FunctionImpl("ceil", 1, fEval: (params)=> params.first.ceil()));

  e.addFunc(FunctionImpl("log", 1, fEval: (params) {
    if(params.first.toDouble()<=0){
      throw const ExpressionException(".");
    }
    double d = n.log10(params.first.toDouble());
    return Decimal.parse(d.toString());
  }));

  e.addFunc(FunctionImpl("ln", 1, fEval: (params) {
    if(params.first.toDouble()<=0) {
      throw const ExpressionException('Invalid input');
    }
      return Decimal.parse(math.log(params.first.toDouble()).toString());
    }
  ));

  e.variables["theAnswerToLifeTheUniverseAndEverything"] =
      e.createLazyNumber(Decimal.fromInt(42));

  e.variables["e"] = e.createLazyNumber(Expression.e);
  e.variables["PI"] = e.createLazyNumber(Expression.pi);
  e.variables["NULL"] = null;
  e.variables["null"] = null;
  e.variables["Null"] = null;
  e.variables["TRUE"] = e.createLazyNumber(Decimal.one);
  e.variables["true"] = e.createLazyNumber(Decimal.one);
  e.variables["True"] = e.createLazyNumber(Decimal.one);
  e.variables["FALSE"] = e.createLazyNumber(Decimal.zero);
  e.variables["false"] = e.createLazyNumber(Decimal.zero);
  e.variables["False"] = e.createLazyNumber(Decimal.zero);
}

// Expects two, non null arguments
class OperatorImpl extends AbstractOperator {
  Function(Decimal v1, Decimal v2) fEval;

  OperatorImpl(String oper, int precedence, bool leftAssoc,
      {bool booleanOperator = false,
      bool unaryOperator = false,
      required this.fEval})
      : super(oper, precedence, leftAssoc,
            booleanOperator: booleanOperator, unaryOperator: unaryOperator);

  @override
  Decimal eval(Decimal? v1, Decimal? v2) {
    if (v1 == null) {
      throw AssertionError("First operand may not be null.");
    }
    if (v2 == null) {
      throw AssertionError("Second operand may not be null.");
    }

    return fEval(v1, v2);
  }
}

class OperatorSuffixImpl extends AbstractOperator {
  Function(Decimal v1) fEval;

  OperatorSuffixImpl(String oper, int precedence, bool leftAssoc,
      {bool booleanOperator = false, required this.fEval})
      : super(oper, precedence, leftAssoc,
            booleanOperator: booleanOperator, unaryOperator: true);

  @override
  Decimal eval(Decimal? v1, Decimal? v2) {
    if (v1 == null) {
      throw AssertionError("First operand may not be null.");
    }
    if (v2 != null) {
      throw AssertionError("Did not expect second operand.");
    }

    return fEval(v1);
  }
}

class OperatorNullArgsImpl extends AbstractOperator {
  Function(Decimal? v1, Decimal? v2) fEval;

  OperatorNullArgsImpl(String oper, int precedence, bool leftAssoc,
      {bool booleanOperator = false,
      bool unaryOperator = false,
      required this.fEval})
      : super(oper, precedence, leftAssoc,
            booleanOperator: booleanOperator, unaryOperator: unaryOperator);

  @override
  Decimal eval(Decimal? v1, Decimal? v2) {
    return fEval(v1, v2);
  }
}

class UnaryOperatorImpl extends AbstractUnaryOperator {
  // Type defs?
  Function(Decimal v1) fEval;

  UnaryOperatorImpl(String oper, int precedence, bool leftAssoc,
      {required this.fEval})
      : super(oper, precedence, leftAssoc);

  @override
  Decimal evalUnary(Decimal? v1) {
    if (v1 == null) {
      throw AssertionError("Operand may not be null.");
    }

    return fEval(v1);
  }
}

class FunctionImpl extends AbstractFunction {
  Function(List<Decimal>) fEval;

  FunctionImpl(String name, int numParams,
      {bool booleanFunction = false, required this.fEval})
      : super(name, numParams, booleanFunction: booleanFunction);

  @override
  Decimal eval(List<Decimal?> parameters) {
    List<Decimal> params = [];

    for (int i = 0; i < parameters.length; i++) {
      if (parameters[i] == null) {
        throw AssertionError("Operand #${i + 1} may not be null.");
      }

      params.add(parameters[i]!);
    }

    return fEval(params);
  }
}

class LazyFunctionImpl extends AbstractLazyFunction {
  Function(List<LazyNumber>) fEval;

  LazyFunctionImpl(String name, int numParams,
      {bool booleanFunction = false, required this.fEval})
      : super(name, numParams, booleanFunction: booleanFunction);

  @override
  LazyNumber lazyEval(List<LazyNumber?> lazyParams) {
    List<LazyNumber> params = [];

    for (int i = 0; i < lazyParams.length; i++) {
      if (lazyParams[i] == null) {
        throw AssertionError("Operand #${i + 1} may not be null.");
      }

      params.add(lazyParams[i]!);
    }

    return fEval(params);
  }
}