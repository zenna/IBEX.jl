typealias CppType{T} Cxx.CppValue{Cxx.CppBaseType{T}}
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


# mig() const;

#     /**
#      * \brief Magnitude.
#    *
#      * Returns the magnitude of *this:
#      * mag(*this)=max(|lower bound|, |upper bound|). */
#     double mag() const;

#     /**
#      * \brief True iff this interval is a subset of \a x.
#      *
#      * \note Always return true if *this is empty.
#      */
#     bool is_subset(const Interval& x) const;

#     /**
#      * \brief True iff this interval is a subset of \a x and not \a x itself.
#      *
#      * \note In particular, (-oo,oo) is not a strict subset of (-oo,oo)
#      * and the empty set is not a strict subset of the empty set although
#      * in both cases, the first is inside the interior of the second.
#      */
#     bool is_strict_subset(const Interval& x) const;

#     /**
#      * \brief True iff this interval is in the interior of \a x.
#      *
#     * \note In particular, (-oo,oo) is in the interior of (-oo,oo)
#      * and the empty set is in the interior of the empty set.
#      * \note Always return true if *this is empty.
#      */
#     bool is_interior_subset(const Interval& x) const;

#     /**
#      * \brief True iff this interval is in the interior of \a x and different from x.
#      *
#      * \note In particular, (-oo,oo) is not "strictly" in the interior of (-oo,oo)
#      * and the empty set is not "strictly" in the interior of the empty set.
#      */
#     bool is_strict_interior_subset(const Interval& x) const;

#     /**
#      * \brief True iff this interval is a superset of \a x.
#      *
#      * \note Always return true if x is empty.
#      */
#     bool is_superset(const Interval& x) const;

#     /**
#      * \brief True iff this interval is a superset of \a x different from x.
#      *
#      * \see #is_strict_subset(const Interval&) const.
#      */
#     bool is_strict_superset(const Interval& x) const;

#     /**
#      * \brief True iff *this contains \a d.
#      *
#      * \note d can also be an "open bound", i.e., infinity.
#      * So this function is not restricted to a set-membership
#      * interpretation.
#      */
#     bool contains(const double& d) const;

#     /**
#      * \brief True iff the interior of *this contains \a d.
#      *
#      */
#     bool interior_contains(const double& d) const;

#     /**
#      * \brief True iff *this and \a x intersect.
#      */
#     bool intersects(const Interval &x) const;

#     /**
#      * \brief True iff *this and \a x intersect and the intersection has a non-null volume.
#      *
#      * Equivalently, some interior points (of this or x) must belong to the intersection.
#      */
#     bool overlaps(const Interval &x) const;

#     /**
#      * \brief True iff *this and \a x do not intersect.
#      *
#      */
#     bool is_disjoint(const Interval &x) const;

#     /**
#      * \brief True iff *this is empty.
#      */
#     bool is_empty() const;

#     /**
#      * \brief True iff *this is degenerated.
#      *
#      * An interval is degenerated if it is of the form [a, a]
#      *
#      * \note An empty interval is considered here as degenerated. */
#     bool is_degenerated() const;

#     /**
#      * \brief True if one bound of *this is infinite.
#      *
#      * \note An empty interval is always bounded.
#      */
#     bool is_unbounded() const;

#     /**
#      * \brief True iff *this can be bisected into two non-degenerated intervals.
#      *
#      * Examples of non bisectable intervals are [0,next_float(0)] or [DBL_MAX,+oo).
#      */
#     bool is_bisectable() const;

#     /**
#      * \brief Relative Hausdorff distance between *this and x.
#      *
#      * The relative distance is basically distance(x)/diam(*this).
#      * \see #ibex::distance (const ibex::Interval &x1, const ibex::Interval &x2).
#      */
#     double rel_distance(const Interval& x) const;

#     /*
#      * \brief The complementary of x.
#      */
#     int complementary(Interval& c1, Interval& c2) const;

#     /**
#      * \brief x\y
#      */
#     int diff(const Interval& y, Interval& c1, Interval& c2) const;

#     /** \brief Return -*this. */
#     Interval operator-() const;

#     /** \brief Add \a d to *this and return the result.  */
#     Interval& operator+=(double d);

#     /** \brief Subtract \a d to *this and return the result. */
#     Interval& operator-=(double d);

#     /** \brief Multiply *this by \a d and return the result. */
#     Interval& operator*=(double d);

#     /** \brief Divide *this by \a d and return the result. */
#     Interval& operator/=(double d);

#     /** \brief Add \a x to *this and return the result. */
#     Interval& operator+=(const Interval& x);

#     /** \brief Subtract \a x to *this and return the result. */
#     Interval& operator-=(const Interval& x);

#     /** \brief Multiply *this by \a x and return the result. */
#     Interval& operator*=(const Interval& x);

#     /**
#      * \brief Divide *this by \a x and return the result.
#      *
#      * Does better than *this=*this/x: because calculates
#      * the union of *this/x as intermediate result. */
#     Interval& operator/=(const Interval& x);

## Interval Arithmetic
## ===================
(*)(x::Interval, y::Interval) = icxx"$(x.data) * $(y.data);"
(*)(x::Interval,d::Float64) = icxx"$(x.data) * $d;"
(*)(x::Interval,d::Float64) = icxx"$d * $(x.data);"

(+)(x::Interval, y::Interval) = icxx"$(x.data) + $(y.data);"
(+)(x::Interval,d::Float64) = icxx"$(x.data) + $d;"
(+)(x::Interval,d::Float64) = icxx"$d + $(x.data);"

(-)(x::Interval, y::Interval) = icxx"$(x.data) - $(y.data);"
(-)(x::Interval,d::Float64) = icxx"$(x.data) - $d;"
(-)(x::Interval,d::Float64) = icxx"$d - $(x.data);"

(/)(x::Interval, y::Interval) = icxx"$(x.data) / $(y.data);"
(/)(x::Interval,d::Float64) = icxx"$(x.data) / $d;"
(/)(x::Interval,d::Float64) = icxx"$d / $(x.data);"

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

## Printing/io
## ===========
cxx"""
  void print_interval(Interval x) {
    std::cout << x << std::endl;
  }
"""
print(x::Interval) = @cxx print_interval(x.data)
show(x::Interval) = print(x)


# bwd_atan2(y::Interval, x::Interval, x::Interval)
# bwd_pow(y::Interval, x::Interval, x::Interval)
# bwd_pow(y::Interval, n::Int, x::Interval)
# bwd_root(y::Interval, n::Int, x::Interval)
# bwd_chi(f::Interval, a::Interval, b::Interval, c::Interval)
# bwd_integer(x::Interval)
# bwd_imod(x::Interval, y::Interval p::Float64)

# @cxx printme()
# @show @cxx Interval::PI

# f(X,Y,Z) = X + Y + Z

# typealias CppType{T} Cxx.CppValue{Cxx.CppBaseType{T}}
# IbexInterval = CppType{symbol("ibex::Interval")}
# +(x::IbexInterval, y::IbexInterval) = @cxx plus(x,y)
# ibexinterval(a,b) = @cxx ibex::Interval(a,b)
# a = ibexinterval(0,10)
# function ok{T}(a::Cxx.CppValue{Cxx.CppBaseType{T}}) = 20

# end