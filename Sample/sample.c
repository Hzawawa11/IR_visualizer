#include <stdio.h>
#define SIZE 2
#define MIN(a, b) (((a) < (b)) ? (a) : (b))
int a;

void func2( int *b ) {
  *b = 3;
}

int func1( int a, int *b) {
  int c;
  func2( b );
  c = a + *b;
  return c;       
}

int main(){
  
  int i, j, k;

  double matA[SIZE][SIZE];
  double matB[SIZE][SIZE];
  double matC[SIZE][SIZE];

  for(i=0; i<SIZE; i++)  
    for(k=0; k<SIZE; k++)  
      matA[i][k]=2.0;

  for(k=0; k<SIZE; k++)
    for(j=0; j<SIZE; j++)
      matB[k][j]=2.0; 

  for(i=0; i<SIZE; i++)
    for(j=0; j<SIZE; j++)
      matC[i][j]=0.0;


  for(i=0; i<SIZE; i++)
    for(j=0; j<SIZE; j++)
      for(k=0; k<SIZE; k++)
        matC[i][j] += matA[i][k] * matB[k][j];

  for(i=0;i<SIZE; i++){
    for(j=0;j<SIZE; j++){
      printf("%lf  ", matC[i][j]);
    }
    puts("");
  }

  int strd = 2;
  int x=SIZE, y=SIZE, z=SIZE;

  double matX[x*strd+z];
  double matY[z*strd+y];
  double matZ[x*strd+y];

  for(x=0; x<SIZE; x++)
    for(z=0; z<SIZE; z++)
      matX[x*strd+z]=2.0;

  for(z=0; z<SIZE; z++)
    for(y=0; y<SIZE; y++)
      matY[z*strd+y]=2.0;

  for(x=0;x<SIZE;x++)
    for(y=0;y<SIZE;y++)
      matZ[x*strd+y]=0.0;


  for(x=0;x<SIZE;x++)
    for(y=0;y<SIZE;y++)
      for(z=0;z<SIZE;z++)
        matZ[x*strd+y] += matX[x*strd+z]*matY[z*strd+y];

  for(x=0;x<SIZE; x++){
    for(y=0;y<SIZE; y++){
      printf("%lf  ", matZ[x*strd+y]);
    }
    puts("");
  }

  if( x == 7 ){
    printf("it's 7");
  }else if( x == 5 ){
    printf("it's 5");
  }else{
    printf("it's other");
  }

  if( x == 7 ){
    printf("it's 7\n");
  }
  if( x == 5 ){
    printf("it's 5\n");
  }
  if( x == 10){
    printf("it's 10\n");
  }

  switch(x){
    case 7:
      printf("it's 7");
      break;
    case 5:
      printf("it's 5");
      break;
    default:
      printf("it's other");
      break;
  }

  if( x == 7 ){
    printf("it's 7");
  }else if( x == 5 ){
    printf("it's 5");
  }else{
    printf("it's other");
  }

  for(int i = 0; i < 10; i++ ){
    printf("aiueo");
  }

  while(i < 10){
    printf("aiueo");
    i++;
  }

  do {
    printf("aiueo");
    i++;
  }
  while(i < 2);

  printf("aiueo");
  i++;
  while(i < 2){
    printf("aiueo");
    i++;
  }

  int b; int c;
  a = 1;
  c = func1( a, &b );
  printf("a=%d, b=%d, c=%d\n", a, b, c);

  int X; int Y;int Z;
  X = 1;
  Z = func1( X, &Y );
  printf("X=%d, Y=%d, Z=%d\n", X, Y, Z);
  
  int hoge = 10;
  int huga = 20;
  printf("%d", MIN(hoge, huga));
  printf("%d", ((hoge) < (huga)) ? (hoge) : (huga));

    for(i = 0; i < 10; i++ ){
    printf("aiueo");
    printf("aiueo");
    printf("aiueo");
    printf("aiueo");
    printf("aiueo");
    printf("aiueo");
  }
  for(i = 0; i < 10; i++ ){
    printf("aiueo");
  }

  for(i = 10; i > 0; i-- ){
    printf("aiueo");
  }

  i = 0;
  while(i < 10){
    printf("aiueo");
    i++;
  }


  i = 0;
  do {
    printf("aiueo");
    i++;
  }
  while(i < 10);


  if(i < 10){
    printf("HelloWorld\n");
    i++;
    printf("HelloWorld\n");
  }

}