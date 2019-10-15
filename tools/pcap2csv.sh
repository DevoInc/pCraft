#!/bin/bash
pcap=$1
tshark=tshark

if [ $# -ne 1 ]
then
    echo "$0 pcap-file"
    exit 1
fi

# 1   0.000000 192.168.26.22 → 10.106.69.3  DNS 82 Standard query 0x0000 A irishwoman-ravioli.com
# 2   0.000535  10.106.69.3 → 192.168.26.22 DNS 120 Standard query response 0x0000 A irishwoman-ravioli.com A 199.34.228.66
# 6   0.001870 192.168.26.22 → 199.34.228.66 HTTP 634 POST /g.php HTTP/1.1
# 8   0.002740 192.168.148.246 → 10.116.167.170 DNS 82 Standard query 0x0000 A irishwoman-ravioli.com
# 9   0.003137 10.116.167.170 → 192.168.148.246 DNS 120 Standard query response 0x0000 A irishwoman-ravioli.com A 199.34.228.66
# 13   0.004340 192.168.148.246 → 199.34.228.66 HTTP 613 POST /g.php HTTP/1.1

function handle_dns()
{
    line=$1
#    echo "$line"
    if [ ! -e dns.csv ]
    then
	echo "ts, srcip, dstip, srcport, dstport, length, flags, transaction_id, query_type, query_name, answer_type, answer_addr" > dns.csv
    fi

    echo $line |grep "Standard query response"
    if [ $? -eq 0 ]
    then
	echo $line | awk  '{out = sprintf("%s,%s,%s,%s,%s %s %s,%s,%s,%s,%s,%s", $2, $3, $5, $7, $8, $9, $10, $11, $12, $13, $14, $15)} END {print out};' >> dns.csv
    else
	echo $line | awk  '{out = sprintf("%s,%s,%s,%s,%s %s %s,%s,%s,%s,", $2, $3, $5, $7, $8, $9, $10, $11, $12, $13)} END {print out};' >> dns.csv	
    fi
}

function handle_http()
{
    line=$1
#    echo "$line"
    if [ ! -e http.csv ]
    then
	echo "ts, srcip, dstip, srcport, dstport, length, http_method, http_uri, http_ua" > http.csv
    fi

    ua="Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; InfoPath.1)"
    
    echo $line | awk  '{out = sprintf("%s,%s,%s,%s,%s,%s", $2, $3, $5, $7, $8, $9)} END {print out};' >> http.csv
    echo $ua >> http.csv
}

tmpfile=$(mktemp)
$tshark -r $pcap > $tmpfile
while read line
do
    protocol=$(echo $line |awk '{p = sprintf("%s\n", $6)} END {print p};')
    case $protocol in
	DNS)
	    handle_dns "$line"
	    ;;
	HTTP)
	    handle_http "$line"
	    ;;
    esac
done < $tmpfile

rm -f tmpfile
