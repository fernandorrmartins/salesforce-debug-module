# Summary
<ol>
    <li>
        <a href='about'>Debug Module</a>
    </li>
    <li>
        <a href='pattern'>Singleton Pattern</a>
    </li>
    <li>
        <a href=''>Debug module composition</a>
    </li>
    <li>
        <a href=''>Methods</a>
        <ul>
            <li>
                <a href=''>What happen as result</a>
            </li>
            <li>
                <a href=''>Main methods</a>
                <ul>
                    <li>
                        <a href=''>log()</a>
                    </li>
                    <li>
                        <a href=''>log(Object key, Object value)</a>
                    </li>
                    <li>
                        <a href=''>log(Exception e)</a>
                    </li>
                    <li>
                        <a href=''>log(Map<Object, Object> debugMap)</a>
                    </li>
                    <li>
                        <a href=''>log(Map<Object, Object> debugMap, Exception e)</a>
                    </li>
                </ul>
                <li>
                    <a href=''>Important details</a>
                </li>
                <li>
                    <a href=''>Other methods</a>
                    <ul>
                        <li>
                            <a href=''>start()</a>
                        </li>
                        <li>
                            <a href=''>end()</a>
                        </li>
                        <li>
                            <a href=''>setStart()</a>
                        </li>
                        <li>
                            <a href=''>setEnd()</a>
                        </li>
                    </ul>
                </li>
            </li>
        </ul>
    </li>
</ol>

# 1. [Salesforce] Debug Module
Debug class to support a better understand of what is going on during processing of development, or about errors and exceptions.<br>

