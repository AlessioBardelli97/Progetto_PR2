(* test per ApplyOver funzionante *)
let env0 = emptyenv Unbound in 
	let e1 = Fun("x",Sum(Den "x",Eint 1)) in 
		let e2 = Etree(Node("n1",Eint 5,Node("n2",Eint 4,Empty,Empty),Node("n3",Eint 5,Empty,Empty))) in
			let e3 = ApplyOver(e1,e2) in
				eval e3 env0;;
				
(* test per ApplyOver non funzionante : al posto di una funzione passo un espressione di tipo bool*)
let env0 = emptyenv Unbound in 
	let e1 = And(Ebool true,Ebool false) in 
		let e2 = Etree(Node("n1",Eint 5,Node("n2",Eint 4,Empty,Empty),Node("n3",Eint 5,Empty,Empty))) in
			let e3 = ApplyOver(e1,e2) in
				eval e3 env0;;
				
(* test per ApplyOver non funzionante : al posto di un albero passo una espressione di tipo funzione*)
let env0 = emptyenv Unbound in 
	let e1 = Fun("x",Sum(Den "x",Eint 1)) in 
		let e2 = Fun("x",Sum(Den "x",Eint 1)) in
			let e3 = ApplyOver(e1,e2) in
				eval e3 env0;;
				
(* test per ApplyOver non funzionante : passo come parametro una funzione che a sua volta prende come parametro un tipo diverso dal tipo dell'albero *)
let env0 = emptyenv Unbound in 
	let e1 = Fun("x",And(Den "x",Ebool true)) in 
		let e2 = Etree(Node("n1",Eint 5,Node("n2",Eint 4,Empty,Empty),Node("n3",Eint 5,Empty,Empty))) in
			let e3 = ApplyOver(e1,e2) in
				eval e3 env0;;