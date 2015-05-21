CxxInterval = CppType{symbol("ibex::Interval")}

type Interval
  data::CxxInterval
end

# WARNING: Are there arounding issues?
Interval{T1<:Real,T2<:Real}(a::T1,b::T2) = Interval(@cxx ibex::Interval(convert(Float64,a),convert(Float64,b)))
Interval() = Interval(@cxx ibex::Interval())

copy(x::Interval) = Interval(lb(x),ub(x))
lb(x::Interval) = icxx"$(x.data).lb();"
ub(x::Interval) = icxx"$(x.data).ub();"
set_empty!(x::Interval) = (icxx"$(x.data).set_empty();";x)
 # Add [-rad,+rad] to *this.
inflate!(x::Interval, rad::Float64) = icxx"$(x.data).inflate($rad);"
mid(x::Interval) = icxx"$(x.data).mid());"
rad(x::Interval) = icxx"$(x.data).rad();"
mig(x::Interval) = icxx"$(x.data).mig();"

# True iff this interval is a subset of \a x.
is_subset(x::Interval, y::Interval) = icxx"$(x.data).is_subset($(y.data));"
is_strict_subset(x::Interval, y::Interval) = icxx"$(x.data).is_strict_subset($(y.data));"
is_interior_subset(x::Interval, y::Interval) = icxx"$(x.data).is_interior_subset($(y.data));"
is_strict_interior_subset(x::Interval, y::Interval) = icxx"$(x.data).istrict_s_interior_subset($(y.data));"
is_superset(x::Interval, y::Interval) = icxx"$(x.data).is_superset($(y.data));"
is_strict_superset(x::Interval, y::Interval) = icxx"$(x.data).is_strict_superset($(y.data));"
contains(x::Interval, d::Float64) = icxx"$(x.data).contains($d);"
interior_contains(x::Interval, d::Float64) = icxx"$(x.data).interior_contains($d);"
intersects(x::Interval, y::Interval) = icxx"$(x.data).intersects($(y.data));"
overlaps(x::Interval, y::Interval) = icxx"$(x.data).overlaps($(y.data));"
is_disjoint(x::Interval, y::Interval) = icxx"$(x.data).is_disjoint($(y.data));"
is_empty(x::Interval) = icxx"$(x.data).is_empty();"
is_degenerated(x::Interval) = icxx"$(x.data).is_degenerated();"
is_unbounded(x::Interval) = icxx"$(x.data).is_unbounded();"
is_bisectable(x::Interval) = icxx"$(x.data).is_bisectable();"
rel_distance(x::Interval, y::Interval) = icxx"$(x.data).rel_distance($(y.data));"
#     /*
#      * \brief The complementary of x.
#      */
#     int complementary(Interval& c1, Interval& c2) const;

## Interval Arithmetic
## ===================
(*)(x::Interval, y::Interval) = icxx"$(x.data) * $(y.data);"
(*)(x::Interval, d::Float64) = icxx"$(x.data) * $d;"
(*)(x::Interval, d::Float64) = icxx"$d * $(x.data);"

(+)(x::Interval, y::Interval) = icxx"$(x.data) + $(y.data);"
(+)(x::Interval, d::Float64) = icxx"$(x.data) + $d;"
(+)(x::Interval, d::Float64) = icxx"$d + $(x.data);"

(-)(x::Interval, y::Interval) = icxx"$(x.data) - $(y.data);"
(-)(x::Interval, d::Float64) = icxx"$(x.data) - $d;"
(-)(x::Interval, d::Float64) = icxx"$d - $(x.data);"

(/)(x::Interval, y::Interval) = icxx"$(x.data) / $(y.data);"
(/)(x::Interval, d::Float64) = icxx"$(x.data) / $d;"
(/)(x::Interval, d::Float64) = icxx"$d / $(x.data);"

# And/Or
cxx"""
  ibex::Interval and(const ibex::Interval &x, const ibex::Interval &y) {
    return x & y;
  }
  ibex::Interval or(const ibex::Interval &x, const ibex::Interval &y) {
    return x | y;
  }
"""
(&)(x::Interval,y::Interval) = Interval(@cxx and(x.data,y.data))
(&)(x::Interval,y::Interval) = Interval(@cxx or(x.data,y.data))

@doc "brief Hausdorff distance of [x]_1 and [x]_2." ->
distance(x::Interval, y::Interval) = @cxx distance(x.data,y.data)

# Unary trigonometric functions
function div2(x::Interval, y::Interval)
  out1,out2 = Interval(), Interval()
  @cxx ibex::div2(x.data,y.data, out1.data, out2.data)
  out1,out2
