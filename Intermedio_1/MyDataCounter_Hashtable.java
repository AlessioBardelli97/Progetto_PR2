import java.util.*;

public class MyDataCounter_Hashtable<E> implements DataCounter<E> {

    private Hashtable<E,Integer> ht;

    /**
       FUNZIONE DI ASTRAZIONE ht : E -> N \ {0} && ht(e) = i
       INVARIANTE DI RAPPRESENTAZIONE (ht != null) && (for all e. e € E && e € ht ==> ht(e) != null && ht(e) > 0)
                                      && (for all e,g . e,g € E && e,g € ht ==> e != g)
    */


    //primo costruttore
    /**
       REQUIRES: (tmp != null) && (for all e. e € E ==> tmp(e) != null && tmp(e) > 0)
       MODIFIES: ht
       EFFECTS: inizializza ht con la mappatura di tmp
       THROWS: NullPointerException if tmp == null || tmp(e) == null , IllegalArgumentException if tmp(e) <= 0 (entrambe unchecked)
    */
    public MyDataCounter_Hashtable(Map<? extends E,Integer> tmp) throws IllegalArgumentException,NullPointerException {

        if (tmp == null) throw new NullPointerException();

        ht = new Hashtable<>();
        Integer i;

       Set<? extends E> s1 = tmp.keySet();
       Collection<Integer> c1 = tmp.values();

        Iterator<? extends E> it1 = s1.iterator();
        Iterator<Integer> it2 = c1.iterator();

        while(it1.hasNext()) {

            i = it2.next();
            if(i <= 0) throw new IllegalArgumentException();

            ht.put(it1.next(),i);
        }
    }

    //secondo costruttore
    /**
       REQUIRES: none
       MODIFIES: ht
       EFFECTS: inzializza ht a vuoto
       THROWS: none
    */
    public MyDataCounter_Hashtable() {
        ht = new Hashtable<>(0);
    }

    // incrementa il valore associato all’elemento data di tipo E
    /**
       REQUIRES: data != null && ht != null
       MODIFIES: ht
       EFFECTS: if(data € ht) then ht(data) += 1 else new[ < data , 1 > ] -> ht
       THROWS: NullPointerException if date = null || ht == null (unchecked)
    */
    public void incCount(E data) {

        if(data == null || ht == null) throw new NullPointerException();

        if(!ht.containsKey(data)) ht.put(data,1);
        else ht.put(data,ht.get(data)+1);
    }

    // restituisce il numero degli elementi presenti nella collezione
    /**
       REQUIRES: ht != null
       MODIFIES: none
       EFFECTS: restituisce ht.size()
       THROWS: NullPointerException if ht == null (unchecked)
    */
    public int getSize() {

        if(ht == null) throw new NullPointerException();

        return ht.size();
    }

    // restituisce il valore corrente associato al parametro data e 0 se data non appartiene alla collezione
    /**
       REQUIRES: data != null && ht != null
       MODIFIES: none
       EFFECTS: if (data € ht) then restituisce ht(data)  else restituisce 0
       THROWS: NullPointerException se data == null || ht == null (uncheched)
    */
    public int getCount(E data) {

        if(ht == null || data == null) throw new NullPointerException();

        if(ht.containsKey(data)) return ht.get(data);
        else return 0;

    }

    // restituisce un iteratore (senza remove) per la collezione
    /**
       REQUIRES: ht != null
       MODIFIES: none
       EFFECTS: restituisce un iteratore (senza remove) per la collezione
       THROWS: NullPointerException if ht = null (unchecked)
    */
    public Iterator<E> getIterator() {

        if(ht == null) throw new NullPointerException();

        return new Itr();
    }

    private class Itr implements Iterator<E> {

        private Set<E> s;
        private List<E> lst;
        private int i;

        private Itr() {
            s = ht.keySet();
            lst = new ArrayList<>();
            lst.addAll(s);
            i = -1;
        }

        public boolean hasNext() {
            return i < lst.size() - 1;
        }

        public E next() {
            i++;
            if(i >= lst.size()) throw new NoSuchElementException();
            return lst.get(i);
        }
    }
}