import {toNumber} from './../../helper/number';
import {ERROR_VALUE} from './../../error';

export const SYMBOL = '-';

export default function func(first=0, ...rest) {
  const result = rest.reduce((acc, value=0) => acc - toNumber(value==="" || value==="A"?0:value), toNumber(first==="A"||first==="" ? 0 : first));

  if (isNaN(result)) {
    throw Error(ERROR_VALUE);
  }

  return result;
}

func.SYMBOL = SYMBOL;
