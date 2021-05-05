export const SYMBOL = '>';

export default function func(exp1, exp2) {
  if(Array.isArray(exp1)) {
    var result =exp1.map(function (param1){
      return param1.map(function (innerParam){
      return innerParam > exp2;
      });
    });
    return result;
  }
  return exp1 > exp2;
}

func.SYMBOL = SYMBOL;
