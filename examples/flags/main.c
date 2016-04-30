#include <stdio.h>

#ifdef FLAGS
char* flags_str =  "FLAGS";
#else
char* flags_str =  "";
#endif    

#ifdef DEBUG_FLAGS
char* debug_flags_str =  "DEBUG_FLAGS";
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
