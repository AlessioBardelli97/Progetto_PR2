type ide = string;;
type exp = Eint of int | Ebool of bool | Den of ide | Prod of exp * exp | Sum of exp * exp | Diff of exp * exp |
	Eq of exp * exp | Minus of exp | IsZero of exp | Or of exp*exp | And of exp*exp | Not of exp |
	Ifthenelse of exp * exp * exp | Let of ide * exp * exp | Fun of ide * exp | FunCall of exp * exp |
	Letrec of ide * exp * exp | Etree of eTree | ApplyOver of exp * exp | Update of (ide list) * exp * exp | Select of (ide list) * exp * exp
and eTree = Empty | Node of ide * exp * eTree * eTree;;

(*ambiente polimorfo*)
type 't env = ide -> 't;;
let emptyenv (v : 't) = function x -> v;;
let applyenv (r : 't env) (i : ide) = r i;;
let bind (r : 't env) (i : ide) (v : 't) = function x -> if x = i then v else applyenv r x;;

(*tipi esprimibili*)
type evT = Int of int | Bool of bool | Unbound | FunVal of evFun | RecFunVal of ide * evFun | Empty | Node of ide * evT * evT * evT
and evFun = ide * exp * evT env;;


(*rts*)
(*type checking*)
let typecheck (s : string) (v : evT) : bool = match s with
	"int" -> (match v with
		Int(_) -> true |
		_ -> false) |
	"bool" -> (match v with
		Bool(_) -> true |
		_ -> false) |
	_ -> failwith("not a valid type");;

(*type checking for tree*)
let typecheckTree (t : evT) (v1 : evT) : bool = match t with
	Empty -> true |
	Node(i,v2,lt,rt) -> (match (v1,v2) with
							| (Int(_),Int(_)) -> true
							| (Bool(_),Bool(_)) -> true
							| (_,_) -> false) | 
	_ -> false;;
	
(*funzioni primitive*)
let prod x y = if (typecheck "int" x) && (typecheck "int" y)
	then (match (x,y) with
		(Int(n),Int(u)) -> Int(n*u))
	else failwith("Type error");;

let sum x y = if (typecheck "int" x) && (typecheck "int" y)
	then (match (x,y) with
		(Int(n),Int(u)) -> Int(n+u))
	else failwith("Type error");;

let diff x y = if (typecheck "int" x) && (typecheck "int" y)
	then (match (x,y) with
		(Int(n),Int(u)) -> Int(n-u))
	else failwith("Type error");;

let eq x y = if (typecheck "int" x) && (typecheck "int" y)
	then (match (x,y) with
		(Int(n),Int(u)) -> Bool(n=u))
	else failwith("Type error");;

let minus x = if (typecheck "int" x) 
	then (match x with
	   	Int(n) -> Int(-n))
	else failwith("Type error");;

let iszero x = if (typecheck "int" x)
	then (match x with
		Int(n) -> Bool(n=0))
	else failwith("Type error");;

let vel x y = if (typecheck "bool" x) && (typecheck "bool" y)
	then (match (x,y) with
		(Bool(b),Bool(e)) -> (Bool(b||e)))
	else failwith("Type error");;

let et x y = if (typecheck "bool" x) && (typecheck "bool" y)
	then (match (x,y) with
		(Bool(b),Bool(e)) -> Bool(b&&e))
	else failwith("Type error");;

let non x = if (typecheck "bool" x)
	then (match x with
		Bool(true) -> Bool(false) |
		Bool(false) -> Bool(true))
	else failwith("Type error");;

(*interprete*)
let rec eval (e : exp) (r : evT env) : evT = match e with
	Eint n -> Int n |
	Ebool b -> Bool b |
	IsZero a -> iszero (eval a r) |
	Den i -> applyenv r i |
	Eq(a, b) -> eq (eval a r) (eval b r) |
	Prod(a, b) -> prod (eval a r) (eval b r) |
	Sum(a, b) -> sum (eval a r) (eval b r) |
	Diff(a, b) -> diff (eval a r) (eval b r) |
	Minus a -> minus (eval a r) |
	And(a, b) -> et (eval a r) (eval b r) |
	Or(a, b) -> vel (eval a r) (eval b r) |
	Not a -> non (eval a r) |
	Ifthenelse(a, b, c) -> 
		let g = (eval a r) in
			if (typecheck "bool" g) 
				then (if g = Bool(true) then (eval b r) else (eval c r))
				else failwith ("nonboolean guard") |
	Let(i, e1, e2) -> eval e2 (bind r i (eval e1 r)) |
	Fun(i, a) -> FunVal(i, a, r) |
	FunCall(f, eArg) -> 
		let fClosure = (eval f r) in
			(match fClosure with
				FunVal(arg, fBody, fDecEnv) -> 
					eval fBody (bind fDecEnv arg (eval eArg r)) |
				RecFunVal(g, (arg, fBody, fDecEnv)) -> 
					let aVal = (eval eArg r) in
						let rEnv = (bind fDecEnv g fClosure) in
							let aEnv = (bind rEnv arg aVal) in
								eval fBody aEnv |
				_ -> failwith("non functional value")) |
        Letrec(f, funDef, letBody) ->
        		(match funDef with
            		Fun(i, fBody) -> let r1 = (bind r f (RecFunVal(f, (i, fBody, r)))) in
                         			                eval letBody r1 |
            		_ -> failwith("non functional def")) | 

	Etree(t) -> (match t with
		Empty -> Empty |
		Node(i,e1,lt,rt) -> let e2 = eval e1 r in
								let lt1 = eval (Etree(lt)) r in 
									let rt1 = eval (Etree(rt)) r in
										if((typecheckTree lt1 e2) & (typecheckTree rt1 e2))
											then Node(i,e2,lt1,rt1) 
											else failwith("not a valid tree") |
		_ -> failwith("not tree")) |

	ApplyOver(exf,ext) -> (match ext with 
			        Etree(t) -> (match t with 
			            Empty -> Empty |
			            Node(i,e1,lt,rt) -> let lt1 = eval (ApplyOver(exf,(Etree(lt)))) r in
			    		                        let rt1 = eval (ApplyOver(exf,(Etree(rt)))) r in
													let e2 = eval (FunCall(exf,e1)) r in
														if((typecheckTree lt1 e2) & (typecheckTree rt1 e2))
															then Node(i,e2,lt1,rt1)
															else failwith("not a valid tree")) |
		            _ -> failwith("not tree")) |

	Update(idl, exf, ext) -> (match (ext,idl) with
				     ( Etree(t) , [] ) -> failwith("empty list of ide") |
				     ( Etree(t) , h::[] ) -> (match t with
							          Empty -> Empty |
								  Node(i,e1,lt,rt) -> if(i = h) 
								      then let e2 = eval (FunCall(exf,e1)) r in
										let lt1 = eval (Etree(lt)) r in
											let rt1 = eval (Etree(rt)) r in
												if((typecheckTree lt1 e2) & (typecheckTree rt1 e2)) then
													Node(i,e2,lt1,rt1)
												else failwith("not a valid tree")
								      else eval (Etree(t)) r) |
				     ( Etree(t) , h1::h2::[] ) -> (match t with
								       Empty -> Empty |
								       Node(i,e1,lt,rt) -> if(h1 = i)
								then let e2 = eval e1 r in
									let lt1 = eval (Update(h2::[],exf,(Etree(lt)))) r in
										let rt1 = eval (Update(h2::[],exf,(Etree(rt)))) r in
											if((typecheckTree lt1 e2) & (typecheckTree rt1 e2)) then
												Node(i,e2,lt1,rt1)
											else failwith("not a valid tree")
								else eval (Etree(t)) r) |
				     (_,_) -> failwith("type error")) |

	Select(idl,exf, ext) -> match (ext,idl) with
 				    ( Etree(t) , [] ) -> Empty |
				    ( Etree(t) , h::tl ) -> (match t with
												Empty -> Empty |
												Node(i,e1,lt,rt) -> if(i = h) then
																		let f1 = eval (FunCall(exf,e1)) r in
																			if(typecheck "bool" f1) then
																				if(f1 = Bool(true)) then
																					eval (Etree(t)) r
																				else let lt1 = eval (Select(tl,exf,(Etree(lt)))) r in
																						let rt1 = eval (Select(tl,exf,(Etree(rt)))) r in
																							(match (lt1,rt1) with
																								| (Empty,Empty) -> Empty
																								| (Node(i,e1,lt2,rt2),Empty) -> Node(i,e1,lt2,rt2)
																								| (_,Node(i,e1,lt2,rt2)) -> Node(i,e1,lt2,rt2)
																								| (_,_) -> failwith("type error"))
																			else failwith("error: fun not return boolean")
																	else Empty) |
					(_,_) -> failwith("type error: not a tree or not list");;