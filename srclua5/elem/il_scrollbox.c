/******************************************************************************
 * Automatically generated file. Please don't change anything.                *
 *****************************************************************************/

#include <stdlib.h>

#include <lua.h>
#include <lauxlib.h>

#include "iup.h"
#include "iuplua.h"
#include "il.h"


static int scrollbox_layoutupdate_cb(Ihandle *self)
{
  lua_State *L = iuplua_call_start(self, "layoutupdate_cb");
  return iuplua_call(L, 0);
}

static int scrollbox_action(Ihandle *self, float p0, float p1)
{
  lua_State *L = iuplua_call_start(self, "action");
  lua_pushnumber(L, p0);
  lua_pushnumber(L, p1);
  return iuplua_call(L, 2);
}

static int ScrollBox(lua_State *L)
{
  Ihandle *ih = IupScrollBox(iuplua_checkihandleornil(L, 1));
  iuplua_plugstate(L, ih);
  iuplua_pushihandle_raw(L, ih);
  return 1;
}

int iupscrollboxlua_open(lua_State * L)
{
  iuplua_register(L, ScrollBox, "ScrollBox");

  iuplua_register_cb(L, "LAYOUTUPDATE_CB", (lua_CFunction)scrollbox_layoutupdate_cb, NULL);
  iuplua_register_cb(L, "ACTION", (lua_CFunction)scrollbox_action, "scrollbox");

#ifdef IUPLUA_USELOH
#include "scrollbox.loh"
#else
#ifdef IUPLUA_USELH
#include "scrollbox.lh"
#else
  iuplua_dofile(L, "scrollbox.lua");
#endif
#endif

  return 0;
}

