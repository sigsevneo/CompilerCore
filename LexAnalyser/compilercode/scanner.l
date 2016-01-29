%{
#include <stdio.h>

#include <stdlib.h>

#include <malloc.h>

#include <string.h>

int comment=0,bracCount=0;

char* ident[50]; //Symbol Table
char* constant[50]; //Constants Table
int it=0, ct=0; 
   
#define OPERATOR	1
#define LCURLY		2
#define RCURLY		3
#define COMMENT		4
#define SEMICOLON	5
#define KEYWORD		6
#define IDENTIFIER	7
#define INTEGER		8
#define STRING		9
#define FUNC		10
#define FLOAT		11
#define PUNCTUATOR	12

%}

/* Definitions for finite Automata */

digit [0-9]          

alpha [a-zA-Z_]   

comment (\/\/.*)

comstart (\/\*)

comend (\*\/)

keyword "auto"|"break"|"case"|"char"|"const"|"continue"|"default"|"do"|"double"|"else"|"enum"|"extern"|"float"|"for"|"goto"|"if"|"int"|"long"|"register"|"return"|"short"|"signed"|"sizeof"|"static"|"struct"|"switch"|"typedef"|"union"|"unsigned"|"void"|"volatile"|"while"

relop >|<|<=|>=|!=

delimiter [ \t\v\n]+

%%



^#([-a-zA-Z0-9.]|{relop}|{delimiter})* {
					fprintf(yyout,"\n%s\t\t\tPREPROCESSOR DIRECTIVE\t\t\t\t",yytext);
					
					}

{comment}           {
			if(comment<=0) fprintf(yyout,"\n//\t\t\t\t\t LINE COMMENT \t\t\t\t\t\t");
			
		    }

{comstart}            {

                      comment++;

                      if(comment>1)

                        fprintf(yyout,"\nERROR :: Nested Comment found.");

                      else

                        fprintf(yyout,"\n/*\t\t MultiLine Comment Begins\t\t\t");

                   }


{comend}            {   

                      if(comment>0)

                       {

                         comment--;

                         fprintf(yyout,"\n*/\t\tMultiLine Comment Ends\t\t\t");

                       }

                       else

                         fprintf(yyout,"\n\tERROR: */ occurs before : /* ");

                   }

{keyword}                       {if(comment<=0) fprintf(yyout,"\n%s\t\tKEYWORD\t\t",yytext);}

{alpha}+\(                      {if(comment<=0) fprintf(yyout,"\n%s\t \tFUNCTION\t\t",yytext);}

{alpha}({alpha}|{digit})*       {
				   if(comment<=0) 
				   {
 					fprintf(yyout,"\n%s\t\tIDENTIFIER\t\t ",yytext);
					ident[it++]=yytext;
					
				   }
				}

{digit}+                        {
				  if(comment<=0) {
					fprintf(yyout,"\n%s\t\tNUMERIC CONSTANT\t\t ",yytext);
					constant[ct++]=yytext;
				 }
				}

{digit}+\.{digit}+              {if(comment<=0) {fprintf(yyout,"\n%s \t\t FLOAT CONSTANT\t\t ",yytext);
					constant[ct++]=yytext;
				}}

\"(\\.|[^\\"])*\"               {if(comment<=0) {fprintf(yyout,"\n%-39s STRING LITERAL\t\t ",yytext);
					//constant[ct++]=yytext;
				}}

\"(\\.|[^\\"])*                 {if(comment<=0) printf("ERROR: End of string not found.\n");}

"{"                         {if(comment<=0) {fprintf(yyout,"\n%s\t\tOPEN BRACKET\t\t ",yytext);bracCount++;}}

"}"                         {if(comment<=0) {fprintf(yyout,"\n%s\t\tCLOSE BRACKET\t\t ",yytext);bracCount--;}}

","|";"|":"|"("|")"|"."     {if(comment<=0) fprintf(yyout,"\n%s \t\tPUNCTUATOR\t\t ",yytext);}

"&"|"!"|"~"|"+"|"-"|"*" {if(comment<=0) fprintf(yyout,"\n%s \t\tOPERATOR\t\t ",yytext);}
"/"|"%"|"<"|">"|"^"|"|" {if(comment<=0) fprintf(yyout,"\n%s \t\tOPERATOR\t\t ",yytext);}
"?"|"="|{relop}|"..."   {if(comment<=0) fprintf(yyout,"\n%s \t\tOPERATOR\t\t ",yytext);}
">>="|"<<="|"+="|"-="   {if(comment<=0) fprintf(yyout,"\n%s \t\tOPERATOR\t\t ",yytext);}
"*="|"/="|"%="|"&="     {if(comment<=0) fprintf(yyout,"\n%s \t\tOPERATOR\t\t ",yytext);}
"^="|"|="|">>"|"<<"|"+" {if(comment<=0) fprintf(yyout,"\n%s \t\tOPERATOR\t\t ",yytext);}
"--"|"->"|"&&"|"||"|"<=" {if(comment<=0) fprintf(yyout,"\n%s \t\tOPERATOR\t\t ",yytext);}

{delimiter} {;}

%%

/* MAIN PROGRAM */

int main(int argc,char **argv){

if(argv[1]==NULL)

 printf("Error opening file. Usage ./a.out <filename>\n");

else{

    yyin=fopen(argv[1],"r");

    printf("\n\t\t TOKEN IDENTIFICATION:\n Lexeme\t\t\tToken\n");

    yylex();

    if(comment!=0)

      printf("\nERROR: Comment does not end\n");

    if(bracCount!=0)

      printf("\nERROR: Bracket mismatch\n");

    printf("\n");

   printf("\n it:%d, ct:%d\n*************Symbol Table*************\n",it,ct);
   int index,k,j,flag;
   char x[50][50];
	for(index=0;index<it;index++){
		for(k=0;k<strlen(ident[index]);k++)
		{
			if (!isalnum(*(ident[index]+k))){
				x[index][k]='\0';
				break; }
			x[index][k]=*(ident[index]+k);
		}
		flag=0;
		for(j=0;j<index;j++)
			if(strcmp(x[j],x[index])==0) {flag=1; break;}

		if(!flag)
  		printf("-->%s\n",x[index]);}
   printf("\n*************************************\n"); 

   printf("\n************Constants Table********\n");
 	for(index=0;index<ct;index++){
  		
   for(k=0;k<strlen(constant[index]);k++)
		{
			if ((*(constant[index]+k))==';'){
				x[index][k]='\0';
				break; }
			x[index][k]=*(constant[index]+k);
		}
  		printf("-->%s\n",x[index]);
}
   printf("\n*************************************\n"); 

  }

}

int yywrap()
{
return(1);
}
