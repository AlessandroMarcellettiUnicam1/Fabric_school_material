#!/bin/bash

function one_line_pem {
    echo "`awk 'NF {sub(/\\n/, ""); printf "%s\\\\\\\n",$0;}' $1`"
}

function json_ccp {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        -e "s/\${ORGNAME}/$6/" \
        organizations/ccp-template.json
}

function yaml_ccp {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        -e "s/\${ORGNAME}/$6/" \
        organizations/ccp-template.yaml | sed -e $'s/\\\\n/\\\n        /g'
}

ORG="customer.shopping.com"
P0PORT=7051
CAPORT=7054
ORGNAME="Customer"
PEERPEM=organizations/peerOrganizations/${ORG}/tlsca/tlsca.${ORG}-cert.pem
CAPEM=organizations/peerOrganizations/${ORG}/ca/ca.${ORG}-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $ORGNAME)" > organizations/peerOrganizations/${ORG}/connection-org1.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $ORGNAME)" > organizations/peerOrganizations/${ORG}/connection-org1.yaml

ORG="shop.shopping.com"
P0PORT=9051
CAPORT=8054
ORGNAME="Shop"
PEERPEM=organizations/peerOrganizations/${ORG}/tlsca/tlsca.${ORG}-cert.pem
CAPEM=organizations/peerOrganizations/${ORG}/ca/ca.${ORG}-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $ORGNAME)" > organizations/peerOrganizations/${ORG}/connection-org2.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $ORGNAME)" > organizations/peerOrganizations/${ORG}/connection-org2.yaml

ORG="producer.shopping.com"
P0PORT=11051
CAPORT=11054
ORGNAME="Producer"
PEERPEM=organizations/peerOrganizations/${ORG}/tlsca/tlsca.${ORG}-cert.pem
CAPEM=organizations/peerOrganizations/${ORG}/ca/ca.${ORG}-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $ORGNAME)" > organizations/peerOrganizations/${ORG}/connection-org3.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $ORGNAME)" > organizations/peerOrganizations/${ORG}/connection-org3.yaml