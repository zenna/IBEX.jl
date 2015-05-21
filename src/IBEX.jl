module IBEX

## Interop with ibex solver
## ========================
(VERSION >= v"0.4-") ? nothing :
     throw(ErrorException("Julia $VERSION does not support C++ FFI"))

using Cxx
using Compat
import Base:  asin,
              sqrt,
              exp,
              log,
              cos,
              sin,
              tan,
              acos,
              asin,
              atan,
              cosh,
              sinh,
              tanh,
              acosh,
              asinh,
              atanh,
              abs,
              atan2,
              max,
              min,
              sign
import Base: copy, print, show, getindex, isequal

cxx_includes = ["/home/zenna/Downloads/ibex-2.1.13/INSTALL/include",
                "/home/zenna/Downloads/ibex-2.1.13/INSTALL/include/ibex"]

# function __init__()
for cxx_include in cxx_includes
  addHeaderDir(cxx_include; kind = C_System)
end

cxx"""
    #include "ibex.h"
    using namespace ibex;
    using namespace std;
"""
@compat Libdl.dlopen("libprim.so", Libdl.RTLD_LAZY|Libdl.RTLD_DEEPBIND|Libdl.RTLD_GLOBAL)
@compat Libdl.dlopen("libibex.so", Libdl.RTLD_LAZY|Libdl.RTLD_DEEPBIND|Libdl.RTLD_GLOBAL)

include("common.jl")
include("interval.jl")
include("symbolic/Expr.jl")
include("symbolic/ExprCtr.jl")


# end

export
  copy,
  lb,
  ub,
  set_empty!,
   # Add [-rad,+rad] to *this.
  inflate!,
  mid,
  rad,
  mig

export Interval,
  div2,
  chi,
  root,
  distance,
  integer,
  bwd_add!,
  bwd_add,
  bwd_sub!,
  bwd_sub,
  bwd_mul!,
  bwd_mul,
  bwd_div!,
  bwd_div,
  bwd_sqr!,
  bwd_sqr,
  bwd_sqrt!,
  bwd_sqrt,
  bwd_exp!,
  bwd_exp,
  bwd_log!,
  bwd_log,
  bwd_cos!,
  bwd_cos  , 
  bwd_sin!,
  bwd_sin,
  bwd_tan!,
  bwd_tan,
  bwd_acos!,
  bwd_acos,
  bwd_asin!,
  bwd_asin,
  bwd_atan!,
  bwd_atan,
  bwd_cosh!,
  bwd_cosh,
  bwd_sinh!,
  bwd_sinh,
  bwd_tanh!,
  bwd_tanh,
  bwd_acosh!,
  bwd_acosh,
  bwd_atanh!,
  bwd_atanh,
  bwd_asinh!,
  bwd_asinh,
  bwd_sign!,
  bwd_sign,
  bwd_abs!,
  bwd_abs,
  bwd_max!,
  bwd_max!,
  bwd_min!,
  bwd_min!,
  bwd_atan2!,
  bwd_atan2

end