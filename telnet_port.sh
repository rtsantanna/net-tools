#!/bin/bash
type telnet 1>/dev/null 2>&1
ERRO="$?"

if [ "${ERRO}" -gt 0 ]
then
   echo -e "\nTelnet not installed or not in \$PATH\n" ; exit 3
fi


if [ -z $1 ] || [ -z $2 ]
then
   echo -e "\nSintaxe: $0 [ HOSTNAME/IP | 'port1 | port2 | ...' ]\n" ; exit 3
else
   HOST="$1"
   PORTS="$2"
fi

check_port_telnet()
{
TIMEOUT=3; telnet ${HOST} ${PORT} 2>&1 1>/dev/null & WPID=$!; sleep $TIMEOUT && kill $! 2>/dev/null 1>&1 & KPID=$!; wait $WPID 2>/dev/null
}

echo -e "Testando IP: ${HOST} ==> | \c"

PORTAS=`echo ${PORTS} | sed 's:|:\\n:g'`

for PORT in  $PORTAS
do
   check_port_telnet ${HOST} ${PORT} > /tmp/a.$$

   conf="`cat /tmp/a.$$ | grep -i closed | wc -l`" ; conf="`echo ${conf}`" ; yes | rm -f /tmp/a.$$ 2>/dev/null

   if [ "${conf}" -gt 0 ]
   then
      status="`echo 'Aberta: '`${PORT} | \c"
   else
      status="`tput setab 7; tput setaf 1; echo 'Falha: '`${PORT}`tput sgr0` | \c"
   fi
   echo -e "$status"

   sleep 1

done
echo ""

