import java.util.*;
import java.lang.*;
import java.io.*;

public class generate_kierowcy{
	public static void main(String[] args) {
		
		PrintWriter out;

		try{
			out =  new PrintWriter("insert_kierowcy.txt");
		}
		catch(Exception e){
			return;
		}
		Random losowa = new Random();
		int pojazdy[] = new int[200];
		for(int i=201; i< 403; i++)
		{
			String napis = "false, true";
			int wylosowane = losowa.nextInt(3);
			if(wylosowane == 2)
			{
				napis = "true, true";
			}
			else if(wylosowane == 1)
			{
				napis = "true, false";
			}
			
			int mniej = i-1;
			out.println("INSERT INTO Kierowcy VALUES ("
			+ i + ", " + "NULL" +  ", " + napis + ");");

		}
		out.close();
	}
}