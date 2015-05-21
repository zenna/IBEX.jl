@doc """Constraint expression.
  This class simply encapsulates an expression (see #ibex::ExprNode) and
  a comparison operator, like =.""" ->
type ExprCtr
  cxx
end

auto{T<:CppAllType{symbol("ibex::ExprCtr")}}(x::T) = ExprCtr(x)
(==)(x::ExprCtr,y::ExprCtr) = icxx"($(x.cxx).e == $(y.cxx).e) && ($(x.cxx).op == $(y.cxx).op);"
(!)(x::ExprCtr) = auto(icxx"ibex::ExprCtr($(x.cxx).e,!$(x.cxx).op);")