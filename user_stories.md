## Showing the menu

As anyone using the application, I should be able to actually see the menu so that I can actually do anything with the application.

Acceptance criteria:

*If the user selects 1 then it goes to the jewelry entry method.
*If the user selects 2, 3, or 4 then it displays the totals of necklaces, bracelets, or earrings, respectively.
*If the user selects 5 then it shows the totals for all three kinds of jewelery.
*If the user selects 6 then it quits the application.
*If the user selects an invalid operation then it re-displays the menu.

Usage:
  - ./inventory
  Welcome to the jewelry inventory management program.
  1. Add jewelry to inventory.
  2. Calculate totals for all necklaces.
  3. Calculate totals for all bracelets.
  4. Calculate totals for all earrings.
  5. Calculate totals for all jewelry in inventory.
  6. Quit.
  Enter a number from 1 to 6: 

## Adding jewelry

As anyone using the application, I should be able to add jewelry so that I can see it later.

Acceptance criteria:

*Jewelry added must be saved to the database
*Adding jewelry will abort if the user enters a non-numeric value for the jewelry type, material cost, or number of hours worked on the jewelry
*After adding or failing to add jewelry, it goes back to the main menu

Usage (continuing from above)
  - 1
  Enter the jewelry type (1 for necklaces, 2 for bracelets, or 3 for earrings):
  - 2
  Enter the materials cost for this piece of jewelry: 
  - 1
  Enter the hours worked on this piece of jewelry:
  - 1
  SUCCESS. A jewelry with type 2, materials cost 1, and hours worked 1 was entered into memory.

  1. Add jewelry to inventory.
  2. Calculate totals for all necklaces.
  3. Calculate totals for all bracelets.
  4. Calculate totals for all earrings.
  5. Calculate totals for all jewelry in inventory.
  6. Quit.
  Enter a number from 1 to 6:

## Viewing totals

As anyone using the application, I should be able to see the jewelry that I previously added.

Acceptance criteria:

*It displays all the jewelry under the selected category, or ALL the jewelry if the user selects 5
*It then goes back to the main menu

Usage (continuing from above):
  - 5
  Total Pieces of jewelry in Inventory:
                  TYPE      MATERIALS COST         LABOR HOURS        ASKING PRICE
  Bracelet                           1.000               1.000               11.00

  TOTALS:            $               1.000                    $              11.00

  1. Add jewelry to inventory.
  2. Calculate totals for all necklaces.
  3. Calculate totals for all bracelets.
  4. Calculate totals for all earrings.
  5. Calculate totals for all jewelry in inventory.
  6. Quit.
  Enter a number from 1 to 6:
