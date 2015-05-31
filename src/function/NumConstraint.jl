@doc """ * A numerical constraint is a constraint under the form
  f(x)<0, f(x)<=0, f(x)=0, f(x)>=0 or f(x)>0 where
  f is a #ibex::Function.""" ->
type NumConstraint
  cxx
end

cxx"""
  Array<const ExprSymbol>
  array_constraints(int n) {
    Array<const ExprSymbol> vars(n);
    return vars;
  }
"""
cxx"""
  std::string print_to_string(NumConstraint n) {
    std::stringstream ss;
    ss << n;
    return ss.str();
  }
"""

cxx"""
  void print_numconstraint(NumConstraint n) {
    std::cout << n << std::endl;
  }
"""

function NumConstraint(x::Set{ExprSymbol}, c::ExprCtr)
  nconstraints = length(x)
  array_constraints = @cxx array_constraints(nconstraints)
  i::Int = 0
  for exprsymbol in x
    @cxx array_constraints->set_ref(i, exprsymbol.cxx)
    i += 1
  end
  auto(@cxx NumConstraint(array_constraints, c.cxx))
end

string(n::NumConstraint) = @cxx print_to_string(n.cxx)
print(n::NumConstraint) = @cxx print_numconstraint(n.cxx)

auto{T<:CppAllType{symbol("ibex::NumConstraint")}}(x::T) = NumConstraint(x)