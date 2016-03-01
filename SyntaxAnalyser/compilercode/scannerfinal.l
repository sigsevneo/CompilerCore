D  [0-9]
L  [a-zA-Z_]
H  [a-fA-F0-9]
E  [Ee][+-]?{D}+
FS (f|F|l|L)
IS (u|U|l|L)*
%{
#include <stdio.h>
void count();
%}
%%
"/*"                        { printf("comment %s\n", yytext);
                             }
"auto"                      { 
                                count();
                                printf("AUTO %s\n", yytext); 
                            }
"break"                     { 
                                count(); 
                                printf("BREAK %s\n", yytext); 
                            }
"case"                      { 
                                count(); 
                                printf("CASE %s\n", yytext); 
                            }
                            
"char"                      {   
                                count(); 
                                printf("CHAR %s\n", yytext); 
                            }


"const"                     {   
                                count(); 
                                printf("CONST %s\n", yytext); 
                            }

"continue"                  { 
                                count(); 
                                printf("CONTINUE %s\n", yytext); 
                            }
"default"                   {   
                                count(); 
                                printf("DEFAULT %s\n", yytext); 
                            }
"do"                        { 
                                count(); 
                                printf("DO %s\n", yytext); 
                            }

"double"                    {   
                                count(); 
                                printf("DOUBLE %s\n", yytext); 
                            }
"else"                      {   
                                count(); 
                                printf("ELSE %s\n", yytext); 
                            }


"enum"                      {   
                                count(); 
                                printf("ENUM %s\n", yytext); 
                            }

"extern"                    { 
                                count(); 
                                printf("EXTERN %s\n", yytext); 
                            }

"float"                     {   
                                count(); 
                                printf("FLOAT %s\n", yytext); 
                            }

"for"                       { 
                                count(); 
                                printf("FOR %s\n", yytext); 
                            }

"goto"                      { 
                                count(); 
                                printf("GOTO %s\n", yytext); 
                            }

"if"                        { 
                                count(); 
                                printf("IF %s\n", yytext); 
                            }

"int"                       {   count();
                                printf("INT %s\n", yytext);
                            }


"long"                      {   count();
                                printf("LONG %s\n", yytext);
                            }


"register"                  {   count();
                                printf("REGISTER %s\n", yytext);
                            }


"return"                    {   count();
                                printf("RETURN %s\n", yytext);
                            }


"short"                     {   count();
                                printf("SHORT %s\n", yytext);
                            }


"signed"                    {   count();
                                printf("SIGNED %s\n", yytext);
                            }


"sizeof"                    {   count();
                                printf("SIZEOF %s\n", yytext);
                            }


"static"                    {   count();
                                printf("STATIC %s\n", yytext);
                            }


"struct"                    {   count();
                                printf("STRUCT %s\n", yytext);
                            }


"switch"                    {   count();
                                printf("SWITCH %s\n", yytext);
                            }


"typedef"                   {   count();
                                printf("TYPEDEF %s\n", yytext);
                            }


"union"                     {   count();
                                printf("UNION %s\n", yytext);
                            }


"unsigned"                  {   count();
                                printf("UNSIGNED %s\n", yytext);
                            }


"void"                      {   count();
                                printf("VOID %s\n", yytext);
                            }


"volatile"                  {   count();
                                printf("VOLATILE %s\n", yytext);
                            }


"while"                     {   count();
                                printf("WHILE %s\n", yytext);
                            }
^#.*                        {printf("Preprocessor %s\n", yytext);}

{L}({L}|{D})*               { count();
                             check_type(); }              

0[xX]{H}+{IS}?              { count();
                             printf("CONSTANT %s\n", yytext); }
