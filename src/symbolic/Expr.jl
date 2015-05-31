abstract ExprNode

getindex{T<:ExprNode}(x::T, i::Int) = auto(icxx"$(x.cxx)[$i];")
isequal{T1<:ExprNode, T2<:ExprNode}(x::T1, y::T2) = icxx"$(x.cxx) == $(y.cxx);"

@doc doc"""An instance of this class represents a leaf in the syntax tree. This leaf
  merely contains the name of the symbol, a string (char*).""" ->
type ExprSymbol <: ExprNode
  cxx
end

# @doc "Create a new anonymous symbol. The string name is generated." ->
ExprSymbol() = ExprSymbol(@cxx ibex::ExprSymbol::new_())
ExprSymbol(n::Int) = (colvec = @cxx Dim::col_vec(n); ExprSymbol(@cxx ExprSymbol::new_(colvec)))

@doc "Constant expression" ->
type ExprConstant <: ExprNode
  cxx
end

ExprConstant{T<:Real}(x::T) = auto(@cxx ExprConstant::new_scalar(x))
ExprConstant(x::Interval) = auto(@cxx ExprConstant::new_scalar(x.data))
auto{T<:CppAllType{symbol("ibex::ExprConstant")}}(x::T) = ExprConstant(x)

type ExprIndex <: ExprNode cxx end
type ExprVector <: ExprNode cxx end
type ExprApply <: ExprNode cxx end
type ExprChi <: ExprNode cxx end
type ExprEntity <: ExprNode cxx end
type ExprLeaf <: ExprNode cxx end
type ExprSymbol <: ExprNode cxx end
type Variable cxx end
type ExprBinaryOp <: ExprNode cxx end
type ExprAdd <: ExprNode cxx end
type ExprMul <: ExprNode cxx end
type ExprSub <: ExprNode cxx end
type ExprDiv <: ExprNode cxx end
type ExprMax <: ExprNode cxx end
type ExprMin <: ExprNode cxx end
type ExprAtan2 <: ExprNode cxx end
type ExprUnaryOp <: ExprNode cxx end
type ExprMinus <: ExprNode cxx end
type ExprTrans <: ExprNode cxx end
type ExprSign <: ExprNode cxx end
type ExprAbs <: ExprNode cxx end
type ExprPower <: ExprNode cxx end
type ExprSqr <: ExprNode cxx end
type ExprSqrt <: ExprNode cxx end
type ExprExp <: ExprNode cxx end
type ExprLog <: ExprNode cxx end
type ExprCos <: ExprNode cxx end
type ExprSin <: ExprNode cxx end
type ExprTan <: ExprNode cxx end
type ExprCosh <: ExprNode cxx end
type ExprSinh <: ExprNode cxx end
type ExprTanh <: ExprNode cxx end
type ExprAcos <: ExprNode cxx end
type ExprAsin <: ExprNode cxx end
type ExprAtan <: ExprNode cxx end
type ExprAcosh <: ExprNode cxx end
type ExprAsinh <: ExprNode cxx end
type ExprAtanh <: ExprNode cxx end

