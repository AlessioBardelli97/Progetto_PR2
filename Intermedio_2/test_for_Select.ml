(* test per Select funzionante *)
let env0 = emptyenv Unbound in 
	let e1 = Fun("x",IsZero(Den "x")) in
		let e2 = Etree(Node("n1",Eint 5,Node("n2",Eint 5,Node("n3",Eint 0,Empty,Empty),Empty),Node("n2",Eint 0,Empty,Node("n3",Eint 67,Empty,Empty)))) in
			let e3 = Select(["n1";"n2"],e1,e2) in 
				eval e3 env0;;
				
(* test per Select non funzionante : al posto di una funzione passo una espressioe di tipo int *)
let env0 = emptyenv Unbound in 
	let e1 = Diff(Eint 5,Eint 1) in
		let e2 = Etree(Node("n1",Eint 5,Node("n2",Eint 5,Node("n3",Eint 0,Empty,Empty),Empty),Node("n2",Eint 0,Empty,Node("n3",Eint 67,Empty,Empty)))) in
			let e3 = Select(["n1";"n2"],e1,e2) in 
				eval e3 env0;;
				
(* test per Select non funzionante : la funzione che passo come parametro non restituisce un tipo bool *)
let env0 = emptyenv Unbound in 
	let e1 = Fun("x",Prod(Den "x",Eint 3)) in
		let e2 = Etree(Node("n1",Eint 5,Node("n2",Eint 5,Node("n3",Eint 0,Empty,Empty),Empty),Node("n2",Eint 0,Empty,Node("n3",Eint 67,Empty,Empty)))) in
			let e3 = Select(["n1";"n2"],e1,e2) in 
				eval e3 env0;;
				
(* test per Select non funzionante : al posto di un albero passo un'espressione di tipo funzione *)
let env0 = emptyenv Unbound in 
	let e1 = Fun("x",IsZero(Den "x")) in
		let e2 = Fun("x",Prod(Den "x",Eint 3)) in
			let e3 = Select(["n1";"n2"],e1,e2) in 
				eval e3 env0;;