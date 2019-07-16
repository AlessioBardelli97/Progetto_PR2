import java.util.*;

public class MyDataCounter_TreeMap<E> implements DataCounter<E> {

    private TreeMap<E,Integer> tm;

    /**
       FUNZIONE DI ASTRAZIONE tm : E -> N \ {0} && tm(e) = i
       INVARIANTE DI RAPPRESENTAZIONE (tm != null) && (for all e. e € E && e € tm ==> tm(e) != null && tm(e) > 0)
                                      && (for all e,g . e,g € E && e,g € tm ==> e != g)
    */



    //primo costruttore
    /**
      REQUIRES: tmp != null && (for all e. e € E ==> tmp(e) > 0 && tmp(e) != null)
      MODIFIES: tm
      EFFECTS: inizializza tm con la mappatura di tmp
      THROWS: NullPointerException if tmp == null || tmp(e) == null , IllegalArgumentException if tmp(e) <= 0 (entrambe unchecked)
   */
    public MyDataCounter_TreeMap(Map<? extends E,Integer> tmp) throws NullPointerException,IllegalArgumentException {

        if(tmp == null) throw new NullPointerException();

        tm = new TreeMap<>();
        Integer i;

        Set<? extends E> s1 = tmp.keySet();
        Collection<Integer> c1 = tmp.values();

        Iterator<? extends E> it1 = s1.iterator();
        Iterator<Integer> it2 = c1.iterator();

        while(it1.hasNext()) {

            i = it2.next();
            if(i == null) throw new NullPointerException();
            if(i <= 0) throw new IllegalArgumentException();

            tm.put(it1.next(),i);
        }

    }

    //secondo costruttore
    /**
       REQUIRES: none
       MODIFIES: tm
       EFFECTS: inizializza tm a vuoto
       THROWS: none
    */
    public MyDataCounter_TreeMap() {

        tm = new TreeMap<>();
    }

    // incrementa il valore associato all’elemento data di tipo E
    /**
       REQUIRES: data != null && tm != null
       MODIFIES: tm
       EFFECTS: if(data € tm) then tm(data) += 1 else new[ < data , 1 > ] -> tm
       THROWS: NullPointerException if date = null || tm == null (unchecked)
    */
    public void incCount(E data) {

        if(data == null || tm == null) throw new NullPointerException();

        if(!tm.containsKey(data)) tm.put(data,1);
        else tm.put(data,tm.get(data)+1);
    }

    // restituisce il numero degli elementi presenti nella collezione
    /**
       REQUIRES: tm != null
       MODIFIES: none
       EFFECTS: restituisce tm.size()
       THROWS: NullPointerException if tm == null (unchecked)
    */
    public int getSize() {

        if(tm == null) throw new NullPointerException();

        return tm.size();
    }

    // restituisce il valore corrente associato al parametro data e 0 se data non appartiene alla collezione
    /**
       REQUIRES: data != null && tm != null
       MODIFIES: none
       EFFECTS: if (data € tm) then restituisce tm(data)  else restituisce 0
       THROWS: NullPointerException se data == null || tm == null (uncheched)
    */
    public int getCount(E data) {

        if(data == null || tm == null) throw new NullPointerException();

        if(tm.containsKey(data)) return tm.get(data);
        else return 0;
    }

    // restituisce un iteratore (senza remove) per la collezione
    /**
       REQUIRES: tm != null
       MODIFIES: none
       EFFECTS: restituisce un iteratore (senza remove) per la collezione
       THROWS: NullPointerException if tm = null (unchecked)
    */
    public Iterator<E> getIterator() {

        if(tm == null) throw new NullPointerException();

        return new itr();
    }

    private class itr implements Iterator<E> {

        private Set<E> s;
        private List<E> lst;
        private int i;

        private itr() {
            s = tm.keySet();
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