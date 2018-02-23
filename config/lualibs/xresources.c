/*
   XResources LUA interface functions
   v0.1 
*/

#include <stdio.h>
#include <stdlib.h>
// xcb includes
#include <xcb/xcb.h>
#include <xcb/xcb_xrm.h>
// Lua API includes
#include <lua.h>

// defines
#include "xresources.h"

// global static variables
static xcb_connection_t *x_connection = NULL;
static xcb_xrm_database_t *xrm_database = NULL;

// connect to the undelying Xorg server and get a connection
// handler object.
xcb_connection_t *open_connection(const char *displayname, int *snumber) {
  // open connection to the X Display Manager
  xcb_connection_t *x_conn = xcb_connect(displayname, snumber);

  // check connection health...
  if (ISNULL(x_conn) || xcb_connection_has_error(x_conn)) {
    return NULL;
  }

  // ok return pointer to xcb_connection
  printf("x_connection_t *x_connection=0x%X\n", x_conn);
  return (xcb_connection_t *)x_conn;
}

// query the X server for the current loaded Xresources database
xcb_xrm_database_t *get_xrdb(xcb_connection_t *x_conn) {
  // connection is ok, return the database object
  if (ISNOTNULL(x_conn) || !xcb_connection_has_error(x_conn)) {
    return (xcb_xrm_database_t *)xcb_xrm_database_from_default(x_conn);
  }

  // fail.
  return ECONNISNULL;
}

// close xrdb
int free_xrdb(xcb_xrm_database_t *xrdb) {
  // destroy xrdb object pointer if it is still allocated
  if ISNOTNULL(xrdb) {
    printf("freeing xrdb database pointer=0x%X\n", xrdb);
    xcb_xrm_database_free(xrdb);
    return ECONDITIONOK;
  }

  // fail
  return EFREEFAILED;
}

// close a live X11 connection
int close_connection(xcb_connection_t *x_conn) {
  // close connection if connection handler is live
  if ISNOTNULL(x_conn) {
    printf("closing connection to X11\n");
    xcb_disconnect(x_conn);
    return ECONDITIONOK;
  }

  // return 1, connection is already closed or no connection at all
  // has been previously made
  return ECONDITIONFAIL;
}

// Module functions
static int xrdb_get_resource_string(lua_State *L) {
  // connect to X server
  x_connection = open_connection(NULL, NULL);
  if ISNULL(x_connection) {
    printf("Failed to open connection to X11\n");
    return 0;
  }

  // get pointer to the current Xrdb
  xrm_database = get_xrdb(x_connection);
  if ISNULL(xrm_database) {
    printf("Failed to get pointer to the Xresources Database\n");
    close_connection(x_connection);
    return 0;
  }

  // retrieve resource value from database
  char *xresource_value = NULL;
  char *xresource_name = NULL;
  // get the wanted rescurce name from the lua stack
  if (!lua_isnoneornil(L, -1) && lua_isstring(L, -1)) {
    xresource_name = lua_tostring(L, -1);
    printf("value from Lua C stack = %s\n", xresource_name);

    // query the resource manager
    xcb_xrm_resource_get_string(xrm_database, xresource_name, NULL, &xresource_value);
    printf("%s=%s\n", xresource_name, xresource_value);
  }

  // free the Xrdb instance
  free_xrdb(xrm_database);

  // close connection to X server
  close_connection(x_connection);

  // return value
  if ISNOTNULL(xresource_value) {
    lua_pushstring(L, xresource_value);
    free(xresource_value);
    return 1;
  }

  // no resource found
  return 0;
}

/*
 *  module initialization function
 *  This one maps lua function names to C function names
 */
int luaopen_xresources(lua_State *L){

  // Xresources enumerate
  lua_register(L, "xrdb_get_resource_string", xrdb_get_resource_string);
  
  // ok module initialized
  return 0;
}

