# Some handy IIB commands
* Item 1
  1. A corollary to the above item.
  2. Yet another point to consider.
* Item 2
  * A corollary that does not need to be ordered.
    * This is indented four spaces, because it's two spaces further than the item above.
    * You might want to consider making a new list.
* Item 3



*List deployed objects on message broker
**`mqsilist -r`

* Restart message broker
	`mqsistop <broker>`
	`mqsistart <broker>`

# Deploy a BAR file
	mqsideploy <broker> -e <execution_group> -a <bar_file> 

# Restart a message flow
	mqsistopmsgflow <broker> -e <execution_group> -m <message_flow>
	mqsistartmsgflow <broker> -e <execution_group> -m <message_flow>

# List all message flows with execution groups
	mqsilist -r | grep "Message flow" | awk -F\' ' { print $4" "$2 }'

# Set DB user and Password
	mqsisetdbparms <broker> -n <dsn> -u <user> -p '<password>' 
	mqsisetdbparms <broker> -n dsn::DAN -u <user> -p '<password>' 
	mqsisetdbparms <broker> -n dsn::<dsn> -u <user> -p '<password>' 
	
# Set FTP credentials 
	mqsisetdbparms <broker> -n sftp::<sft_id> -u <user> -p '<password>' 

# Enable SSL support on the broker instance 
	mqsichangeproperties <broker> -b httplistener -o HTTPListener -n enableSSLConnector -v true
	
# Message broker logs 
	# JVM standard out and err logs
		/var/mqsi/mqsi/components/<broker>/<eg_uid>/stdout 
		/var/mqsi/mqsi/components/<broker>/<eg_uid>/stderr 

# Check execution group start times 
	grep "Execution group started" /var/mqsi/mqsi/components/<broker>/<eg_uid>/stdout 
	
# Procedure to take a user or service trace of message flow at an integration server or execution group level 
	http://www-01.ibm.com/support/docview.wss?uid=swg21177321 

# Create security profile 
	mqsicreateconfigurableservice <broker> -c SecurityProfiles -o <SecurityProfileObjectName> -n authentication,authenticationConfig,mapping,authorization,propagation -v "LDAP",\"ldap://url:389/rdn?cn\","NONE","NONE",TRUE 
	
# Backup configuration before change controls 
	# Take backup of /root/mqsi/jplugin directory 
	# Take backup of /var/mqsi/odbc/odbc.ini 
	# Take backup of /root/mqsi/jre16/lib/security/cacerts 
	# Take backup of broker configuration (mqsibackupbroker) 
	
# Configure Message Broker to serve HTTPS requests 
	mqsichangeproperties <broker> -o BrokerRegistry -n brokerKeystoreFile -v <Key Store File>
	mqsichangeproperties <Broker> -o BrokerRegistry -n brokerTruststoreFile -v <Trust Store File>
	mqsisetdbparms <Broker> -n brokerTruststore::password -u temp -p changeit
	mqsichangeproperties <Broker> -b httplistener -o HTTPListener -n enableSSLConnector -v true
	mqsichangeproperties <Broker> -b httplistener -o HTTPSConnector -n keystoreFile -v <Key Store File>
	mqsichangeproperties <Broker> -b httplistener -o HTTPSConnector -n keystorePass -v <password>
	mqsichangeproperties <Broker> -b httplistener -o HTTPConnector -n port -v <Port> 
	mqsichangeproperties <Broker> -b httplistener -o HTTPSConnector -n port -v <Port>
	mqsichangeproperties <Broker> -b httplistener -o HTTPSConnector -n clientAuth -v true
	mqsistop <Broker> 
	mqsistart <Broker> 

	mqsireportproperties <Broker> -b httplistener -o AllReportableEntityNames -a 
	mqsireportproperties <Broker> -b httplistener -o HTTPListener -a 
	mqsireportproperties <Broker> -b httplistener -o HTTPSConnector  -a 

	mqsichangeproperties <Broker> -e <EG> -o HTTPSConnector -n sslProtocol -v TLS
	mqsichangeproperties <Broker> -e <EG> -o HTTPSConnector -n explicitlySetPortNumber -v <Port>
	mqsichangeproperties <Broker> -e <EG> -o HTTPSConnector -n clientAuth -v true 
	mqsichangeproperties <Broker> -e <EG> -o HTTPSConnector -n keystoreFile -v <Key Store File>
	mqsichangeproperties <Broker> -e <EG> -o HTTPSConnector -n keystoreType -v JKS
	mqsichangeproperties <Broker> -e <EG> -o HTTPSConnector -n keystorePass -v <password>
	mqsichangeproperties <Broker> -e <EG> -o ComIbmJVMManager -n keystoreFile -v <Key Store File> 
	mqsichangeproperties <Broker> -e <EG> -o ComIbmJVMManager -n keystoreType -v JKS 
	mqsichangeproperties <Broker> -e <EG> -o ComIbmJVMManager -n keystorePass -v brokerKeystore::password 
	mqsichangeproperties <Broker> -e <EG> -o ComIbmJVMManager -n truststoreFile -v <Trust Store File>
	mqsichangeproperties <Broker> -e <EG> -o ComIbmJVMManager -n truststoreType -v JKS
	mqsichangeproperties <Broker> -e <EG> -o ComIbmJVMManager -n truststorePass -v brokerTruststore::password

	mqsireportproperties <Broker> -e <EG> -o HTTPSConnector -r

