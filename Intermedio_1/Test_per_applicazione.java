import java.util.*;

public class Test_per_applicazione {

    public static void main(String[] args) {

	Scanner in = new Scanner(System.in);

	Applicazione app = new Applicazione(); //dichiaro il nuovo oggeto di tipo Applicaione

	app.applicazione("ttt"); //passo ad applicazione un file che non esiste

        app.applicazione(null); //passo ad applicazione una stringa nulla

	System.out.println("inserire 1 per testare prova1.txt \ninserire 2 per testare prova2.txt \ninserire 3 per testare prova3.txt \ninserire 4 per testare prova4.txt \ninserire 5 per testare prova5.txt \ninserire 6 per testare prova6.txt \ninserire 7 per contare le occorenze di un altro file \n");

	int i = in.nextInt();
	
	switch (i) {
		
		case 1:	app.applicazione("prova1.txt"); 
		break;
				
		case 2: app.applicazione("prova2.txt");
		break;
			
		case 3: app.applicazione("prova3.txt");
		break;
			
		case 4: app.applicazione("prova4.txt");
		break;
			
		case 5: app.applicazione("prova5.txt");
		break;
			
		case 6: app.applicazione("prova6.txt");
		break;

		case 7: app.applicazione(in.next()); //devo inserire da tastiera il path del file di testo di cui voglio calcolare le occorrenze 
		break;
	}

	       
    }
}
