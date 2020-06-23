//
//  copy_file.c
//
//  Created by Yong Liu on 2020/6/22.
//  Copyright © 2020 Yong Liu. All rights reserved.
//
#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <time.h>
#define O_LARGEFILE 0

extern void save_out(char* arr, long size);

int read_from_file_open(char *filename, size_t size)
{
    int fd;
    long *buffer=(long*) malloc(size * sizeof(long));
    fd = open(filename, O_RDONLY|O_LARGEFILE);
    if (fd == -1)
    {
        printf("\nFile Open Unsuccessful\n");
        exit (0);
    }
    off_t chunk=0;
    lseek(fd,0,SEEK_SET);
    while ( chunk < size )
    {
        size_t readnow;
        readnow = read(fd,((char *)buffer)+chunk,1048576);
        if (readnow < 0 )
        {
            printf("\nRead Unsuccessful\n");
            free (buffer);
            close (fd);
            return 0;
        }

        chunk=chunk+readnow;
    }

    printf("\nRead Success!\n");

    long total = size;
    
    clock_t start, end; 
    start = clock();

    save_out(buffer, size);

    end = clock();
    
    printf("Copy file from memory to file sucess!\n");
    
    printf("File size: %d MB\n", size/(1024 * 1024));
    
    double time_cost = 1.0 *(end - start) / CLOCKS_PER_SEC;
    printf("Time cost: %f s\n", time_cost);  

    free(buffer);
    close(fd);
    return 1;

}

int main(){
	char filename[] = "../data/data.txt";
	size_t size = 1100000000;
    	
	
	read_from_file_open(filename, size);
}