auto{T<:CppAllType{symbol("ibex::ExprIndex")}}(x::T) = ExprIndex(x)
auto{T<:CppAllType{symbol("ibex::ExprNode")}}(x::T) = ExprNode(x)
auto{T<:CppAllType{symbol("ibex::ExprIndex")}}(x::T) = ExprIndex(x)
auto{T<:CppAllType{symbol("ibex::ExprNAryOp")}}(x::T) = ExprNAryOp(x)
auto{T<:CppAllType{symbol("ibex::ExprVector")}}(x::T) = ExprVector(x)
auto{T<:CppAllType{symbol("ibex::ExprApply")}}(x::T) = ExprApply(x)
auto{T<:CppAllType{symbol("ibex::ExprChi")}}(x::T) = ExprChi(x)
auto{T<:CppAllType{symbol("ibex::ExprEntity")}}(x::T) = ExprEntity(x)
auto{T<:CppAllType{symbol("ibex::ExprLeaf")}}(x::T) = ExprLeaf(x)
auto{T<:CppAllType{symbol("ibex::ExprSymbol")}}(x::T) = ExprSymbol(x)
auto{T<:CppAllType{symbol("ibex::Variable")}}(x::T) = Variable(x)
auto{T<:CppAllType{symbol("ibex::ExprBinaryOp")}}(x::T) = ExprBinaryOp(x)
auto{T<:CppAllType{symbol("ibex::ExprAdd")}}(x::T) = ExprAdd(x)
auto{T<:CppAllType{symbol("ibex::ExprMul")}}(x::T) = ExprMul(x)
auto{T<:CppAllType{symbol("ibex::ExprSub")}}(x::T) = ExprSub(x)
auto{T<:CppAllType{symbol("ibex::ExprDiv")}}(x::T) = ExprDiv(x)
auto{T<:CppAllType{symbol("ibex::ExprMax")}}(x::T) = ExprMax(x)
auto{T<:CppAllType{symbol("ibex::ExprMin")}}(x::T) = ExprMin(x)
auto{T<:CppAllType{symbol("ibex::ExprAtan2")}}(x::T) = ExprAtan2(x)
auto{T<:CppAllType{symbol("ibex::ExprUnaryOp")}}(x::T) = ExprUnaryOp(x)
auto{T<:CppAllType{symbol("ibex::ExprMinus")}}(x::T) = ExprMinus(x)
auto{T<:CppAllType{symbol("ibex::ExprTrans")}}(x::T) = ExprTrans(x)
auto{T<:CppAllType{symbol("ibex::ExprSign")}}(x::T) = ExprSign(x)
auto{T<:CppAllType{symbol("ibex::ExprAbs")}}(x::T) = ExprAbs(x)
auto{T<:CppAllType{symbol("ibex::ExprPower")}}(x::T) = ExprPower(x)
auto{T<:CppAllType{symbol("ibex::ExprSqr")}}(x::T) = ExprSqr(x)
auto{T<:CppAllType{symbol("ibex::ExprSqrt")}}(x::T) = ExprSqrt(x)
auto{T<:CppAllType{symbol("ibex::ExprExp")}}(x::T) = ExprExp(x)
auto{T<:CppAllType{symbol("ibex::ExprLog")}}(x::T) = ExprLog(x)
auto{T<:CppAllType{symbol("ibex::ExprCos")}}(x::T) = ExprCos(x)
auto{T<:CppAllType{symbol("ibex::ExprSin")}}(x::T) = ExprSin(x)
auto{T<:CppAllType{symbol("ibex::ExprTan")}}(x::T) = ExprTan(x)
auto{T<:CppAllType{symbol("ibex::ExprCosh")}}(x::T) = ExprCosh(x)
auto{T<:CppAllType{symbol("ibex::ExprSinh")}}(x::T) = ExprSinh(x)
auto{T<:CppAllType{symbol("ibex::ExprTanh")}}(x::T) = ExprTanh(x)
auto{T<:CppAllType{symbol("ibex::ExprAcos")}}(x::T) = ExprAcos(x)
auto{T<:CppAllType{symbol("ibex::ExprAsin")}}(x::T) = ExprAsin(x)
auto{T<:CppAllType{symbol("ibex::ExprAtan")}}(x::T) = ExprAtan(x)
auto{T<:CppAllType{symbol("ibex::ExprAcosh")}}(x::T) = ExprAcosh(x)
auto{T<:CppAllType{symbol("ibex::ExprAsinh")}}(x::T) = ExprAsinh(x)
auto{T<:CppAllType{symbol("ibex::ExprAtanh")}}(x::T) = ExprAtanh(x)

## Arithmetic
## ==========

