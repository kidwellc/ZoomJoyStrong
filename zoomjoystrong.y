%{
	#include <stdio.h>
	#include "zoomjoystrong.h"
	int yyerror(const char* err);
%}

%token INT
%token POINT
%token LINE
%token CIRCLE
%token RECTANGLE
%token END
%token SET_COLOR
%token EOL

%%

program:	list_of_expr
	;

list_of_expr:	expr
	|	list_of_expr expr
	;

expr:		POINT INT INT EOL {
			if(($2 > 1023)|($3 > 767))
				printf("Invalid POINT (%u,%u)\n", $2,$3);
			else
				point($2,$3);
				//printf("POINT (%u,%u)\n", $2,$3);
		}
	|	LINE INT INT INT INT EOL {
			if(($2 > 1023)|($3 > 767)|($4 > 1023)|($5 > 767))
				printf("Invalid LINE (%u,%u,%u,%u)\n", $2,$3,$4,$5);
			else
				line($2,$3,$4,$5);
				//printf("LINE (%u,%u,%u,%u)\n", $2,$3,$4,$5);		
		}
	|	CIRCLE INT INT INT EOL {
			if(($2 > 1023)|($3 > 767)|($4 > 640))
				printf("Invalid CIRCLE (%u,%u,%u)\n", $2,$3,$4);
			else
				circle($2,$3,$4);
				//printf("CIRCLE (%u,%u,%u)\n", $2,$3,$4);			
		}
	|	RECTANGLE INT INT INT INT EOL {
			if(($2 > 1023)|($3 > 767)|($4 > 1023)|($5 > 767))
				printf("Invalid RECTANGLE (%u,%u,%u,%u)\n", $2,$3,$4,$5);
			else
				rectangle($2,$3,$4,$5);
				//printf("RECTANGLE (%u,%u,%u,%u)\n", $2,$3,$4,$5);		
		}
	|	SET_COLOR INT INT INT EOL {
			if(($2 > 255)|($3 > 255)|($4 > 255))
				printf("Invalid COLOR (%u,%u,%u)\n", $2,$3,$4);
			else
				set_color($2,$3,$4);
				//printf("SET_COLOR (%u,%u,%u)\n", $2,$3,$4);		
		}
	|	END EOL{
			//this was for testing 
			//printf("end of file\n");
		}
	;

%%
int main(int argc, char** argv){
	setup();
	yyparse();
	finish;
}
int yyerror(const char* err){
	printf("%s\n", err);
}
