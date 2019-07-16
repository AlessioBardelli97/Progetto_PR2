(* test per Update funzionante *)
let env0 = emptyenv Unbound in 
	let e1 = Etree(Node("n1",Eint 5,Node("n2",Eint 4,Empty,Empty),Node("n3",Eint 5,Empty,Empty))) in
		let e2 = Fun("x",Sum(Den "x",Eint 1)) in 
			let e3 = Update(["n1";"n2"],e2,e1) in
				eval e3 env0;;
				
(* test per Update non funzionante : passo come parametro una espressione di tipo Eint invece che una funzione *)
let env0 = emptyenv Unbound in 
	let e1 = Etree(Node("n1",Eint 5,Node("n2",Eint 4,Empty,Empty),Node("n3",Eint 5,Empty,Empty))) in
		let e2 = Eint(8) in 
			let e3 = Update(["n1";"n2"],e2,e1) in
				eval e3 env0;;
				
(* test per Update non funzionante :  passo come parametro una espressione di tipo Eint invece che un albero *)
let env0 = emptyenv Unbound in 
	let e1 = Eint(9) in
		let e2 = Fun("x",Sum(Den "x",Eint 1)) in 
			let e3 = Update(["n1";"n2"],e2,e1) in
				eval e3 env0;;
				
(* test per Update non funzionante : la funzione che passo come parametro prende a sua volta un parametro di tipo diverso dal tipo dell'albero *)
let env0 = emptyenv Unbound in 
	let e1 = Etree(Node("n1",Eint 5,Node("n2",Eint 4,Empty,Empty),Node("n3",Eint 5,Empty,Empty))) in
		let e2 = Fun("x",Or(Den "x",Ebool(false))) in 
			let e3 = Update(["n1";"n2"],e2,e1) in
				eval e3 env0;;