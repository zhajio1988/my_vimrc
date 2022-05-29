###########################################################################
#                                                                         #
#                       DO NOT EDIT THIS FILE                             #
#                                                                         #
#          Any changes to this file will be overwritten.                  #
#       Put any user customizations in the file .cshrc.user               #
#                                                                         #
#                                                                         #
###########################################################################
if ( -f /cad/xxx/etc/cad.cshrc ) then
  source /cad/xxx/etc/cad.cshrc
endif

alias verdi 'verdi -nologo -rcFile /opt/picocom/tools/novas.rc'
if ( -f $HOME/.cshrc.user ) then
  source $HOME/.cshrc.user
endif
