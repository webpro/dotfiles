#! /bin/sh
usage_error () {
  echo "------------------------------------------------------------------"
  echo "Name: bd"
  echo ""
  echo "------------------------------------------------------------------"
  echo "Description: Go back to a specified directory up in the hierarchy."
  echo ""
  echo "------------------------------------------------------------------"
  echo "How to use:"
  echo ""
  echo "If you are in this path /home/user/project/src/org/main/site/utils/file/reader/whatever"
  echo "and you want to go to site directory quickly, then just type:"
  echo "     . bd site"
  echo ""
  echo "If there are more than one directories with same name up in the hierarchy,"
  echo "bd will take you to the closest. (Not considering the immediate parent.)"
  echo ""
  echo "If you don't want to type the full directory name, then you can use "
  echo "the -s switch (meaning starts with) and just give the starting few characters"
  echo "     . bd -s si"
  echo ""
  echo "------------------------------------------------------------------"
  echo "Extra settings:"
  echo ""
  echo "To get the most out of it, put this line: "
  echo "     alias bd='. bd -s'"
  echo "in your ~/.bashrc file so that it is no longer necessary to put a dot and space."
  echo ""
  echo "You can simply type 'bd <starting few letters>' to go back quickly."
  echo ""
  echo "So in the case of the given example, it would be"
  echo "     'bd s' or 'bd si'"
}
if [ $# -eq 0 ]
then
  usage_error
elif [ $# -eq 1 -a "$1" = "-s" ]
then
  usage_error
else
  OLDPWD=`pwd`

  if [ "$1" = "-s" ]
  then
    NEWPWD=`echo $OLDPWD | sed 's|\(.*/'$2'[^/]*/\).*|\1|'`
    index=`echo $NEWPWD | awk '{ print index($1,"/'$2'"); }'`
  else
    NEWPWD=`echo $OLDPWD | sed 's|\(.*/'$1'/\).*|\1|'`
    index=`echo $NEWPWD | awk '{ print index($1,"/'$1'/"); }'`
  fi
  
  if [ $index -eq 0 ]
  then
    echo "No such occurrence."
  fi
  
  echo $NEWPWD
  cd "$NEWPWD"
fi