end
sqr(x::Interval) = Interval(@cxx ibex::sqr(x.data)) 
sqrt(x::Interval) = Interval(@cxx ibex::sqrt(x.data)) 
exp(x::Interval) = Interval(@cxx ibex::exp(x.data)) 
log(x::Interval) = Interval(@cxx ibex::log(x.data)) 
cos(x::Interval) = Interval(@cxx ibex::cos(x.data)) 
sin(x::Interval) = Interval(@cxx ibex::sin(x.data)) 
tan(x::Interval) = Interval(@cxx ibex::tan(x.data)) 
acos(x::Interval) = Interval(@cxx ibex::acos(x.data)) 
asin(x::Interval) = Interval(@cxx ibex::asin(x.data)) 
atan(x::Interval) = Interval(@cxx ibex::atan(x.data)) 
cosh(x::Interval) = Interval(@cxx ibex::cosh(x.data)) 
sinh(x::Interval) = Interval(@cxx ibex::sinh(x.data)) 
tanh(x::Interval) = Interval(@cxx ibex::tanh(x.data)) 
acosh(x::Interval) = Interval(@cxx ibex::acosh(x.data)) 
asinh(x::Interval) = Interval(@cxx ibex::asinh(x.data)) 
atanh(x::Interval) = Interval(@cxx ibex::atanh(x.data))  
abs(x::Interval) = Interval(@cxx ibex::abs(x.data))  

(^)(x::Interval, n::Int) = Interval(@cxx ibex::pow(x.data,n))
(^)(x::Interval, d::Float64) = Interval(@cxx ibex::pow(x.data,d))
root(x::Interval, n::Int) = Interval(@cxx ibex::root(x.data,n))

atan2(x::Interval, y::Interval) = Interval(@cxx ibex::atan2(x.data,y.data))
(^)(x::Interval, y::Interval) = Interval(@cxx ibex::pow(x.data,y.data))

max(x::Interval) = Interval(@cxx ibex::max(x.data,y.data))
min(x::Interval, y::Interval) = Interval(@cxx ibex::min(x.data,y.data))
sign(x::Interval) = Interval(@cxx ibex::sign(x.data))
chi(a::Interval, b::Interval, c::Interval) = Interval(@cxx ibex::chi(a.data,b.data,c.data))

# Return the largest integer interval included in x.
integer(X::Interval) = Interval(@cxx ibex::integer(x.data))

## Backwards (preimage) functions
## ==============================

# Convenience for making pure versions of impure bwd functions
function pure(f!::Function, y::Interval, xs::Interval...)
  outs = [copy(x) for x in xs]
  f!(y,outs...)
  outs
end

function pure(f::Function, y::Interval, x::Interval)
  out = copy(x)
  f!(y,out)
  out
end

