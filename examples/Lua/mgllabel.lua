
require("iuplua")
require("iuplua_mglplot")


mgp = iup.mgllabel{
  rastersize = "400x80", 
  labeltitle = "\\int \\alpha \\sqrt{sin(\\pi x)^2 + \\gamma_{i_k}} dx",
  labelfontsize="10"}
print("#1#", mgp)
sb = iup.vbox{mgp}
print("#2#", sb)
dlg = iup.dialog{sb; title="Dialog"}
print("#3#", dlg)
dlg:show()
print("#4# looping")


if (iup.MainLoopLevel()==0) then
  iup.MainLoop()
end
