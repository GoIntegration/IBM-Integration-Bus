# IIB Notes
* Elements of message broker the logical message tree are
  * Message
  * LocalEnvironment
  * Environment
  * ExceptionList
* Default message domain for all input nodes is BLOB.
* Message tree when using HTTP Input node and default parser.

      
InputRoot.*[] is array of all children of InputRoot.
HTTP Input node properties -
Advanced -> Set destination list (Selected by default)
Used with RouteToLable and Route node to create different flow paths. based on HTTP method.
Use this option to implement REST web service.
Advanced -> Label to prefix
With this option labels become Prefix_GET, Prefix_POST etc.
Use this option to avoid ambiguous label names.
Advanced -> Parse query string
Query string parameters available in LocalEnvironment.HTTP.Input.QueryString.
Parser Options -> Parse timing (On demand by default)
On Demand.
Immediate.
Complete.
Parser Options -> Build tree using XML schema data types
Used to have data types in tree based on Message Set Definitions.
Error Handling -> Maximum client wait time (sec)
Reply should go within this interval otherwise it will send an error.
Validation -> Validate (None by default)
None
Content and Value
Content
Note: Even if Content is selected, the SOAP, DFDL, and XMLNSC domains always perform Content and Value validation.
Compute Mode Properties - 
Compute mode
Message - The message contains the modified OutputRoot tree, the original InputLocalEnvironment tree, and the original InputExceptionList tree.
LocalEnvironment - The message contains the original InputRoot tree, the modified OutputLocalEnvironment tree, and the original InputExceptionList tree.
ESQL Basics
ESQL can be used in following built in nodes
Primary nodes
Compute node
Database node
Filter node
Secondary Nodes
DataDelete node
DataInsert node
DataUpdate node
Extract node
Mapping node
Warehouse node
ESQL data type categories and data types
Boolean
Datetime
Null
Numeric
Reference
String
ESQL Variables
To define variable and optionally assign initial value use DECLARE statement. 
If no initial value is mentioned then scalar variables are initialized to NULL and ROW variables are initialized to empty state.
Change value of variable using SET statement.
Variable names are case sensitive.
Types of variables
External Variables
Also known as user defined properties.
Defined with EXTERNAL keyword.
Exist for entire lifetime of a message flow.
Visible to all messages passing through message flow.
Value can be changed at design time using flow editor or at deployment time using BAR editor or at run time using Change Manager Proxy (CMP)
Normal variables
Normal variables are visible to only one message.
Defined by omitting EXTERNAL and SHARED keyword.
Shared variables
Used to implement in-memory cache.
Visible to multiple messages passing through a flow.
Initialized when first message passes throught node.
User defined properties
User defined properties can be accessed using EXTERNAL keyword on declare statement.
Broker Properties
Properties related to Broker, Execution Group, Nodes, etc.
ESQL Field References
Use REFERENCE pointer to set up dynamic pointer to a field in message.
ESQL Functions
defined by CREATE FUNCTION statement.
Can return a value.
ESQL PROCEDURES
PROCEDURE has no return value.
PROCEDURE name is case insensitive.
External database procedure is indicated by keyword EXTERNAL and external PROCEDURE name.
Overloaded database procedures are not supported.
ESQL Modules
Bigins with CREATE node_type MODULE statement. node_type must be one of COMPUTE, DATABASE, FILTER.
Entry point is FUNCTION MAIN 
ESQL Usage with different nodes
Compute node
Update/Insert/Delete data in database
Update environment and Local Environment Tree
Create one or more output messages
Propagate parts of message tree to output
Database node
All as above except it propagates input message as is.
Filter node
All as above except output message will be propagated to one of TRUE or FALSE terminal.
