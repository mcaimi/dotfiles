/*
 * X Resources LUA interface
 * v0.1
 */

// error definitions
#define ECONDITIONOK  0
#define ECONDITIONFAIL -1
#define EQUERYFAILED  -2
#define EFREEFAILED   -3
#define ECONNISNULL   NULL

// macros
#define ISNULL(variable)  (variable == NULL)
#define ISNOTNULL(variable)  (variable != NULL)
