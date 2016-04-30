#include <stdio.h>

int main (void)
{
#ifdef COMMON
    printf ("COMMON\n");
#endif

#ifdef RELEASE
    printf ("RELEASE\n");
#endif

#ifdef DEBUG
    printf ("DEBUG\n");
#endif

#ifdef VERBOSE_TRACE
    printf ("VERBOSE_TRACE\n");
#endif

#ifdef STATIC
    printf ("STATIC\n");
#endif

#ifdef PLAIN_C
    printf ("PLAIN_C\n");
#endif

#ifdef CPLUSPLUS
    printf ("CPLUSPLUS\n");
#endif

    return 0;
}
