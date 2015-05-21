typealias CppType{T} Cxx.CppValue{Cxx.CppBaseType{T}}
typealias CppRef{T} Cxx.CppRef{Cxx.CppBaseType{T}}
typealias CppAllType{T} Union(CppRef{T},CppType{T})

function cxx(x::ASCIIString)
  Expr(:macrocall,symbol("@cxx_str"),Expr(:triple_quoted_string, x))
end

function icxx(x::ASCIIString)
  Expr(:macrocall,symbol("@icxx_str"),Expr(:triple_quoted_string, x))
end
