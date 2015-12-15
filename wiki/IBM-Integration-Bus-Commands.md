###### Basic message broker commands
    # Start/Stop message broker
    mqsistop IB9NODE
    mqsistart IB9NODE
    
    # List deployed objects
    mqsilist -r
    
    # Start/Stop Execution group
    mqsistopmsgflow IB9NODE -e default
    mqsistartmsgflow IB9NODE -e default
    
    # Start/Stop Message flow
    mqsistopmsgflow IB9NODE -e default -m <message_flow>
    mqsistartmsgflow IB9NODE -e default -m <message_flow>
    
    # Deploy a BAR file
    mqsideploy IB9NODE -e default -a <bar_file>
    
    # List all message flows with execution group
    mqsilist -r | grep "Message flow" | awk -F\' ' { print $4" "$2 }'
    
    # Check execution group start times
    grep "Execution group started" /var/mqsi/mqsi/components/IB9NODE/<eg_uid>/stdout
    
###### Message broker logs
    # JVM standard out and err logs
    /var/mqsi/mqsi/components/IB9NODE/<eg_uid>/stdout 
    /var/mqsi/mqsi/components/IB9NODE/<eg_uid>/stderr 
    
###### List message broker environment
    # Broker registry parameters 
    mqsireportproperties IB9NODE -o BrokerRegistry -r
    
    # Component properties (Valid component names values are httplistener, securitycache, cachemanager or webadmin)
    mqsireportproperties IB9NODE -b httplistener -o AllReportableEntityNames -r
    mqsireportproperties IB9NODE -b securitycache -o AllReportableEntityNames -r
    mqsireportproperties IB9NODE -b cachemanager -o AllReportableEntityNames -r
    mqsireportproperties IB9NODE -b webadmin -o AllReportableEntityNames -r
    
    # List all configurable services
    mqsireportproperties IB9NODE -c AllTypes -o AllReportableEntityNames -r
    
    # List configurable service properties (configurable service type can be ActivityLog, Aggregation, CDServer, CICSConnection, Collector, ConnectorProviders, CORBA, DataCaptureSource, DataCaptureStore, DataDestination, DecisionServiceRepository, DotNetAppDomain, EmailServer, EISProviders, FtpServer, IMSConnect, JavaClassLoader, JDBCProviders, JDEdwardsConnection, JMSProviders, MonitoringProfiles, PeopleSoftConnection, PolicySets, PolicySet Bindings, Resequence, SAPConnection, SecurityProfiles, Service Registries, SiebelConnection, SMTP, TCPIPClient, TCPIPServer, Timer, UserDefined, WXSServer)
    mqsireportproperties IB9NODE -c <ConfigurableServiceName> -o AllReportableEntityNames -r
    
    # All reportable entity names at execution group level
    mqsireportproperties IB9NODE -e default -o AllReportableEntityNames -r
    
    # Properties for entity name at execution group level
    mqsireportproperties IB9NODE -e default -o <EntityName> -r
    
    # JVM Properties 
    mqsireportproperties IB9NODE -e default -o ComIbmJVMManager -a
    
    # Security Profile Properties 
    mqsireportproperties IB9NODE -c SecurityProfiles -o <Security Profile Name> -r
    
    # List all user defined configurable service
    mqsireportproperties IB9NODE -c UserDefined -o AllReportableEntityNames -r

###### Message broker security
    # Broker trust store file location 
    /root/mqsi/jre16/lib/security/cacerts 
    
    # List Certificates in Key Store 
    keytool -list -v -keystore "<keystore file>" 

###### Message broker configuration
    # Increase JVM heap size
    mqsichangeproperties IB9NODE -b agent -o ComIbmJVMManager -n jvmMaxHeapSize -v 1073741824
	mqsichangeproperties IB9NODE -e EG01 -o ComIbmJVMManager -n jvmMaxHeapSize -v 1073741824

	# Delete passwords associated with a data source
	mqsisetdbparms IB9NODE -n USERDB1 -d

###### Other Admin Commands
	# Create execution group
	mqsicreateexecutiongroup IB9NODE -e EG01