bwd_add!(y::Interval, x1::Interval, x2::Interval) = @cxx ibex::bwd_add(y.data,x1.data,x2.data)
bwd_add(y::Interval, x1::Interval, x2::Interval) = pure(bwd_add!, y, x1, x2)
bwd_sub!(y::Interval, x1::Interval, x2::Interval) = @cxx ibex::bwd_sub(y.data,x1.data,x2.data)
bwd_sub(y::Interval, x1::Interval, x2::Interval) = pure(bwd_sub!, y, x1, x2)
bwd_mul!(y::Interval, x1::Interval, x2::Interval) = @cxx ibex::bwd_mul(y.data,x1.data,x2.data)
bwd_mul(y::Interval, x1::Interval, x2::Interval) = pure(bwd_mul!, y, x1, x2)
bwd_div!(y::Interval, x1::Interval, x2::Interval) = @cxx ibex::bwd_div(y.data,x1.data,x2.data)
bwd_div(y::Interval, x1::Interval, x2::Interval) = pure(bwd_div,x1,x2)
bwd_sqr!(y::Interval, x::Interval) = @cxx ibex::bwd_sqr(y.data, x.data)
bwd_sqr(y::Interval, x::Interval) = pure(bwd_sqr,y,x1)
bwd_sqrt!(y::Interval, x::Interval) = @cxx ibex::bwd_sqrt(y.data,x.data)
bwd_sqrt(y::Interval, x::Interval) = pure(bwd_sqrt!,y,x)
bwd_exp!(y::Interval,  x::Interval) = @cxx ibex::bwd_exp(y.data,x.data)
bwd_exp(y::Interval, x::Interval) = pure(bwd_exp!,y,x)
bwd_log!(y::Interval,  x::Interval) = @cxx ibex::bwd_log(y.data,x.data)
bwd_log(y::Interval, x::Interval) = pure(bwd_log!,y,x)
bwd_cos!(y::Interval,  x::Interval) = @cxx ibex::bwd_cos(y.data,x.data)
bwd_cos(y::Interval, x::Interval) = pure(bwd_cos!,y,x)
bwd_sin!(y::Interval,  x::Interval) = @cxx ibex::bwd_sin(y.data,x.data)
bwd_sin(y::Interval, x::Interval) = pure(bwd_sin!,y,x)
bwd_tan!(y::Interval,  x::Interval) = @cxx ibex::bwd_tan(y.data,x.data)
bwd_tan(y::Interval, x::Interval) = pure(bwd_tan!,y,x)
bwd_acos!(y::Interval,  x::Interval) = @cxx ibex::bwd_acos(y.data,x.data)
bwd_acos(y::Interval, x::Interval) = pure(bwd_acos!,y,x)
bwd_asin!(y::Interval,  x::Interval) = @cxx ibex::bwd_asin(y.data,x.data)
bwd_asin(y::Interval, x::Interval) = pure(bwd_asin!,y,x)
bwd_atan!(y::Interval,  x::Interval) = @cxx ibex::bwd_atan(y.data,x.data)
bwd_atan(y::Interval, x::Interval) = pure(bwd_atan!,y,x)
bwd_cosh!(y::Interval,  x::Interval) = @cxx ibex::bwd_cosh(y.data,x.data)
bwd_cosh(y::Interval, x::Interval) = pure(bwd_cosh!,y,x)
bwd_sinh!(y::Interval,  x::Interval) = @cxx ibex::bwd_sinh(y.data,x.data)
bwd_sinh(y::Interval, x::Interval) = pure(bwd_sinh!,y,x)
bwd_tanh!(y::Interval,  x::Interval) = @cxx ibex::bwd_tanh(y.data,x.data)
bwd_tanh(y::Interval, x::Interval) = pure(bwd_tanh!,y,x)
bwd_acosh!(y::Interval,  x::Interval) = @cxx ibex::bwd_acosh(y.data,x.data)
bwd_acosh(y::Interval, x::Interval) = pure(bwd_acosh!,y,x)
bwd_atanh!(y::Interval,  x::Interval) = @cxx ibex::bwd_atanh(y.data,x.data)
bwd_atanh(y::Interval, x::Interval) = pure(bwd_atanh!,y,x)
bwd_asinh!(y::Interval,  x::Interval) = @cxx ibex::bwd_asinh(y.data,x.data)
bwd_asinh(y::Interval, x::Interval) = pure(bwd_asinh!,y,x)
bwd_sign!(y::Interval, x::Interval) = @cxx ibex::bwd_sign(y.data,x.data)
bwd_sign(y::Interval, x::Interval) = pure(bwd_sign!,y,x)
bwd_abs!(y::Interval,  x::Interval) = @cxx ibex::bwd_abs(y.data,x.data)
bwd_abs(y::Interval, x::Interval) = pure(bwd_abs!,y,x)
bwd_max!(y::Interval, x1::Interval, x2::Interval) = @cxx ibex::bwd_max(y.data,x1.data,x2.data)
bwd_max(y::Interval, x1::Interval, x2::Interval) = pure(bwd_max!, y, x1, x2)
bwd_min!(y::Interval, x1::Interval, x2::Interval) = @cxx ibex::bwd_min(y.data,x1.data,x2.data)
bwd_min(y::Interval, x1::Interval, x2::Interval) = pure(bwd_max!, y, x1, x2)
bwd_atan2!(y::Interval, x1::Interval, x2::Interval) = @cxx ibex::bwd_atan2(y.data,x1.data,x2.data)
bwd_atan2(y::Interval, x1::Interval, x2::Interval) = pure(bwd_atan2!, y, x1, x2)
bwd_pow(y::Interval, x1::Interval, x2::Interval) = @cxx ibex::bwd_pow(y.data,x1.data,x2.data)
bwd_pow!(y::Interval, x1::Interval, x2::Interval) = pure(bwd_pow,y,x1,x2)

bwd_pow(y::Interval, n::Int, x::Interval) = @cxx ibex::bwd_pow(y.data,n,x.data)
bwd_pow!(y::Interval, n::Int, x::Interval) = pure((y,x)->bwd_pow!(y,n,x),y,x)
bwd_root(y::Interval, n::Int, x::Interval) = @cxx ibex::bwd_root(y.data,n,x.data)
bwd_root!(y::Interval, n::Int, x::Interval) = pure((y,x)->bwd_root!(y,n,x),y,x)

bwd_chi!(f::Interval, a::Interval, b::Interval, c::Interval) = @cxx ibex::bwd_chi(f.data,a.data,b.data,c.data)
bwd_chi(f::Interval, a::Interval, b::Interval, c::Interval) = pure(bwd_atan2!, f, a, b,c)

# FIXME - Implememnt these. Dont quite fit into pure
# bwd_integer(x::Interval)
# bwd_imod(x::Interval, y::Interval p::Float64)

## Printing/io
## ===========
cxx"""
  void print_interval(Interval x) {
    std::cout << x << std::endl;
  }
"""
print(x::Interval) = @cxx print_interval(x.data)
show(x::Interval) = print(x)