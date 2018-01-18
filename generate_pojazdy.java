import java.util.*;
import java.lang.*;
import java.io.*;

public class generate_pojazdy{
	public static void main(String[] args) {
		
		PrintWriter out;

		try{
			out =  new PrintWriter("insert_vehicles.txt");
		}
		catch(Exception e){
			return;
		}
		Random losowa = new Random();
		int ktory[] = new int[3];
		for(int i=0; i< 200; i++)
		{
			int model = losowa.nextInt(9) + 1;
			
			int zajezdnia = 1;
			if(ktory[zajezdnia -1] >75)
			{
				zajezdnia = losowa.nextInt(2) +2;
			}
			else zajezdnia = losowa.nextInt(3) +1; 
			
			ktory[zajezdnia-1]++;
			out.println("INSERT INTO Pojazdy VALUES (DEFAULT, "
			+ model + ", " + zajezdnia + ");");

		}
		out.close();
	}
}