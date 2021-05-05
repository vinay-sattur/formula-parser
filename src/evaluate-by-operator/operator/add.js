import {toNumber} from './../../helper/number';
import {ERROR_VALUE} from './../../error';

export const SYMBOL = '+';

export default function func(first=0, ...rest) {
  let result;
  if(Array.isArray(rest) && Array.isArray(first)) {
    result = [];
    for (var innerRestArray of rest){
      for(var index=0;index<innerRestArray.length;index++) {
        if(typeof innerRestArray[index][0] ==='boolean' && typeof first[index][0] === 'boolean' && (innerRestArray[index][0] || first[index][0])) {
          result.push([true]);
        } else {
          result.push([false]);
        }
      }
    }
    return result;
  }

  result = rest.reduce((acc, value=0) => acc + toNumber(value==="" || value==="A"?0:value), toNumber(first==="A"||first === "" ? 0 : first));

  if (isNaN(result)) {
    throw Error(ERROR_VALUE);
  }

  return result;
}

func.SYMBOL = SYMBOL;
