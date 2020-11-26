newPackage(
	"Auxiliary",
	Headline => "some auxiliary functions",
	Version => "0.0.1",
	Date => "2020",
	DebuggingMode => true)
-- Put here the name of functions that should be visible to users
export{
    "isStandardSubspace","powerSet" -- "sortedPowerSet",
}
--------------------------------------------------
-- Check whether sub-vector space of (ZZ/2)^n is generated by a subset of the standard basis
isStandardSubspace = method(TypicalValue => Boolean)
isStandardSubspace(Module) := (M) -> (
    if relations(M) != 0 then error "isStandardSubspace currently only implemented for submodules (not subqoutients)";
    -- maxStandardSubspace:
    d := rank target generators M;
    maxStandardSubspace := map((ZZ/2)^d,(ZZ/2)^0,0);
    for i from 0 to d-1 do (
    	standardBasisColumn := matrix id_((ZZ/2)^d)_i;
    	if isSubset(image standardBasisColumn,M) then maxStandardSubspace = maxStandardSubspace | standardBasisColumn
    	);    
    --print M;
    --print maxStandardSubspace;
    return rank M == rank maxStandardSubspace
)

--------------------------------------------------
-- Power sets
--- power set:
powerSet = method(TypicalValue => List)
powerSet(Set) := (S) -> (
    if #S > 0 then (
	e  := last toList(S);
	S' := powerSet(S-{e});
	return (S'|(apply(S', s -> s+set{e})));
	)    
    else return {set {}}
    )

beginDocumentation() -- very sensitive to indentation
doc ///
Key
  Auxiliary
Headline
  Auxiliary
Description
 Text
  An auxiliary package for the paper XXX.
  {\em This is work in progress.}
///
TEST ///
   M = ker substitute(matrix{{3,1,0,1,3,3}},ZZ/2)
   isStandardSubspace(M)
   M = image transpose substitute(matrix{{1,0,0,0,0,0},{0,0,0,0,0,1},{1,0,0,0,0,1},{1,1,0,0,0,0}},ZZ/2)
   isStandardSubspace(M)
   M = image transpose substitute(matrix{{1,1,0,0,0,0},{0,1,1,0,0,0}},ZZ/2)
   isStandardSubspace(M)
///
TEST ///
powerSet(set {})
powerSet(set {1})	
powerSet(set {1,2})	
///

