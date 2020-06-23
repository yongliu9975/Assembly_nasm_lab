#include <stdio.h>
int main(){
    int sum = 0;
    
    for(int a = 0; a < 3; a++){
        for(int b = 0; b < 4; b++){
            for(int c = 0; c < 5; c++){
                for(int d = 0; d < 6; d++){
                    sum += a;
                    sum += b;
                    sum += c;
                    sum += d;
                }
            }
        }
    }
    
    printf("sum = %d\n", sum);
    
    return 0;
}

