using IBEX
using Base.Test

# @show a+a
A = Interval(3,5)
B = Interval(1.5,2.2)
C = Interval(7.8,8.1)
D,E = bwd_mul(C,A,B)
A * A