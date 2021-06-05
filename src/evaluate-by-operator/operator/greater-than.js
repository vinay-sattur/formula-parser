import { handleArrays } from './handle-array';

export const SYMBOL = '>';

let checkForA = false;

export default function func(op1="", op2="") {
  let result;
  checkForA = this.checkForA;
  if(Array.isArray(op1) || Array.isArray(op2)) {
    return handleArrays(op1, op2, operatorHandler);
  }

  result = operatorHandler(op1, op2);
  return result;
}

function operatorHandler(exp1, exp2) {
  if (checkForA) {
    exp1 = exp1 === "A" ? "" : exp1;
    exp2 = exp2 === "A" ? "" : exp2;
  }

  if (exp1 === undefined || exp2 === undefined) {
    return '#N/A';
  } else {
    exp1 = typeof exp1 === 'boolean' ? exp1.toString() : exp1.toString().toUpperCase();
    exp2 = typeof exp2 === 'boolean' ? exp2.toString() : exp2.toString().toUpperCase();
    return exp1 > exp2;
  }
}

func.SYMBOL = SYMBOL;
