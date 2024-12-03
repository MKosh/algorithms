import edu.princeton.cs.algs4.StdIn;
import edu.princeton.cs.algs4.StdOut;
import edu.princeton.cs.algs4.StdRandom;

public class RandomWord {

    public static void main(String[] args) {
      String word = "";
      String champ = "";
      int i = 0;
      while (!StdIn.isEmpty()) {
        i = i + 1;
        word = StdIn.readString();
        if (StdRandom.bernoulli(1.0/i)) {
          champ = word;
        }
      }
      System.out.println(champ);
    }

}
