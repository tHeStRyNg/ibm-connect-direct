#! /bin/sh
#
#############################################################################
# Licensed Materials - Property of IBM
#
# Connect:Direct for UNIX
#
# (C) Copyright IBM Corp. 1992, 2016 All Rights Reserved.
#
# US Government Users Restricted Rights - Use, duplication or disclosure
# restricted by GSA ADP Schedule Contract with IBM Corp.
#############################################################################

# spcust_sample1.sh contains an example of configuring
# Secure+ to use SSL or TLS protocols with the Secure+ CLI. 
# The example demonstrates the configuration of Secure+
# with the trusted root and key certificates and ciphers
#


#
# Variables
#

# The return code. 
# spcli.sh returns the highest return code of the commands
# it executed. Possible return codes and their meanings are
#      0    success
#      4    warning
#      8    error
#     16    fatal error
RC=0


#
# Functions
#

#
# Custom initialization logic written by customer.
#
initCustom()
{
    # Customer adds custom initialization code here.
    echo "Init custom..."
    # rm -rf /home/ansible1/cdunix/ndm/secure+/nodes
}

#
# Invoke CLI to configure Secure+.
#
invokeCLI()
{
    /home/ansible1/cdunix/ndm/bin/spcli.sh -e 8 -li y << EOF
    ;
    display info
    ;
    ;
    ; -- Synch with netmap
    ;
    sync netmap 
        path=/home/ansible1/cdunix/ndm/cfg/ansible1/netmap.cfg
        name=*
    ;
    ;
    ; -- Import KeyCert
    ;
    Import KeyCert
        File=/home/ansible1/cdunix/ndm/secure+/certificates/keycert
        Passphrase=P@ssw0rd
        Label=ansible1
        ImportMode=Add
    ;
    ;
    ; -- Import TrustedCert
    ;
    Import TrustedCert
        File=/home/ansible1/cdunix/ndm/secure+/certificates/cert
        ImportMode=Add
    ;
    ;
    ; -- Update LocalNode
    ;
    Update LocalNode
        Protocol=TLS1.2
        Override=n
        AuthTimeout=120
        KeyCertLabel=ansible1
        EncryptData=y
        ClientAuth=n
        CipherSuites=All
        SeaEnable=n
    ; -- Update RemoteNode
    ;
    Update RemoteNode
	name=control
        Protocol=TLS1.2
        Override=n
        AuthTimeout=120
        KeyCertLabel=ansible1
        EncryptData=y
        ClientAuth=n
        CipherSuites=All
        SeaEnable=n
    ;
    ;
    ; -- Display localnode
    ;
    display localnode
    ; 
    ;
    ; -- Validate parmfile
    ;
    validate parmfile
    ;
EOF

    return $?
}

#
# Custom termination logic written by customer.
#
terminateCustom()
{
    # Customer adds custom termination code here.
    # For example, E-mail standard out log for review.
    # Send error messages to system monitoring facility. 
    echo "$RC"
    echo "Custom Terminating ... "
}


#
#  Main script
#

echo
echo "This script has been prevented from running because it will alter the configuration"
echo "of Secure+. Before removing this warning and its exit call, please modify the script"
echo "so that it carries out only desired modifications to the configuration of Secure+." 
echo  

initCustom

invokeCLI
RC=$?

terminateCustom

exit $RC 
