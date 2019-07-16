import java.util.*;

public class Test_per_implementazione {     //classe per testare l'implementazione di DataCounter

    public static void main(String[] args)  {

        Map<String,Integer> m1 = new TreeMap<>();

        m1.put("ciao1",-3);
        try { DataCounter<String> d2 = new MyDataCounter_TreeMap<>(m1); }       //inizializzo una DataCounter con valori che
        catch(IllegalArgumentException e) { System.out.println("//OK_1"); }     //non rispettano la clausola requires

        m1.put("ciao1",null);
        try { DataCounter<String> d2 = new MyDataCounter_TreeMap<>(m1); }       //inizializzo una DataCounter con valori che
        catch(NullPointerException e) { System.out.println("//OK_2"); }         //non rispettano la clausola requires

        Map<String,Integer> m2 = new Hashtable<>();
        m2.put("pippolo",2);
        m2.put("plutolo",5);
        DataCounter<String> d1 = new MyDataCounter_TreeMap<>(m2);      //inizializzo d1 con l'oggetto m2

        Iterator<String> it = d1.getIterator();     //test iteratore
        while(it.hasNext()) {
            System.out.println(it.next());
        }

        assert d1.getSize() == 2;   //test per getSize

        d1.incCount("plutolo");     //test per incCount
        assert d1.getCount("plutolo") == 6;     //test per getCount

    }
}