#include "../include/cobject.h"
#include "../include/cppobject.hpp"
#include "../include/yacppobject.hpp"
#include "../include/ccobject.hh"
#include "../include/nested_dir/nestedccobject.hh"

int main (void)
{
    print_cobject ();
    print_cppobject ();
    print_ccobject ();
    print_nestedccobject ();
    print_yacppobject ();

    return 0;
}
