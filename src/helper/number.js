/**
 * Convert value into number.
 *
 * @param {String|Number} number
 * @returns {*}
 */
export function toNumber(number) {
  let result;

  if (typeof number === 'number') {
    result = number;

  } else if (typeof number === 'string') {
    if(number === '') {
      result = 0;
    } else {
      result = number.indexOf('.') > -1 ? parseFloat(number) : parseInt(number, 10);
    }
  }

  return result;
}

/**
 * Invert provided number.
 *
 * @param {Number} number
 * @returns {Number} Returns inverted number.
 */
export function invertNumber(number) {
  if (Array.isArray(number)) {
    return number.map((num) => {
      if (Array.isArray(num)) {
        return num.map((numOfnum) => { return -1 * toNumber(numOfnum); });
      }
      return -1 * toNumber(num);
    });
  }
  return -1 * toNumber(number);
}