###### Setting up a JDBC provider for type 4 connections
    # List available JDBCProvider  services
    mqsireportproperties IB9NODE -c JDBCProviders -o AllReportableEntityNames -a 
    
    # View the contents of the relevant JDBCProvider service definition
    mqsireportproperties IB9NODE -c JDBCProviders -o <JDBCProviderServiceName> -r
    
    # Create JDBCProvider
    mqsideleteconfigurableservice IB9NODE -c JDBCProviders -o JDBCProviderServiceName 
    
    mqsicreateconfigurableservice IB9NODE -c JDBCProviders -o JDBCProviderServiceName -n connectionUrlFormat,connectionUrlFormatAttr1,description,jarsURL,portNumber,serverName,type4DatasourceClassName,type4DriverClassName -v "jdbc:oracle:thin:[user]/[password]@[serverName]:[portNumber]/[connectionUrlFormatAttr1], <Database Name>,<Description>,<Jar path>,1521, <Host Name>,oracle.jdbc.xa.client.OracleXADataSource,oracle.jdbc.OracleDriver"
    
    # Create JDBC security identity to access databse
    mqsisetdbparms IB9NODE -n jdbc::<mySecurityIdentity> -u <userid> -p <password>
    
    # Associate security identity with JDBCProvider
    mqsichangeproperties IB9NODE -c JDBCProviders -o <JDBCProviderServiceName> -n securityIdentity -v <SecurityIdentity>
    
    # Restart integration node
    mqsistop IB9NODE
    mqsistart IB9NODE

###### Operating System
    
    # OS Version
    oslevel -s
    
    # CPU/Memory Related Commands
    lparstat 
    lparstat -i 
    prtconf 
    lsconf 
    nmon 
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
	
	# First part of the result is socket id. Run following command with socket id 
    rmsock <socket id> tcpcb 
      
    # Maximum number of processes per user AIX
    lsattr -El sys0

    # Set DB user and Password
    mqsisetdbparms IB9NODE -n <dsn> -u <user> -p '<password>' 
    mqsisetdbparms IB9NODE -n dsn::DAN -u <user> -p '<password>' 
    mqsisetdbparms IB9NODE -n dsn::<dsn> -u <user> -p '<password>' 
      
    # Set FTP credentials 
    mqsisetdbparms IB9NODE -n sftp::<sft_id> -u <user> -p '<password>' 
    
    # Enable SSL support on the broker instance 
    mqsichangeproperties IB9NODE -b httplistener -o HTTPListener -n enableSSLConnector -v true
    
    # Create security profile 
    mqsicreateconfigurableservice IB9NODE -c SecurityProfiles -o <SecurityProfileObjectName> -n authentication,authenticationConfig,mapping,authorization,propagation -v "LDAP",\"ldap://url:389/rdn?cn\","NONE","NONE",TRUE
    
    # Configure Message Broker to serve HTTPS requests 
    mqsichangeproperties IB9NODE -o BrokerRegistry -n brokerKeystoreFile -v <Key Store File>
    mqsichangeproperties IB9NODE -o BrokerRegistry -n brokerTruststoreFile -v <Trust Store File>
    mqsisetdbparms IB9NODE -n brokerTruststore::password -u temp -p changeit
    mqsichangeproperties IB9NODE -b httplistener -o HTTPListener -n enableSSLConnector -v true
    mqsichangeproperties IB9NODE -b httplistener -o HTTPSConnector -n keystoreFile -v <Key Store File>
    mqsichangeproperties IB9NODE -b httplistener -o HTTPSConnector -n keystorePass -v <password>
    mqsichangeproperties IB9NODE -b httplistener -o HTTPConnector -n port -v <Port> 
    mqsichangeproperties IB9NODE -b httplistener -o HTTPSConnector -n port -v <Port>
    mqsichangeproperties IB9NODE -b httplistener -o HTTPSConnector -n clientAuth -v true
    mqsistop IB9NODE 
    mqsistart IB9NODE
    mqsichangeproperties IB9NODE -e <EG> -o HTTPSConnector -n sslProtocol -v TLS
    mqsichangeproperties IB9NODE -e <EG> -o HTTPSConnector -n explicitlySetPortNumber -v <Port>
    mqsichangeproperties IB9NODE -e <EG> -o HTTPSConnector -n clientAuth -v true 
    mqsichangeproperties IB9NODE -e <EG> -o HTTPSConnector -n keystoreFile -v <Key Store File>
    mqsichangeproperties IB9NODE -e <EG> -o HTTPSConnector -n keystoreType -v JKS
    mqsichangeproperties IB9NODE -e <EG> -o HTTPSConnector -n keystorePass -v <password>
    mqsichangeproperties IB9NODE -e <EG> -o ComIbmJVMManager -n keystoreFile -v <Key Store File> 
    mqsichangeproperties IB9NODE -e <EG> -o ComIbmJVMManager -n keystoreType -v JKS 
    mqsichangeproperties IB9NODE -e <EG> -o ComIbmJVMManager -n keystorePass -v brokerKeystore::password 
    mqsichangeproperties IB9NODE -e <EG> -o ComIbmJVMManager -n truststoreFile -v <Trust Store File>
    mqsichangeproperties IB9NODE -e <EG> -o ComIbmJVMManager -n truststoreType -v JKS
    mqsichangeproperties IB9NODE -e <EG> -o ComIbmJVMManager -n truststorePass -v brokerTruststore::password
    mqsireportproperties IB9NODE -e <EG> -o HTTPSConnector -r
      
