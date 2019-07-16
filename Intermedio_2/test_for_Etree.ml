(* test per Etree funzionante *)
let env0 = emptyenv Unbound in 
	let e1 = Etree(Node("prova1",Eint(1),
		Node("prova2",Eint(2),Empty,Empty),
			Node("prova3",Eint(3),Empty,Empty))) in
				eval e1 env0;;
				
(* test per Etree non funzionante : due nodi hanno una espressione di tipo diverso*)
let env0 = emptyenv Unbound in 
	let e1 = Etree(Node("prova1",Eint(1),
		Node("prova2",Ebool(true),Empty,Empty),
			Node("prova3",Eint(3),Empty,Empty))) in
				eval e1 env0;;
				
(* test per Etree non funzionante : come sotto albero sinistro metto un tipo Eint invece di un tipo Empty o Node*)
let env0 = emptyenv Unbound in
	let e1 = Etree(Node("prova1",Eint(1),
		Eint(78),
			Node("prova3",Eint(3),Empty,Empty))) in
				eval e1 env0;;
				
(* test per Etree non funzionante : come espressione del nodo passo un tipo Empty inveci di un tipo Eint o Ebool*)
let env0 = emptyenv Unbound in 
	let e1 = Etree(Node("prova1",Eint(1),
		Node("prova2",Ebool(true),Empty,Empty),
			Node("prova3",Empty,Empty,Empty))) in
				eval e1 env0;;