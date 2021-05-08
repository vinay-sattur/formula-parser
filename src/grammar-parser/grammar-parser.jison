/* description: Parses end evaluates mathematical expressions. */
/* lexical grammar */
%lex
%%
\s+                                                                                             {/* skip whitespace */}
'"'("\\"["]|[^"])*'"'(?!\!)                                                                     {return 'STRING';}
"'"('\\'[']|[^'])*"'"(?!\!)                                                                     {return 'STRING';}
[A-Za-z]{1,}[A-Za-z_0-9\.]+(?=[(])                                                              {return 'FUNCTION';}
'#'[A-Z0-9\/]+('!'|'?')?                                                                        {return 'ERROR';}
[A-Za-z0-9\s!@#$%&\'\"]+'!'                                                                     {return 'SHEET_REF';}
'$'[A-Za-z]+'$'[0-9]+                                                                           {return 'ABSOLUTE_CELL';}
'$'[A-Za-z]+[0-9]+                                                                              {return 'MIXED_CELL';}
[A-Za-z]+'$'[0-9]+                                                                              {return 'MIXED_CELL';}
[A-Za-z]+[0-9]+                                                                                 {return 'RELATIVE_CELL';}
[A-Za-z\.]+(?=[(])                                                                              {return 'FUNCTION';}
[A-Za-z]{1,}[A-Za-z_0-9]+                                                                       {return 'VARIABLE';}
[A-Za-z_]+                                                                                      {return 'VARIABLE';}
[0-9]+                                                                                          {return 'NUMBER';}
'['(.*)?']'                                                                                     {return 'ARRAY';}
"&"                                                                                             {return '&';}
" "                                                                                             {return ' ';}
[.]                                                                                             {return 'DECIMAL';}
":"                                                                                             {return ':';}
";"                                                                                             {return ';';}
","                                                                                             {return ',';}
"*"                                                                                             {return '*';}
"/"                                                                                             {return '/';}
"-"                                                                                             {return '-';}
"+"                                                                                             {return '+';}
"^"                                                                                             {return '^';}
"("                                                                                             {return '(';}
")"                                                                                             {return ')';}
">"                                                                                             {return '>';}
"<"                                                                                             {return '<';}
"NOT"                                                                                           {return 'NOT';}
'"'                                                                                             {return '"';}
"'"                                                                                             {return "'";}
"!"                                                                                             {return "!";}
"="                                                                                             {return '=';}
"%"                                                                                             {return '%';}
[#]                                                                                             {return '#';}
<<EOF>>                                                                                         {return 'EOF';}
/lex

/* operator associations and precedence (low-top, high-bottom) */
%left '='
%left '<=' '>=' '<>' 'NOT' '||'
%left '>' '<'
%left '+' '-'
%left '*' '/'
%left '^'
%left '&'
%left '%'
%left UMINUS

%start expressions

%% /* language grammar */

expressions
  : expression EOF {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside expression EOF--------------", $1) : '';
      return $1;
    }
;

expression
  : variableSequence {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside variableSequence--------------", $1) : '';
      $$ = yy.callVariable($1[0]);
    }
  | number {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside number--------------", $1) : '';
      $$ = yy.toNumber($1);
    }
  | STRING {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside STRING--------------", $1) : '';
      $$ = yy.trimEdges($1);
    }
  | expression '&' expression {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside expression '&' expression--------------", $1, $3) : '';
      $$ = yy.evaluateByOperator('&', [$1, $3]);
    }
  | expression '=' expression {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside expression '=' expression--------------", $1, $3) : '';
      $$ = yy.evaluateByOperator('=', [$1, $3]);
    }
  | expression '+' expression {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside expression '+' expression--------------", $1, $3) : '';
      $$ = yy.evaluateByOperator('+', [$1, $3]);
    }
  | '(' expression ')' {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside '(' expression ')'--------------", $2) : '';
      $$ = $2;
    }
  | expression '<' '=' expression {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside expression '<' '=' expression--------------", $1, $4) : '';
      $$ = yy.evaluateByOperator('<=', [$1, $4]);
    }
  | expression '>' '=' expression {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside expression '>' '=' expression--------------", $1, $4) : '';
      $$ = yy.evaluateByOperator('>=', [$1, $4]);
    }
  | expression '<' '>' expression {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside expression '<' '>' expression--------------", $1, $3) : '';
      $$ = yy.evaluateByOperator('<>', [$1, $4]);
    }
  | expression NOT expression {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside expression NOT expression--------------", $1, $3) : '';
      $$ = yy.evaluateByOperator('NOT', [$1, $3]);
    }
  | expression '>' expression {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside expression '>' expression--------------", $1, $3) : '';
      $$ = yy.evaluateByOperator('>', [$1, $3]);
    }
  | expression '<' expression {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside expression '<' expression--------------", $1, $3) : '';
      $$ = yy.evaluateByOperator('<', [$1, $3]);
    }
  | expression '-' expression {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside expression '-' expression--------------", $1, $3) : '';
      $$ = yy.evaluateByOperator('-', [$1, $3]);
    }
  | expression '*' expression {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside expression '*' expression--------------", $1, $3) : '';
      $$ = yy.evaluateByOperator('*', [$1, $3]);
    }
  | expression '/' expression {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside expression '/' expression--------------", $1, $3) : '';
      $$ = yy.evaluateByOperator('/', [$1, $3]);
    }
  | expression '^' expression {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside expression '^' expression--------------", $1, $3) : '';
      $$ = yy.evaluateByOperator('^', [$1, $3]);
    }
  | '-' expression {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside '-' expression--------------", $2) : '';
      var n1 = yy.invertNumber($2);

      $$ = n1;

      if (isNaN($$)) {
          $$ = 0;
      }
    }
  | '+' expression {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside '+' expression--------------", $2) : '';
      var n1 = yy.toNumber($2);

      $$ = n1;

      if (isNaN($$)) {
          $$ = 0;
      }
    }
  | FUNCTION '(' ')' {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside FUNCTION '(' ')'--------------", $1) : '';
      $$ = yy.callFunction($1);
    }
  | FUNCTION '(' expseq ')' {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside FUNCTION '(' expseq ')'--------------", $1, $3) : '';
      $$ = yy.callFunction($1, $3);
    }
  | cell
  | error
  | error error
;

cell
   : ABSOLUTE_CELL {
     (typeof window === 'object' && window.logParse) ? console.log("-------Inside ABSOLUTE_CELL--------------", $1) : '';
      $$ = yy.cellValue($1);
    }
  | SHEET_REF ABSOLUTE_CELL {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside SHEET_REF ABSOLUTE_CELL--------------", $1, $2) : '';
      $$ = yy.cellValue($1 + $2);
    }
  | RELATIVE_CELL {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside RELATIVE_CELL--------------", $1) : '';
      $$ = yy.cellValue($1);
    }
  | SHEET_REF RELATIVE_CELL {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside SHEET_REF RELATIVE_CELL--------------", $1, $2) : '';
      $$ = yy.cellValue($1 + $2);
    }
  | MIXED_CELL {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside MIXED_CELL--------------", $1) : '';
      $$ = yy.cellValue($1);
    }
  | SHEET_REF MIXED_CELL {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside SHEET_REF MIXED_CELL--------------", $1, $2) : '';
      $$ = yy.cellValue($1 + $2);
    }
  | ABSOLUTE_CELL ':' ABSOLUTE_CELL {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside ABSOLUTE_CELL ':' ABSOLUTE_CELL--------------", $1, $3) : '';
      $$ = yy.rangeValue($1, $3);
    }
  | SHEET_REF ABSOLUTE_CELL ':' ABSOLUTE_CELL {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside SHEET_REF ABSOLUTE_CELL ':' ABSOLUTE_CELL--------------", $1, $2, $4) : '';
      $$ = yy.rangeValue($1 + $2, $1 + $4);
    }
  | ABSOLUTE_CELL ':' RELATIVE_CELL {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside ABSOLUTE_CELL ':' RELATIVE_CELL--------------", $1, $3) : '';
      $$ = yy.rangeValue($1, $3);
    }
  | SHEET_REF ABSOLUTE_CELL ':' RELATIVE_CELL {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside SHEET_REF ABSOLUTE_CELL ':' RELATIVE_CELL--------------", $1, $2, $4) : '';
      $$ = yy.rangeValue($1 + $2, $1 + $4);
    }
  | ABSOLUTE_CELL ':' MIXED_CELL {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside ABSOLUTE_CELL ':' MIXED_CELL--------------", $1, $3) : '';
      $$ = yy.rangeValue($1, $3);
    }
  | SHEET_REF ABSOLUTE_CELL ':' MIXED_CELL {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside SHEET_REF ABSOLUTE_CELL ':' MIXED_CELL--------------", $1, $2, $4) : '';
      $$ = yy.rangeValue($1 + $2, $1 + $4);
    }
  | RELATIVE_CELL ':' ABSOLUTE_CELL {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside RELATIVE_CELL ':' ABSOLUTE_CELL--------------", $1, $3) : '';
      $$ = yy.rangeValue($1, $3);
    }
  | SHEET_REF RELATIVE_CELL ':' ABSOLUTE_CELL {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside SHEET_REF RELATIVE_CELL ':' ABSOLUTE_CELL--------------", $1, $2, $4) : '';
      $$ = yy.rangeValue($1 + $2, $1 + $4);
    }
  | RELATIVE_CELL ':' RELATIVE_CELL {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside RELATIVE_CELL ':' RELATIVE_CELL--------------", $1, $3) : '';
      $$ = yy.rangeValue($1, $3);
    }
  | SHEET_REF RELATIVE_CELL ':' RELATIVE_CELL {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside SHEET_REF RELATIVE_CELL ':' RELATIVE_CELL--------------", $1, $2, $4) : '';
      $$ = yy.rangeValue($1 + $2, $1 + $4);
    }
  | RELATIVE_CELL ':' MIXED_CELL {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside RELATIVE_CELL ':' MIXED_CELL--------------", $1, $3) : '';
      $$ = yy.rangeValue($1, $3);
    }
  | SHEET_REF RELATIVE_CELL ':' MIXED_CELL {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside SHEET_REF RELATIVE_CELL ':' MIXED_CELL--------------", $1, $2, $4) : '';
      $$ = yy.rangeValue($1 + $2, $1 + $4);
    }
  | MIXED_CELL ':' ABSOLUTE_CELL {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside MIXED_CELL ':' ABSOLUTE_CELL--------------", $1, $3) : '';
      $$ = yy.rangeValue($1, $3);
    }
  | SHEET_REF MIXED_CELL ':' ABSOLUTE_CELL {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside SHEET_REF MIXED_CELL ':' ABSOLUTE_CELL--------------", $1, $2, $4) : '';
      $$ = yy.rangeValue($1 + $2, $1 + $4);
    }
  | MIXED_CELL ':' RELATIVE_CELL {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside MIXED_CELL ':' RELATIVE_CELL--------------", $1, $3) : '';
      $$ = yy.rangeValue($1, $3);
    }
  | SHEET_REF MIXED_CELL ':' RELATIVE_CELL {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside SHEET_REF MIXED_CELL ':' RELATIVE_CELL--------------", $1, $2, $4) : '';
      $$ = yy.rangeValue($1 + $2, $1 + $4);
    }
  | MIXED_CELL ':' MIXED_CELL {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside MIXED_CELL ':' MIXED_CELL--------------", $1, $3) : '';
      $$ = yy.rangeValue($1, $3);
    }
  | SHEET_REF MIXED_CELL ':' MIXED_CELL {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside SHEET_REF MIXED_CELL ':' MIXED_CELL--------------", $1, $2, $4) : '';
      $$ = yy.rangeValue($1 + $2, $1 + $4);
    }
;

expseq
  : ',' {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside ','--------------", $1) : '';
      $$ = [""];
    }
  
  | ',' expression {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside ',' expression--------------", $1, $2) : '';
      
      $$ = ["", $2];
    }
  
  | expression {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside expression--------------", $1) : '';
      $$ = [$1];
    }
  | ARRAY {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside ARRAY--------------", $1, yytext) : '';
      $$ = yy.trimEdges(yytext).split(',');
    }
  | expseq ';' expression {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside expseq ';' expression--------------", $1, $3) : '';
      $1.push($3);
      $$ = $1;
    }
  | expseq ',' expression {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside expseq ',' expression--------------", $1, $3) : '';
      if($1.join("") === "") {
        $1.push("");
      }
      $1.push($3);
      $$ = $1;
    }
  | expseq ',' {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside expseq ',' --------------", $1) : '';
      $1.push('');
      $$ = $1;
    }
;

variableSequence
  : VARIABLE {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside VARIABLE--------------", $1) : '';
      $$ = [$1];
    }
  | variableSequence DECIMAL VARIABLE {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside variableSequence DECIMAL VARIABLE--------------", $1, $3) : '';
      $$ = (Array.isArray($1) ? $1 : [$1]);
      $$.push($3);
    }
;

number
  : NUMBER {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside NUMBER--------------", $1) : '';
      $$ = $1;
    }
  | NUMBER DECIMAL NUMBER {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside NUMBER DECIMAL NUMBER--------------", $1, $3) : '';
      $$ = ($1 + '.' + $3) * 1;
    }
  | number '%' {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside number '%'--------------", $1) : '';
      $$ = $1 * 0.01;
    }
;

error
  : ERROR {
    (typeof window === 'object' && window.logParse) ? console.log("-------Inside ERROR--------------", $1) : '';
      $$ = yy.throwError($1);
    }
;

%%
