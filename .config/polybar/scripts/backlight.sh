#!/bin/bash 

T=$(light | cut -d. -f1)

case $T in
	100)
		echo ""
	;;
	90)
		echo ""
	;;
	80)
		echo ""
	;;
	70)
		echo ""
	;;
	60)
		echo ""
	;;
	50)
		echo ""
	;;
	40)
		echo ""
	;;
	30)
		echo ""
	;;
	20)
		echo ""
	;;
	10)
		echo ""
	;;
 	*)
 		echo "Error"
  ;;
esac

