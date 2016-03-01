#include<stdio.h>
# define num 50;
int main()
{
 int n, first = 0, second = 1, next, c;
int switch;
 printf("Enter the number of terms\n");
 scanf("%d",&n);

 for ( c = 0 ; c < num ; c++ )
 {
 if ( c <= 1 )
 next = c;
 else
 {
 next = first + second;
 first == second;
 second = next;
 }
 printf("%d\n",next);
 else
 prinf(“Unsuccessful\n”);
 }
 return 0;
}