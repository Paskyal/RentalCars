permissionset 50100 "Rental Permission"
{
    Assignable = true;
    Permissions =
        tabledata "Rental Order" = RIMD,
        tabledata "Rental Order Line" = RIMD,
        tabledata "Rental Posted Order" = RIMD,
        tabledata "Rental Posted Order Line" = RIMD,
        tabledata "Rental Setup" = RIMD;
}