import java.io.File;
import java.io.FileNotFoundException;
import java.util.*;

public class Applicazione {

    private DataCounter<String> d1 = new MyDataCounter_Hashtable<>(); //inizializzo il la collezione dati
    private String tmp; //stringa di appoggio
    private int words = 0, characters = 0, spazi = 0; //contatori
    private List<String> lst = new ArrayList<>(); //list di appoggio

    //classe per utilizzare la nozione di ordine
    private class MyComparator implements Comparator<String> {

	//metodo che restituisce un intero maggiore, minore o uguale a zero se e1 è maggiore, minore o uguale a e2
        public int compare(String e1, String e2) {

            if (d1.getCount(e1) < d1.getCount(e2)) return 1;
            if (d1.getCount(e1) > d1.getCount(e2)) return -1;
            else {
                if (e1.compareTo(e2) < 0) return -1;
                if (e1.compareTo(e2) > 0) return 1;
                else return 0;
            }
        }
    }

    //costruttore vuoto
    public Applicazione() {}

    //metodo per determinare il numoro di occorenze delle parole in un file di testo
    //a cui passo una stringa non vuota, che rappresenta il percorso in memoria del file
    public void applicazione(String s) {

        try {
            Scanner in1 = new Scanner(new File(s)); //apro il file di testo di cui si vuole contare le occorenze delle stringhe

            String[] spl;

            while (in1.hasNext()) { //leggo tutte le stringhe presenti nel file di testo, le normalizzo e le aggiungo alla collezione dati

                tmp = in1.next().toLowerCase();
                characters += tmp.length();
                spazi++;

                tmp = tmp.replaceAll("\\p{Punct}" , " ");
                spl = tmp.split("\\s+");

                for(String i : spl) {
                    d1.incCount(i);
                    words++;
                }
            }

            Iterator<String> it = d1.getIterator(); //creo un'iteratore sulla collezione dati
            while(it.hasNext()) { //aggiungo tutte le stringhe della collezione dati in un list di appoggio
                lst.add(it.next()); 
            }
            lst.sort(new MyComparator()); //ordino il list di appoggio con la nozione di ordine precedentemente creata

            int char_tot = spazi + characters; //stampo il numero di parole e caratteri presenti nel file di testo
            System.out.println("Numero di caratteri(con spazi): " + char_tot);
            System.out.println("Numero di caratteri(senza spazi): " + characters);
            System.out.println("Numero di parole: " + words + "\n");

            words = 1;
            for(String i : lst) { //stampo tutte le stringhe in ordine e con occorenza nel file di testo
                System.out.println(words + ". " + i + " = " + d1.getCount(i));
                words++;
             }
        }

	//catturo le eccezione se sollevate durante l'apertura del file 
        catch(FileNotFoundException e) {
            System.out.println("Non è stato possibile trovare alcun file     //OK\n");
        }

        catch(NullPointerException e) {
            System.out.println("Si deve inserire una stringa     //OK\n");
        }
    }
}