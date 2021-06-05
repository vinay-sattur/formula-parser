export function handleArrays(exp1, exp2, operatorFunc) {
    const exp1IsArray = Array.isArray(exp1);
    const exp2IsArray = Array.isArray(exp2);
    const result = [];
    if((exp1IsArray && !exp2IsArray) || (exp2IsArray && !exp1IsArray)) {
        let arrayExp, normalExp, swapped = false;
        if(exp1IsArray) {
            arrayExp = exp1;
            normalExp = exp2;
        } else {
            arrayExp = exp2;
            normalExp = exp1;
            swapped = true;
        }

        for(let i =0, length = arrayExp.length; i<length; i++) {
            const innerResult = [];
            const colLength = arrayExp[i].length;
            if (colLength) {
                for(let j =0;j<arrayExp[i].length;j++) {
                    const arrayExp_Value = arrayExp[i][j];
                    innerResult.push(swapped ? operatorFunc(normalExp, arrayExp_Value) : operatorFunc(arrayExp_Value, normalExp));
                }
            } else {
                innerResult.push(swapped ? operatorFunc(normalExp, arrayExp[i]) : operatorFunc(arrayExp[i], normalExp));
            }
            result.push(innerResult);
          }
    } else {
        const rows = Math.max(exp1.length,exp2.length);
        const columns = Math.max(exp1[0].length ? exp1[0].length : 0, exp2[0].length ? exp2[0].length : 0);
        for(let i = 0; i < rows; i++) {
            var innerResult = [];
            if (columns === 0) {
                innerResult.push(operatorFunc(exp1[i], exp2[i]));
            } else {
                for(let j = 0; j < columns; j++) {
                    let exp1_value;
                    let exp2_value;
            
                    if(exp1[0].length === 1) {
                      exp1_value = exp1[i][0];
                    }
                    if(exp2[0].length === 1) {
                      exp2_value = exp2[i][0];
                    }
            
                    if(exp1.length === 1) {
                      exp1_value = exp1[0][j];
                    }
                    
                    if(exp2.length === 1) {
                      exp2_value = exp2[0][j];
                    }
            
                    if(exp1_value === undefined) {
                      exp1_value = exp1[i] ? exp1[i][j] ? exp1[i][j] : undefined : undefined;
                    }
                    if(exp2_value === undefined) {
                      exp2_value = exp2[i] ? exp2[i][j] ? exp2[i][j] : undefined : undefined;
                    }
                    innerResult.push(operatorFunc(exp1_value, exp2_value));
                }
            }
            
            result.push(innerResult);
        }
    }

    return (result.length > 1 || result[0].length > 1) ? result : result[0][0];
}