###### Switch between Broker Wide Listener and Embedded Listener
    mqsichangeproperties MB8BROKER -e exgroup1 -o ExecutionGroup -n httpNodesUseEmbeddedListener -v false
    mqsichangeproperties MB8BROKER -e exgroup1 -o ExecutionGroup -n soapNodesUseEmbeddedListener -v false

###### SSL related commands
    # Generate Private Key and Key Store 
    keytool -genkey -alias <alias_name> -keyalg RSA -keystore "/root/mqsi/jre16/lib/security/<Key Store Name>" -keysize 2048
    
    # Generate CSR 
    keytool -certreq -alias <alias_name> -keystore "/root/mqsi/jre16/lib/security/cacerts" -file name.csr 
    
    # Convert p12 format to pem format Key Store and Private key conversion from p12 to pem
    /root/mqsi/jre16/bin/keytool -v -importkeystore -srckeystore keystore.jks -srcalias client -destkeystore myp12file.p12 -deststoretype PKCS12 
    openssl pkcs12 -in <File_Name>.p12 -out <File_Name>.pem 
    
    # Import a Certificate in Key Store 
    /root/mqsi/jre16/bin/keytool -import -alias <alias> -file "<cert file>" -keystore "/root/jre16/lib/security/cacerts" 
    
    # Delete a Certificate from Key Store 
    /root/mqsi/jre16/bin/keytool -delete -alias <alias> -keystore "/root/mqsi/jre16/lib/security/cacerts"

###### Database related commands
    # Catalog DB2 database on client machine
    CATALOG TCPIP NODE NODENAME REMOTE HOST_DNS SERVER PORT 
    CATALOG DATABASE DBNAME AS DBALIAS AT NODE NODENAME

* Add data source to connect to database from ESQL code on Windows environment.  
[IBM Integration Bus v9](https://www-01.ibm.com/support/knowledgecenter/SSMKHH_9.0.0/com.ibm.etools.mft.doc/ah14442_.htm)  
[IBM Integration Bus v10](http://www-01.ibm.com/support/knowledgecenter/SSMKHH_10.0.0/com.ibm.etools.mft.doc/ah14442_.htm)   

* Auditing and Logging Using Monitoring Events In IBM Integration Bus\Message Broker  
<https://www.ibm.com/developerworks/community/blogs/546b8634-f33d-4ed5-834e-e7411faffc7a/entry/auditing_and_logging_messages_using_events_in_ibm_integration_bus_message_broker>  

* View Monitoring events Via IBM Integration Bus Web UI  
<https://www.ibm.com/developerworks/community/blogs/546b8634-f33d-4ed5-834e-e7411faffc7a/entry/view_monitoring_events_via_ibm_integration_bus_web_ui>

* Procedure to take a user or service trace of message flow at an integration server or execution group level
  http://www-01.ibm.com/support/docview.wss?uid=swg21177321 

- AIX memory usage
<https://www.ibm.com/developerworks/community/blogs/aixpert/entry/aix_memory_usage_or_who_is_using_the_memory_and_how20?lang=en>

* Backup configuration before change controls
 * Take backup of /root/mqsi/jplugin directory
 * Take backup of /var/mqsi/odbc/odbc.ini 
 * Take backup of /root/mqsi/jre16/lib/security/cacerts 
 * Take backup of broker configuration (mqsibackupbroker)