cxx"""
ExprCtr isequal(const ibex::ExprNode &x, const ibex::ExprNode &y) {
  return x = y;
}
"""

(+){T1<:ExprNode,T2<:ExprNode}(x::T1,y::T2) = auto(icxx"$(x.cxx) + $(y.cxx);")
(-){T1<:ExprNode,T2<:ExprNode}(x::T1,y::T2) = auto(icxx"$(x.cxx) - $(y.cxx);")
(/){T1<:ExprNode,T2<:ExprNode}(x::T1,y::T2) = auto(icxx"$(x.cxx) / $(y.cxx);")
(*){T1<:ExprNode,T2<:ExprNode}(x::T1,y::T2) = auto(icxx"$(x.cxx) * $(y.cxx);")
(^){T1<:ExprNode,T2<:ExprNode}(x::T1,y::T2) = auto(icxx"$(x.cxx) ^ $(y.cxx);")
(>){T1<:ExprNode,T2<:ExprNode}(x::T1,y::T2) = auto(icxx"$(x.cxx) > $(y.cxx);")
(>=){T1<:ExprNode,T2<:ExprNode}(x::T1,y::T2) = auto(icxx"$(x.cxx) >= $(y.cxx);")
(<){T1<:ExprNode,T2<:ExprNode}(x::T1,y::T2) = auto(icxx"$(x.cxx) < $(y.cxx);")
(<=){T1<:ExprNode,T2<:ExprNode}(x::T1,y::T2) = auto(icxx"$(x.cxx) <= $(y.cxx);")
(==){T1<:ExprNode,T2<:ExprNode}(x::T1,y::T2) = auto(@cxx isequal(x.cxx,y.cxx)) # auto(icxx"$(x.cxx) = $(y.cxx);")

asin{T<:ExprNode}(x::T) = auto(icxx"asin($(x.cxx));")
sqrt{T<:ExprNode}(x::T) = auto(icxx"sqrt($(x.cxx));")
exp{T<:ExprNode}(x::T) = auto(icxx"exp($(x.cxx));")
log{T<:ExprNode}(x::T) = auto(icxx"log($(x.cxx));")
cos{T<:ExprNode}(x::T) = auto(icxx"cos($(x.cxx));")
sin{T<:ExprNode}(x::T) = auto(icxx"sin($(x.cxx));")
tan{T<:ExprNode}(x::T) = auto(icxx"tan($(x.cxx));")
acos{T<:ExprNode}(x::T) = auto(icxx"acos($(x.cxx));")
asin{T<:ExprNode}(x::T) = auto(icxx"asin($(x.cxx));")
atan{T<:ExprNode}(x::T) = auto(icxx"atan($(x.cxx));")
cosh{T<:ExprNode}(x::T) = auto(icxx"cosh($(x.cxx));")
sinh{T<:ExprNode}(x::T) = auto(icxx"sinh($(x.cxx));")
tanh{T<:ExprNode}(x::T) = auto(icxx"tanh($(x.cxx));")
acosh{T<:ExprNode}(x::T) = auto(icxx"acosh($(x.cxx));")
asinh{T<:ExprNode}(x::T) = auto(icxx"asinh($(x.cxx));")
atanh{T<:ExprNode}(x::T) = auto(icxx"atanh($(x.cxx));")
abs{T<:ExprNode}(x::T) = auto(icxx"abs($(x.cxx));")
atan2{T<:ExprNode}(x::T) = auto(icxx"atan2($(x.cxx));")
max{T<:ExprNode}(x::T) = auto(icxx"max($(x.cxx));")
min{T<:ExprNode}(x::T) = auto(icxx"min($(x.cxx));")
sign{T<:ExprNode}(x::T) = auto(icxx"sign($(x.cxx));")
-{T<:ExprNode}(x::T) = auto(icxx"-($(x.cxx));")
+{T<:ExprNode}(x::T) = auto(icxx"+($(x.cxx));")