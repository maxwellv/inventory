/* Update from Max, May 19 2014:
 * I've included this here for those who are curious as to what the
 * original program was. I haven't touched this code since 2010. To be honest,
 * I am surprised that the compiled version even runs at all, given that I
 * wrote and compiled it four years and four operating system versions ago.
 * Use at your own risk.
 */


/*******************************************************************************
 *																			   *
 *  Author: Maxwell Vance													   *
 *  Title: program3.cpp														   *
 *  Date: 3/16/10															   *
 *  Purpose: A program which tracks inventories of jewelry and calculates     *
 *			 prices for them.												   *
 *																			   *
 ******************************************************************************/


#include <iostream>
#include <iomanip>
#include <cmath>
#include <cstring>
#include <cstdlib>
#include <fstream>

using namespace std;

int loadjewelryItems(int[], float[], float[]);
int addjewelry(int, int[], float[], float[]);
void calculateTotals(int, int, int[], float[], float[], float[]);
float calculatePrice(float, float);
void writejewelryItems(int, int[], float[], float[]);

const int ARRAY_SIZE = 100;

int main()
{
	int input = 0;
	int goAgain = true;
	int init;
	int jewelryType[ARRAY_SIZE];
	for (init = 0; init < ARRAY_SIZE; init++)  // initializing all the arrays to zero
		jewelryType[init] = 0;
	float costMaterials[ARRAY_SIZE];
	for (init = 0; init < ARRAY_SIZE; init++)
		costMaterials[init] = 0;
	float numHours[ARRAY_SIZE];
	for (init = 0; init < ARRAY_SIZE; init++)
		numHours[init] = 0;
	float askingPrice[ARRAY_SIZE];
	for (init = 0; init < ARRAY_SIZE; init++)
		askingPrice[init] = 0;
	int numItems = 0;
	numItems = loadjewelryItems(jewelryType, costMaterials, numHours);
	
	do{
		cout << endl << "1. Add jewelry to inventory.";
		cout << endl << "2. Calculate totals for all necklaces.";
		cout << endl << "3. Calculate totals for all bracelets.";
		cout << endl << "4. Calculate totals for all earrings.";
		cout << endl << "5. Calculate totals for all jewelry in inventory.";
		cout << endl << "6. Quit.";
		cout << endl << "Enter a number from 1 to 6: ";
		cin >> input;
		switch (input){
			case 1: numItems = addjewelry(numItems, jewelryType, costMaterials, numHours);
				break;
			case 2: calculateTotals(1, numItems, jewelryType, costMaterials, numHours, askingPrice);  //necklaces only
				break;
			case 3: calculateTotals(2, numItems, jewelryType, costMaterials, numHours, askingPrice);  //bracelets only
				break;
			case 4: calculateTotals(3, numItems, jewelryType, costMaterials, numHours, askingPrice);  //earrings only
				break;
			case 5: calculateTotals(-1, numItems, jewelryType, costMaterials, numHours, askingPrice);  //everything
				break;
			case 6:
				goAgain = false;
				break;
			default: cout << "Invalid entry.";
				break;
		}		
	}while(goAgain);
	writejewelryItems(numItems, jewelryType, costMaterials, numHours);
	cout << "Thank you for using this program." << endl;
	return 0;
}

int loadjewelryItems(int type[], float materials[], float hours[])
{
	int items = 0;  // this will be used as both an increment variable and as the return value (items - 1 for the return)
	char line[20];
	ifstream jewelry;
	
	cout << endl << "Welcome to the jewelry inventory management program.";
	jewelry.open("jewelry.txt");
	if (jewelry.fail())
	{
		cout << endl << "Note: Either jewelry.txt does not exist, or it could not be opened. No jewelry will be loaded into inventory." << endl;
		return 0;
	}
	else
	{
		while (jewelry >> line)
		{
			if (items > 100) // Suppose someone manually put more than 100 items in jewelry.txt?
			{
				cout << endl << "Only the first 100 items in jewelry.txt were loaded into inventory." << endl;
				return 100;
			}	
			else if (!strcmp("NECKLACE", line))  //is a necklace
			{
				type[items] = 1;
				jewelry >> line;
				materials[items] = atof(line);
				jewelry >> line;
				hours[items] = atof(line);
				items++;
			}
			else if (!strcmp("BRACELET", line)) //is a bracelet
			{	
				type[items] = 2;
				jewelry >> line;
				materials[items] = atof(line);
				jewelry >> line;
				hours[items] = atof(line);
				items++;
			}
			else if (!strcmp("EARRINGS", line))  //is earrings
			{
				type[items] = 3;
				jewelry >> line;
				materials[items] = atof(line);
				jewelry >> line;
				hours[items] = atof(line);
				items++;
			}
		}	
	}
	return items - 1;
}

