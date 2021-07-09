permissionset 50100 "MyPermissionSet"
{
    Assignable = true;
    Permissions =
        tabledata "Rental Order" = RIMD,
        tabledata "Rental Order Line" = RIMD,
        tabledata "Rental Setup" = RIMD;
}