0{D}+{IS}?
{D}+{IS}?                   { count(); printf("CONSTANT %s\n", yytext); }
L?'(\\.|[^\\'])+'           { count(); printf("CONSTANT %s\n", yytext); }
{D}+{E}{FS}?                { count(); printf("CONSTANT %s\n", yytext); }
{D}*"."{D}+({E})?{FS}?      { count(); printf("CONSTANT %s\n", yytext); }
{D}+"."{D}*({E})?{FS}?      { count(); printf("CONSTANT %s\n", yytext); }
L?\"(\\.|[^\\"])*\"         { count(); printf("STRING_LITERAL %s\n", yytext); }
"..."                       { count(); printf("ELLIPSIS %s\n", yytext); }
">>="                       { count(); printf("RIGHT_ASSIGN %s\n", yytext); }
"<<="                       { count(); printf("LEFT_ASSIGN %s\n", yytext); }
"+="                        { count(); printf("ADD_ASSIGN %s\n", yytext); }
"-="                        { count(); printf("SUB_ASSIGN %s\n", yytext); }
"*="                        { count(); printf("MUL_ASSIGN %s\n", yytext); }
"/="                        { count(); printf("DIV_ASSIGN %s\n", yytext); }
"%="                        { count(); printf("MOD_ASSIGN %s\n", yytext); }
"&="                        { count(); printf("AND_ASSIGN %s\n", yytext); }
"^="                        { count(); printf("XOR_ASSIGN %s\n", yytext); }
"|="                        { count(); printf("OR_ASSIGN %s\n", yytext); }
">>"                        { count(); printf("RIGHT_OP %s\n", yytext); }
"<<"                        { count(); printf("LEFT_OP %s\n", yytext); }
"++"                        { count(); printf("INC_OP %s\n", yytext); }
"--"                        { count(); printf("DEC_OP %s\n", yytext); }
"->"                        { count(); printf("PTR_OP %s\n", yytext); }
"&&"                        { count(); printf("AND_OP %s\n", yytext); }
"||"                        { count(); printf("OR_OP %s\n", yytext); }
"<="                        { count(); printf("LE_OP %s\n", yytext); }
">="                        { count(); printf("GE_OP %s\n", yytext); }
"=="                        { count(); printf("EQ_OP %s\n", yytext); }
"!="                        { count(); printf("NE_OP %s\n", yytext); }
";"                         { count(); printf(" END_OF_STATEMENT %s\n", yytext); }
("{"|"<%")                  { count(); printf("\n BEGIN_BLOCK %s\n", yytext); }
("}"|"%>")                  { count(); printf("\n END_BLOCK\n %s\n", yytext); }
","                         { count(); printf(", %s\n", yytext); }
":"                         { count(); printf(": %s\n", yytext); }
"="                         { count(); printf("= %s\n", yytext); }
"("                         { count(); printf("( %s\n", yytext); }
")"                         { count(); printf(") %s\n", yytext); }
("["|"<:")                  { count(); printf("[ %s\n", yytext); }
("]"|":>")                  { count(); printf("] %s\n", yytext); }
"."                         { count(); printf(". %s\n", yytext); }
"&"                         { count(); printf(" AMP %s\n", yytext); }
"!"                         { count(); printf(" NOT %s\n", yytext); }
"~"                         { count(); printf(" COMPLEMENT %s\n", yytext); }
"-"                         { count(); printf(" MINUS %s\n", yytext); }
"+"                         { count(); printf(" PLUS %s\n", yytext); }
"*"                         { count(); printf(" MULT %s\n", yytext); }
"/"                         { count(); printf("/ %s\n", yytext); }
"%"                         { count(); printf("%s\n",yytext); }
"<"                         { count(); printf("< %s\n", yytext); }
">"                         { count(); printf("> %s\n", yytext); }
"^"                         { count(); printf("^ %s\n", yytext); }
"|"                         { count(); printf("| %s\n", yytext); }
"?"                         { count(); printf("? %s\n", yytext); }
[ \t\v\f]                   { count(); printf("%s\n",yytext);}
.                           { /* ignore bad characters */ }

%%
yywrap()
{
    return(1);
}
comment()
{
    char c, c1;
    loop:
        while ((c = input()) != '*' && c != 0)
        putchar(c);
    if ((c1 = input()) != '/' && c != 0)
    {
        unput(c1);
        goto loop;
    }
    if (c != 0)
        putchar(c1);
    }
    int column = 0;
    void count(){/*
    int i;
    for (i = 0; yytext[i] != '\0'; i++)
    if (yytext[i] == '\n')
        column = 0;
    else if (yytext[i] == '\t')
        column += 8 - (column % 8);
    else
        column++;
    ECHO;*/
}

int check_type()
{
    /*
    * pseudo code --- this is what it should check
    *
    *
    * if (yytext == type_name)
    *
    *    printf("TYPE_NAME");
    *    printf("IDENTIFIER");
    */
    //it actually will only return IDENTIFIER
    printf("IDENTIFIER %s\n", yytext);
}

main(argc,argv)
int argc;
char **argv;
{
    ++argv,--argc;/*skip program name*/
    if(argc>0)
    {
        yyin=fopen(argv[0],"r");
    }
    else
    {
        yyin=stdin;
    }
    yylex();
}