void calculateTotals(int calcType, int items, int jewelryType[], float costMaterials[], float numHours[], float askingPrice[])
{
	int count;
	float matTotal;    // These two vars are used to store the 
	float priceTotal;  // totals to be displayed after each item.
	if (calcType == 1)  //calculate necklaces
	{
		matTotal = 0;
		priceTotal = 0;
		cout << endl << endl << "Total Necklaces in Inventory:" << endl;
		cout << setw(20) << left << "TYPE" << setw(20) << right << "MATERIALS COST" << setw(20) << right << "LABOR HOURS" << setw(20) << right << "ASKING PRICE";
		for (count = 0; count <= items; count++)
		{
			if (jewelryType[count] == 1)
			{	
				askingPrice[count] = calculatePrice(costMaterials[count], numHours[count]);
				cout << endl << setw(20) << left << "Necklace" << setw(20) << setprecision(4) << showpoint << right << costMaterials[count] << setw(20) << setprecision(4) << showpoint << numHours[count] << setw(20) << setprecision(4) << showpoint << askingPrice[count];
				matTotal += costMaterials[count];
				priceTotal += askingPrice[count];
			}
		}	
	}
	else if (calcType == 2)  //calculate bracelets
	{
		matTotal = 0;
		priceTotal = 0;
		cout << endl << endl << "Total Bracelets in Inventory:" << endl;
		cout << setw(20) << left << "TYPE" << setw(20) << right << "MATERIALS COST" << setw(20) << right << "LABOR HOURS" << setw(20) << right << "ASKING PRICE";
		for (count = 0; count <= items; count++)
		{
			if (jewelryType[count] == 2)
			{	
				askingPrice[count] = calculatePrice(costMaterials[count], numHours[count]);
				cout << endl << setw(20) << left << "Bracelet" << setw(20) << setprecision(4) << showpoint << right << costMaterials[count] << setw(20) << setprecision(4) << showpoint << numHours[count] << setw(20) << setprecision(4) << showpoint << askingPrice[count];
				matTotal += costMaterials[count];
				priceTotal += askingPrice[count];
			}
		}	
	}
	else if (calcType == 3)  //calculate earrings
	{
		matTotal = 0;
		priceTotal = 0;
		cout << endl << endl << "Total Earrings in Inventory:" << endl;
		cout << setw(20) << left << "TYPE" << setw(20) << right << "MATERIALS COST" << setw(20) << right << "LABOR HOURS" << setw(20) << right << "ASKING PRICE";
		for (count = 0; count <= items; count++)
		{
			if (jewelryType[count] == 3)
			{	
				askingPrice[count] = calculatePrice(costMaterials[count], numHours[count]);
				cout << endl << setw(20) << left << "Earrings" << setw(20) << setprecision(4) << showpoint << right << costMaterials[count] << setw(20) << setprecision(4) << showpoint << numHours[count] << setw(20) << setprecision(4) << showpoint << askingPrice[count];
				matTotal += costMaterials[count];
				priceTotal += askingPrice[count];
			}
		}	
	}
	else if (calcType == -1)  //calculate everything
	{
		matTotal = 0;
		priceTotal = 0;
		cout << endl << endl << "Total Pieces of jewelry in Inventory:" << endl;
		cout << setw(20) << right << "TYPE" << setw(20) << right << "MATERIALS COST" << setw(20) << right << "LABOR HOURS" << setw(20) << right << "ASKING PRICE";
		for (count = 0; count <= items; count++)
		{
			askingPrice[count] = calculatePrice(costMaterials[count], numHours[count]);
			if (jewelryType[count] == 1)
				cout << endl << setw(20) << left << "Necklace" << setw(20) << setprecision(4) << showpoint << right << costMaterials[count] << setw(20) << setprecision(4) << showpoint << numHours[count] << setw(20) << setprecision(4) << showpoint << askingPrice[count];
			else if (jewelryType[count] == 2)
				cout << endl << setw(20) << left << "Bracelet" << setw(20) << setprecision(4) << showpoint << right << costMaterials[count] << setw(20) << setprecision(4) << showpoint << numHours[count] << setw(20) << setprecision(4) << showpoint << askingPrice[count];
			else if (jewelryType[count] == 3)
				cout << endl << setw(20) << left << "Earrings" << setw(20) << setprecision(4) << showpoint << right << costMaterials[count] << setw(20) << setprecision(4) << showpoint << numHours[count] << setw(20) << setprecision(4) << showpoint << askingPrice[count];
			matTotal += costMaterials[count];
			priceTotal += askingPrice[count];
		}	
	}
	cout << endl << endl << setw(19) << left << "TOTALS:" << "$" << setw(20) << setprecision(4) << right << showpoint << matTotal << setw(21) << "$" << setw(19) << setprecision(4) << showpoint << priceTotal << endl;
}	

int addjewelry(int items, int jewelryType[], float costMaterials[], float numHours[])	
{
	int newEntry = items; //this will be used to specify which field in the array to use, and the new number of items (to be returned to main)
	if (newEntry > ARRAY_SIZE)  //check to see if we would go out of bounds
	{
		cout << endl << "The maximum number of items that can be entered is " << ARRAY_SIZE << ".";
		return 100;
	}	
	cout << endl << "Enter the jewelry type (1 for necklaces, 2 for bracelets, or 3 for earrings): ";
	cin >> jewelryType[newEntry];
	cout << endl << "Enter the materials cost for this piece of jewelry: ";
	cin >> costMaterials[newEntry];
	cout << endl << "Enter the hours worked on this piece of jewelry: ";
	cin >> numHours[newEntry];
	cout << endl << "SUCCESS. A jewelry with type " << jewelryType[newEntry] << ", materials cost " << costMaterials[newEntry] << ", and hours worked " << numHours[newEntry] << " was entered into memory." << endl;
	return newEntry++;
}
	
float calculatePrice(float cost, float hours)
{
	return ((hours * 10) + cost);
}	

void writejewelryItems(int items, int type[], float materials[], float hours[])	
{
	ofstream outjewelry;
	outjewelry.open("jewelry.txt");
	if (outjewelry.fail())
	{
		cout << endl << "Error in opening jewelry.txt.";
		return;
	}
	int outCount;
	for (outCount = 0; outCount <= items; outCount++)
	{
		if (type[outCount] == 1)
			outjewelry << "NECKLACE\r\n";
		else if (type[outCount] == 2)
			outjewelry << "BRACELET\r\n";
		else if (type[outCount] == 3)
			outjewelry << "EARRINGS\r\n";
		outjewelry << materials[outCount] << "\r\n";
		outjewelry << hours[outCount] << "\r\n";
	}
}
