#include "other_dir/cobject.h"
#include "other_dir/cppobject.hpp"
#include "one_dir/yacppobject.hpp"
#include "one_dir/ccobject.hh"
#include "one_dir/nested_dir/nestedccobject.hh"

int main (void)
{
    print_cobject ();
    print_cppobject ();
    print_ccobject ();
    print_nestedccobject ();
    print_yacppobject ();

    return 0;
}
