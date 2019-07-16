import java.util.Iterator;

public interface DataCounter<E> {

        /**
        OVERVIEW: collezione di elementi diversi da null di tipo E a cui è assocato un intero positivo.
                  La collezione non ammette elementi di tipo E duplicati, ha dimensione size € N

        TYPICAL ELEMENT: { < n_1 , el_1 > ,......, < n_size , el_size > } insieme di coppie
                         formate da un elemento di tipo E e un intero positivo tale che
                         for all i,j. i,j € [1,size] ==> n_i != n_j
                         for all i. i € [1,size] ==> el_i > 0
        */

        // incrementa il valore associato all’elemento data di tipo E
        /**
           REQUIRES: data != null && this != null
           MODIFIES: this
           EFFECTS: incrementa il valora associato a data se data appartiene a this altrimenti inserisce data a this e gli associa 1
           THROWS: NullPointerException se date = null || this == null (unchecked)
         */
        public void incCount(E data) throws NullPointerException;

        // restituisce il numero degli elementi presenti nella collezione
        /**
           REQUIRES: this != null
           MODIFIES: none
           EFFECTS: restituisce il numero degli elementi presenti nella collezione
           THROWS: NullPointerException se this é null
         */
        public int getSize() throws NullPointerException;

        // restituisce il valore corrente associato al parametro data e 0 se data non appartiene alla collezione
        /**
           REQUIRES: data != null && this != null
           MODIFIES: none
           EFFECTS: restituisce l'intero associato al parametro data se questo appartiene a this, 0 altrimenti
           THROWS: NullPointerException se this = null ||  data = null (unchecked)
         */
        public int getCount(E data) throws NullPointerException;

        // restituisce un iteratore (senza remove) per la collezione
        /**
           REQUIRES: this != null
           MODIFIES: none
           EFFECTS: restituisce un iteratore (senza remove) per la collezione
           THROWS: NullPointerException se this = null (unchecked)
         */
        public Iterator<E> getIterator();
}