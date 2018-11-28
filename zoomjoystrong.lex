%{
	#include <stdio.h>
	#include "zoomjoystrong.tab.h"
	void printLexeme();
	int lineNum = 1;
%}
 
%%
 
end           return END;				//END. This statement exits the interpreter.
;             {lineNum++; return EOL;}	//END_STATEMENT. All commands should end with a semicolon.
point         return POINT;				//POINT. When we match the command to plot a point.
line          return LINE;				//LINE. When we match the command to draw a line.
circle        return CIRCLE;			//CIRCLE. When we match the command to draw a circle.
rectangle     return RECTANGLE;			//RECTANGLE. When we match the command to draw a rectangle.
set_color     return SET_COLOR;			//SET_COLOR. Matches the command to change colors.
[0-9]+        {yylval=atoi(yytext); return INT;}	//INT. Matches an integer value.
[ |\t|\n|\r]      ; 					//A way to match tabs, spaces, or newlines, and to ignore them.

.	      { printf("Error Line %d: ", lineNum); printLexeme();} //Matches anything not listed above, and to tell the user they messed up, and on which line.
 
%%
//method to print invalid input
void printLexeme(){
        printf("(%s)\n", yytext);
}
