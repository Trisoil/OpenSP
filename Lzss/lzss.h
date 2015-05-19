#ifndef LZSS_H
#define LZSS_H

#include <stdio.h>

     int GetByte();                                         
     void PutByte(unsigned char);                           

     void InitTree();                            
     void InsertNode(int);                      
     void DeleteNode(int);                       
     void Encode();                                         
     void Decode();                                         
     unsigned long Compress(unsigned char *,unsigned long,
                         unsigned char *);               
     unsigned long UnCompress(unsigned char *,unsigned long,
                           unsigned char *);             
#endif // LZSS_H
