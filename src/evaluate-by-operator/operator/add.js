import {toNumber} from './../../helper/number';
import {ERROR_VALUE} from './../../error';
import { handleArrays } from './handle-array';

export const SYMBOL = '+';

let checkForA = false;

export default function func(op1=0, op2=0) {
  let result;
  checkForA = this.checkForA;
  if(Array.isArray(op1) || Array.isArray(op2)) {
    return handleArrays(op1, op2, operatorHandler);
  }

  result = operatorHandler(op1, op2);

  if (isNaN(result)) {
    throw Error(ERROR_VALUE);
  }

  return result;
}

function operatorHandler(exp1, exp2) {
  if (checkForA) {
    exp1 = exp1 === "A" ? 0 : exp1;
    exp2 = exp2 === "A" ? 0 : exp2;
  }
  exp1 = exp1 === "" ? 0 : exp1 === true ? 1 : exp1 === false ? 0 : exp1;
  exp2 = exp2 === "" ? 0 : exp2 === true ? 1 : exp2 === false ? 0 : exp2;

  if (exp1 === undefined || exp2 === undefined) {
    return '#N/A';
  } else if(typeof exp1 === 'string' || typeof exp2 === 'string') {
    return '#VALUE!';
  } else {
    return exp1 + exp2;
  }
}

func.SYMBOL = SYMBOL;
