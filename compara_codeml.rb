#!/usr/bin/env ruby
require "ftools"
n = 1;
high = 5965;

while n < high do
  xf = sprintf('%05d',n)
  treeFile = File.open("species.trees", "w")
    treeFile.print "    5 7\n","(xt_",xf," #1,hs_",xf,",(ac_",xf,",(gg_",xf,",tg_",xf,")));","\n","(xt_",xf,",hs_",xf," #1,(ac_",xf,",(gg_",xf,",tg_",xf,")));","\n","(xt_",xf,",hs_",xf,",(ac_",xf," #1,(gg_",xf,",tg_",xf,")));","\n","(xt_",xf,",hs_",xf,",(ac_",xf,",(gg_",xf," #1,tg_",xf,")));","\n","(xt_",xf,",hs_",xf,",(ac_",xf,",(gg_",xf,",tg_",xf," #1)));","\n","(xt_",xf,",hs_",xf,",(ac_",xf,",(gg_",xf,",tg_",xf,") #1));","\n","(xt_",xf,",hs_",xf,",(ac_",xf,",(gg_",xf,",tg_",xf,")) #1);","\n"
  treeFile.close
  alignFile = "alignments/aligned_set."+xf+".phylip"
  File.copy(alignFile, "current_set.phylip")
  
  File.copy("control/codeml_modelA_null.ctl", "codeml.ctl")
  system "codeml"
  dirOut = "hypothesis/null/set_"+xf
  Dir.mkdir(dirOut)
  outFiles = ["2NG.dN","2NG.dS","2NG.t","4fold.nuc","rub","lnf","main.codeml","rst","rst1"]
  outFiles.each {|file| File.move(file,dirOut)}
  
  File.copy("control/codeml_modelA_alt.ctl", "codeml.ctl")
  system "codeml"
  dirOut = "hypothesis/alternative/set_"+xf
  Dir.mkdir(dirOut)
  outFiles = ["2NG.dN","2NG.dS","2NG.t","4fold.nuc","rub","lnf","main.codeml","rst","rst1"]
  outFiles.each {|file| File.move(file,dirOut)}  
  
  n = n+1
end
