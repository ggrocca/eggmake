#include <stdio.h>

#ifdef FLAGS__
char* flags_str =  "FLAGS__";
#else
char* flags_str =  "";
#endif    

#ifdef DEBUG_FLAGS__
char* debug_flags_str =  "DEBUG_FLAGS__";
#else
char* debug_flags_str =  "";
#endif    

void print_flags ()
{
    printf ("flags: %s -- debug_flags: %s\n", flags_str, debug_flags_str);
}

int main (void)
{
    print_flags ();
}