# Switch between Broker Wide Listener and Embedded Listener
	mqsichangeproperties MB8BROKER -e exgroup1 -o ExecutionGroup -n httpNodesUseEmbeddedListener -v false
	mqsichangeproperties MB8BROKER -e exgroup1 -o ExecutionGroup -n soapNodesUseEmbeddedListener -v false

# Report Properties
	Broker Registry Parameters 
		mqsireportproperties "<Broker> -o BrokerRegistry -r"
	All Reportable Entities 
		mqsireportproperties "<Broker> -e <Execution Group> -o AllReportableEntityNames -r" 
	HTTP Listener Properties At Broker Level 
		mqsireportproperties "<Broker> -b httplistener -o AllReportableEntityNames -r"
	HTTP Connector Properties At Execution Group Level 
		mqsireportproperties "<Broker> -e <ExecutionGroup> -o HTTPConnector -r"
	HTTPS Connector Properties At Execution Group Level 
		mqsireportproperties "<Broker> -e <ExecutionGroup> -o HTTPSConnector -r"
	JVM Properties 
		mqsireportproperties "<Broker> -o ComIbmJVMManager -a -e <ExecutionGroup>"
	Security Profile Properties 
		mqsireportproperties "<Broker> -c SecurityProfiles -o <Security Profile Name> -r"

# OS Version
	oslevel -s

# CPU/Memory Related Commands
	lparstat 
	lparstat -i 
	prtconf 
	lsconf 
	nmon 
	https://www.ibm.com/developerworks/community/blogs/aixpert/entry/aix_memory_usage_or_who_is_using_the_memory_and_how20?lang=en 
	vmstat -Iwt 2 30 
	iostat -Dl 
	vmstat -s

# List details of all volume groups with lsvg on AIX
	lsvg 
	lsvg -li 
# Operating System Logs Viewing the general system error log (AIX) 
	errpt -a | more 
# Find out Process Listening on a port
	netstat -Aan | grep <port> 
	First part of the result is socket id. Run following command with socket id 
		rmsock <socket id> tcpcb 

# Maximum number of processes per user AIX
	lsattr -El sys0

# Certificate Related Commands
	List Certificates in Key Store 
		keytool -list -v -keystore "<keystore file>" 
	CA Certificate File Location 
		/root/mqsi/jre16/lib/security/cacerts 
	Generate Private Key and Key Store 
		keytool -genkey -alias <alias_name> -keyalg RSA -keystore "/root/mqsi/jre16/lib/security/<Key Store Name>" -keysize 2048 
	Generate CSR 
		keytool -certreq -alias <alias_name> -keystore "/root/mqsi/jre16/lib/security/cacerts" -file name.csr 
	Send name.csr to CA for generating the certs. 
	
# Convert p12 format to pem format Key Store and Private key conversion from p12 to pem
	/root/mqsi/jre16/bin/keytool -v -importkeystore -srckeystore keystore.jks -srcalias client -destkeystore myp12file.p12 -deststoretype PKCS12 
	openssl pkcs12 -in <File_Name>.p12 -out <File_Name>.pem 
# Import a Certificate in Key Store 
	/root/mqsi/jre16/bin/keytool -import -alias <alias> -file "<cert file>" -keystore "/root/jre16/lib/security/cacerts" 
# Delete a Certificate from Key Store 
	/root/mqsi/jre16/bin/keytool -delete -alias <alias> -keystore "/root/mqsi/jre16/lib/security/cacerts"

# Catalog DB2 Servers on Desktop
	CATALOG TCPIP NODE NODENAME REMOTE HOST_DNS SERVER PORT 
	CATALOG DATABASE DBNAME AS DBALIAS AT NODE NODENAME

# Commands Used to request certificates for New test Environment Load balancer
	/root/mqsi/jre16/bin/keytool -genkey -alias cert_alias -keyalg RSA -keystore keystore.jks -keysize 2048 
	/root/mqsi/jre16/bin/keytool -certreq -alias cert_alias -keystore keystore.jks -file file.csr 
	/root/mqsi/jre16/bin/keytool -v -importkeystore -srckeystore keystore.jks -srcalias src_alias -destkeystore dst_keystore.p12 -deststoretype PKCS12 
	openssl pkcs12 -in keystore.p12 -out private_key.pem