# 2. [Pattern] Singleton
• This class use the sigleton pattern, where only one instance of this class is used since the start of the context (processment) until de end of the context.<br>
• I am trying to use single responsabilities to, try to creating little methods to maintain code reusability, and simplify development of test class and methods.<br>
## So the constructor is private:<br>
![image](https://github.com/fernandorrmartins/salesforce-debug-module/assets/32397071/0c838ed9-90a3-4c7e-83fd-c2159a44485f)<br>
The class has only one Debug type variable <b>'INSTANCE'</b>:<br>
![image](https://github.com/fernandorrmartins/salesforce-debug-module/assets/32397071/2d71e8b2-2074-4850-af98-361b8145ec78)<br>
That will be used for call the methods with the follow <b>'getInstance'</b> method:<br>
![image](https://github.com/fernandorrmartins/salesforce-debug-module/assets/32397071/697efa95-b436-4393-88c1-f70d5d669a5e)<br>
<br>

# 3. This project contains only two classes:<br>
• Debug.cls<br>
• DebugTest.cls<br>
<br>
The main class is Debug, wich have some util methods to help developer debug and understand what is going on.<br>
In the next content, i will show you how to use this util methods with some prints of samples.<br>
In the end, i will talk a little about customize the logic of this methods, but it probably will be very rare to use.<br>

# 4. Methods
• The main proposite of this class is to log some key points to understand the code, as what 'class', 'method', what line the debug log method was called, and key and values for the dev understand what is happening in the logic of the class, and where it is.<br>
![Alt text](image.png)
![Alt text](image-1.png)
## What happened?
<b>1. Class name:</b> As the method was called from executed anonymous block (developer console), its name appeared in the log message.<br>
<b>2. Method name:</b> As the method was called out of a method, nothing appeared in the method name.<br>
<b>3. Line number:</b> As the method was called from the first line, the first line was showed in the log message.
## Main methods
### • log()
&emsp;<b>→ Obs:</b> This method call a debug log message with basic information as showed above but, we will present it called from a simple class here.
<br>&emsp;<b>[Screen shoots]</b>
<br>&emsp;![Alt text](image-5.png)
&emsp;![Alt text](image-6.png)
&emsp;![Alt text](image-2.png)
<br>&emsp;<b>→ Explanation:</b> In the screen shoots above we can see the key points easily, as 'class name', 'method name', and 'line number', but it is the most simple sample here.<br>
<hr>

### • log(Object key, Object value)
&emsp;<b>→ Obs:</b> Here, we start to add some complexity to the debug logs. We can add lines, and this lines ('key → values') to see the result of some proccessment, or see what is happening insed the code.
<br>&emsp;<b>→ Obs²:</b> As the parameters are of type <b>Object</b>, it can accept any type of values, as SObject, maps, lists, and any other primitive or complex types.
<br>&emsp;<b>[Screen shoots]</b>
<br>&emsp;![Alt text](image-3.png)
&emsp;![Alt text](image-4.png)
<br>&emsp;<b>→ Explanation:</b>
<br>&emsp;1. The 'key' value is presented as an key in the message to identify the value you want to see.
<br>&emsp;2. The 'value' is presented to visualize what is saved inside the variable.
<hr>

### • log(Exception e)
&emsp;<b>→ Obs:</b> This is my favorite one. Every dev format a exception message with his own pattern, what make the code different, and can add alot of lines to the project, but this method format the message with a single and easy pattern that help to undertand the key points.
<br>&emsp;<b>[Screen shoots]</b>
<br>&emsp;![Alt text](image-7.png)
&emsp;![Alt text](image-8.png)
<br>&emsp;<b>→ Explanation:</b>
<br>&emsp;1. In the message, a new section called 'Exception Data' is created, displaying what is important.
<br>&emsp;2. With this, we can implement exception log as simple, clear and fast as possible.
<hr>

### • log(Map<Object, Object> debugMap)
&emsp;<b>→ Obs:</b> Passing a Map<Object, Object> , where the key map is the 'key' in the message, and the value map, is the 'value' in the message, we can log alot of values to see all we want easly.
<br>&emsp;<b>[Screen shoots]</b>
<br>&emsp;![Alt text](image-9.png)
&emsp;![Alt text](image-10.png)
<br>&emsp;<b>→ Explanation:</b> Every '• key → value' use a different line to be displayed.
<hr>

### • log(Map<Object, Object> debugMap, Exception e)
&emsp;<b>→ Obs:</b> And we can combine the useful with the pleasant to present both the data that were used and the data of the exception generated to understand what happened.
<br>&emsp;<b>[Screen shoots]</b>
<br>&emsp;![Alt text](image-11.png)
&emsp;![Alt text](image-12.png)
<br>&emsp;<b>→ Explanation:</b> We can send at same time a key value map, with the exception threw to see everything easly.
<hr>

## Important details:
• Some times, we try to log long messages, that some times can be hidden by developer log, or the log itself when opened in a IDE or text editor, but with this class, i prepared a break line function to break long values message, using a <b>Regex expression</b>, based in line size, and that use a default <b>Break simbol</b>, that can be customized using a set method. By default:
<br>&emsp;→ The split character simbol is: <b>a simple comma (,)</b>.
<br>&emsp;→ The minimum and max size to break a line (a space to try to found a split character) is: <b>Min: 340 | Max: 400</b>.
<br>&emsp;→ Default regex expression: <b>(?<=\\G.{340,400}),</b>

<br>• You can use set methods to change custom settings:
<br>&emsp;→ setMinSplitLenght
<br>&emsp;→ setMaxSplitLenght
<br>&emsp;→ setCharacterSplitSignal

<br>• You can use a method to change the breakline to a serializiation, where the code stops to break line and convert the value to a JSON, where sometimes we can see all the line.
<br>&emsp;→ serializeLog

<br>• Every customization is reseted after the end of the proccess to log the data by a method inside the proccess called <b>'cleanInstanceVariables'</b>. So if you want to customize, you will need to change defaults again.

## Other methods:
### • start()
&emsp;<b>→ Obs:</b> This method is used in the place of 'log()' method without parameters. The difference between this two methos is only a aditional message showed indicating that the method you want to analize is 'starting...'.
<br>&emsp;<b>[Screen shoots]</b>
<br>&emsp;![Alt text](image-13.png)
&emsp;![Alt text](image-14.png)
<br>&emsp;<b>→ Explanation:</b> Add a aditional information saying the method analised is starting.
<hr>
### • end()
&emsp;<b>→ Obs:</b> Equals to the start, but is used to be placed in the end of the method.
<br>&emsp;<b>[Screen shoots]</b>
<br>&emsp;![Alt text](image-15.png)
&emsp;![Alt text](image-16.png)
<br>&emsp;<b>→ Explanation:</b> Add a aditional information saying the method analised is ending.
<hr>
### • setStart()
&emsp;<b>→ Obs:</b> You can use 'setStart()' method to add this additional message in a more complex log, to analyse for example parameters that the method received and its values when starting the method.
<br>&emsp;<b>[Screen shoots]</b>
<br>&emsp;![Alt text](image-17.png)
&emsp;![Alt text](image-18.png)
&emsp;![Alt text](image-19.png)
<br>&emsp;<b>→ Explanation:</b> Add a aditional information to a more complex log, saying the method analised is starting.
<hr>
### • setEnd()
&emsp;<b>→ Obs:</b> You can use 'setEnd()' method to add this additional message in a more complex log, to analyse for example parameters when the method is ending, and see what happened during proccessment.
<br>&emsp;<b>[Screen shoots]</b>
<br>&emsp;![Alt text](image-20.png)
&emsp;![Alt text](image-21.png)
&emsp;![Alt text](image-22.png)
<br>&emsp;<b>→ Explanation:</b> Add a aditional information to a more complex log, saying the method analised is ending.


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
