# Work In Progress

## Requirements
- all recipes are biased for CentOS 7

# MongoDB Recipes and Templates

- default.rb: installs the mongodb binaries and tools, prepares common system directories and users.
- mongod.rb: starts a mongod service.  depends on default recipe
- bic.rb: installs, configures, and starts the BI Connector service.  depends on mongod recipe
- mms.rb: installs and starts the MongoDB Management Service.  depends on mongod recipe
- mongodb-enterprice.rb: configures the mongodb enterprise yum repository and installs mongodb-enterprise packages
