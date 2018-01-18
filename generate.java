import java.util.*;
import java.lang.*;
import java.io.*;

public class generate{
	public static void main(String[] args) {
		String[] names = {"Jan", "Adam", "Karol", "Michał", "Kamil", "Karolina",
		"Katarzyna", "Agnieszka", "Magdalena", "Piotr", "Justyna", "Wojciech", "Jakub",
		"Krzysztof", "Aleksandra", "Paweł", "Andrzej", "Maciej", "Grzegorz", "Ryszard",
		"Joanna", "Małgorzata", "Danuta", "Jolanta", "Zofia", "Marek", "Robert",
		"Gabryjel", "Mateusz", "Sebastian", "Anna", "Adrianna", "Szymon", "Lukasz", 
		"Tomasz", "Krystian", "Dagmara", "Dominika", "Jagoda", "Amanda", "Janusz",
		 "Aleksander", "Dominik", "Krystyna", "Grażyna", "Basia"};
		
		String[] surnames = {"Nowak", "Kowalski", "Wiśniewski", "Wójcik", "Kowalczyk",
		"Kamiński", "Lewandowski", "Zieliński", "Szymański", "Woźniak", "Dąbrowski",
		"Kozłowski", "Jankowski", "Mazur", "Wojciechowski", "Kwiatkowski", "Krawczyk",
		"Kaczmarek", "Piotrkowski", "Grabowski", "Zając", "Pawłowski", "Michalski",
		"Król", "Wieczorek", "Jabłoński", "Wróbel", "Nowakowski", "Majewski", "Olszewski",
		"Stępień", "Malinowski", "Jaworski", "Adamczyk", "Dudek", "Nowicki", "Pawlak",
		"Górski", "Witkowski", "Walczak", "Sikora", "Baran", "Rutkowski", "Michalak",
		"Szewczyk", "Ostrowski", "Tomaszewski", "Pietrzak", "Zalewski", "Wróblewski",
		"Marciniak", "Jaśiński", "Zawadzki", "Bąk", "Jakubowski", "Sadowski", "Duda",
		"Włodarczyk", "Wilk", "Chmielewski", "Borkowski", "Sokołowski", "Szczepański",
		"Sawicki", "Kucharski", "Lis", "Maciejewski", "Kubiak", "Kalinowski", "Mazurek",
		"Wysocki", "Kołodziej", "Kaźmierczak", "Czarnecki", "Sobczak", "Konieczny", 
		"Urbański", "Głowacki", "Wasilewski","Sikorski" };
		PrintWriter out;

		try{
			out =  new PrintWriter("insert_names.txt");
		}
		catch(Exception e){
			return;
		}
		Random losowa = new Random();

		for(int i=0; i< 200; i++)
		{
			String name = names[losowa.nextInt(names.length)];
			String surname = surnames[losowa.nextInt(surnames.length)];
			if(surname.charAt(surname.length() -1) == 'i' &&
			   name.charAt(name.length() - 1) == 'a')
				surname = surname.substring(0, surname.length()-1) + "a";
			out.println("INSERT INTO Pracownicy VALUES (DEFAULT, '"
			+ name + "', '" + surname + "', 'Kierowca', 1, 0);");

		}
		out.close();
	}
}