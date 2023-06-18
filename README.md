# [Salesforce] Debug Module
Debug class to support a better understand of what is going on during processing of development, or about errors and exceptions.<br>

# [Pattern] Singleton
• This class use the sigleton pattern, where only one instance of this class is used since the start of the<br>
context (processment) until de end of the context.<br>
• I am trying to use single responsabilities to, try to creating little methods to maintain code reusability, and<br>
simplify development of test class and methods.
<br>
So the constructor is private:<br>
![image](https://github.com/fernandorrmartins/salesforce-debug-module/assets/32397071/0c838ed9-90a3-4c7e-83fd-c2159a44485f)<br>
<br>
The class has only one Debug type variable <b>'INSTANCE'</b>:<br>
![image](https://github.com/fernandorrmartins/salesforce-debug-module/assets/32397071/2d71e8b2-2074-4850-af98-361b8145ec78)<br>
That will be used for call the methods with the follow <b>'getInstance'</b> method:<br>
![image](https://github.com/fernandorrmartins/salesforce-debug-module/assets/32397071/697efa95-b436-4393-88c1-f70d5d669a5e)<br>
<br>

# This project contains only two classes:<br>
• Debug.cls<br>
• DebugTest.cls<br>
<br>
The main class is Debug, wich have some util methods to help developer debug and understand what is going on.<br>
<br>
In the next content, i will show you how to use this util methods with some prints of samples.<br>
In the end, i will talk a listtle about customize the logic of this methods, but it probably will be very rare to use.<br>

# Salesforce DX Project: Next Steps

Now that you’ve created a Salesforce DX project, what’s next? Here are some documentation resources to get you started.

## How Do You Plan to Deploy Your Changes?

Do you want to deploy a set of changes, or create a self-contained application? Choose a [development model](https://developer.salesforce.com/tools/vscode/en/user-guide/development-models).

## Configure Your Salesforce DX Project

The `sfdx-project.json` file contains useful configuration information for your project. See [Salesforce DX Project Configuration](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_ws_config.htm) in the _Salesforce DX Developer Guide_ for details about this file.

## Read All About It

- [Salesforce Extensions Documentation](https://developer.salesforce.com/tools/vscode/)
- [Salesforce CLI Setup Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_intro.htm)
- [Salesforce DX Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_intro.htm)
- [Salesforce CLI Command Reference](https://developer.salesforce.com/docs/atlas.en-us.sfdx_cli_reference.meta/sfdx_cli_reference/cli_reference.htm)
