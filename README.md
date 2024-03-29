# Summary
<ol start="1">
    <li>
        <a href='#about'>Debug Module</a>
    </li>
    <li>
        <a href='#pattern'>Singleton Pattern</a>
        <ol>
            <li>
                <a href='#private-constructor'>Private constructor</a>
            </li>
        </ol>
    </li>
    <li>
        <a href='#composition'>Debug module composition</a>
    </li>
    <li>
        <a href='#methods'>Methods</a>
        <ol>
            <li>
                <a href='#what-happen'>What happen as result</a>
            </li>
            <li>
                <a href='#main-methods'>Main methods</a>
                <ol>
                    <li>
                        <a href='#log-1'>log()</a>
                    </li>
                    <li>
                        <a href='#log-2'>log(Object key, Object value)</a>
                    </li>
                    <li>
                        <a href='#log-3'>log(Exception e)</a>
                    </li>
                    <li>
                        <a href='#log-4'>log(Map&lt;Object, Object&gt; debugMap)</a>
                    </li>
                    <li>
                        <a href='#log-5'>log(Map&lt;Object, Object&gt; debugMap, Exception e)</a>
                    </li>
                </ol>
            </li>
            <li>
                <a href='#important-details'>Important details</a>
                <ol>
                    <li>
                        <a href='#setting-tip'>You can use set methods to change custom settings:</a>
                        <ol>
                            <li>
                                <a href='#customize-settings'>Customize settings</a>
                            </li>
                            <li>
                                <a href='#serialize-values'>Serialize values</a>
                            </li>
                            <li>
                                <a href='#flow-settings'>Flow settings</a>
                            </li>
                        </ol>
                    </li>
                </ol>
            </li>
            <li>
                <a href='#other-methods'>Other methods</a>
                <ol>
                    <li>
                        <a href='#start'>start()</a>
                    </li>
                    <li>
                        <a href='#end'>end()</a>
                    </li>
                    <li>
                        <a href='#set-start'>setStart()</a>
                    </li>
                    <li>
                        <a href='#set-end'>setEnd()</a>
                    </li>
                </ol>
            </li>
        </ol>
    </li>
</ol>

# <b id='about'>1. [Salesforce] Debug Module</b>
Debug class to support a better understand of what is going on during processing of development, or about errors and exceptions.<br>

# <b id='pattern'>2. [Pattern] Singleton</b>
• This class use the sigleton pattern, where only one instance of this class is used since the start of the context (processment) until de end of the context.<br>
• I am trying to use single responsabilities to, try to creating little methods to maintain code reusability, and simplify development of test class and methods.<br>

### <b id='private-constructor'>I. So the constructor is private</b>
![image](https://github.com/fernandorrmartins/salesforce-debug-module/assets/32397071/0c838ed9-90a3-4c7e-83fd-c2159a44485f)<br>
The class has only one Debug type variable <b>'INSTANCE'</b>:<br>
![image](https://github.com/fernandorrmartins/salesforce-debug-module/assets/32397071/2d71e8b2-2074-4850-af98-361b8145ec78)<br>
That will be used for call the methods with the follow <b>'getInstance'</b> method:<br>
![image](https://github.com/fernandorrmartins/salesforce-debug-module/assets/32397071/697efa95-b436-4393-88c1-f70d5d669a5e)<br>
<br>

# <b id='composition'>3. Debug module composition</b>
• This project contains only two classes.
<pre>
→ Debug.cls
→ DebugTest.cls
</pre>
• The main class is Debug, wich have some util methods to help developer debug and understand what is going on.<br>
• In the next content, i will show you how to use this util methods with some prints of samples.<br>
• In the end, i will talk a little about customize the logic of this methods, but it probably will be very rare to use.<br>

# <b id='methods'>4. Methods</b>
• The main proposite of this class is to log some key points to understand the code, as what 'class', 'method', what line the debug log method was called, and key and values for the dev understand what is happening in the logic of the class, and where it is.<br>
![Alt text](assets/image.png)
![Alt text](assets/image-1.png)

## <b id='what-happen'>I. What happened?</b>
<pre>
<b>1. Class name:</b> As the method was called from executed anonymous block (developer console), its name appeared in the log message.
<b>2. Method name:</b> As the method was called out of a method, nothing appeared in the method name.
<b>3. Line number:</b> As the method was called from the first line, the first line was showed in the log message.
</pre>

## <b id='main-methods'>II. Main methods</b>

### <b id='log-1'>a. log()</b>
<pre>
<b>→ Obs:</b> This method call a debug log message with basic information as showed above but, we will present it called from a simple class here.
</pre>
&emsp;<b>[Screen shoots]</b>
<br>&emsp;![Alt text](assets/image-5.png)
&emsp;![Alt text](assets/image-6.png)
&emsp;![Alt text](assets/image-2.png)
<pre>
<b>→ Explanation:</b> In the screen shoots above we can see the key points easily, as 'class name', 'method name', and 'line number', but it is the most simple sample here.
</pre>
<hr></hr>

### <b id='log-2'>b. log(Object key, Object value)</b>
<pre>
<b>→ Obs:</b> Here, we start to add some complexity to the debug logs. We can add lines, and this lines ('key → values') to see the result of some proccessment, or see what is happening insed the code.
<b>→ Obs²:</b> As the parameters are of type <b>Object</b>, it can accept any type of values, as SObject, maps, lists, and any other primitive or complex types.
</pre>
&emsp;<b>[Screen shoots]</b>
<br>&emsp;![Alt text](assets/image-3.png)
&emsp;![Alt text](assets/image-4.png)
<pre>
<b>→ Explanation:</b>
1. The 'key' value is presented as an key in the message to identify the value you want to see.
2. The 'value' is presented to visualize what is saved inside the variable.
</pre>
<hr></hr>

### <b id='log-3'>c. log(Exception e)</b>
<pre>
<b>→ Obs:</b> This is my favorite one. Every dev format a exception message with his own pattern, what make the code different, and can add alot of lines to the project, but this method format the message with a single and easy pattern that help to undertand the key points.
</pre>
&emsp;<b>[Screen shoots]</b>
<br>&emsp;![Alt text](assets/image-7.png)
&emsp;![Alt text](assets/image-8.png)
<pre>
<b>→ Explanation:</b>
1. In the message, a new section called 'Exception Data' is created, displaying what is important.
2. With this, we can implement exception log as simple, clear and fast as possible.
</pre>
<hr></hr>

### <b id='log-4'>d. log(Map&lt;Object, Object&gt; debugMap)</b>
<pre>
<b>→ Obs:</b> Passing a Map&lt;Object, Object&gt; , where the key map is the 'key' in the message, and the value map, is the 'value' in the message, we can log alot of values to see all we want easly.
</pre>
&emsp;<b>[Screen shoots]</b>
<br>&emsp;![Alt text](assets/image-9.png)
&emsp;![Alt text](assets/image-10.png)
<pre>
<b>→ Explanation:</b> Every '• key → value' use a different line to be displayed.
</pre>
<hr></hr>

### <b id='log-5'>e. log(Map&lt;Object, Object&gt; debugMap, Exception e)</b>
<pre>
<b>→ Obs:</b> And we can combine the useful with the pleasant to present both the data that were used and the data of the exception generated to understand what happened.
</pre>
&emsp;<b>[Screen shoots]</b>
<br>&emsp;![Alt text](assets/image-11.png)
&emsp;![Alt text](assets/image-12.png)
<pre>
<b>→ Explanation:</b> We can send at same time a key value map, with the exception threw to see everything easly.
</pre>
<hr></hr>

## <b id='important-details'>III. Important details</b>
• Some times, we try to log long messages, that some times can be hidden by developer log, or the log itself when opened in a IDE or text editor, but with this class, i prepared a break line function to break long values message, using a <b>Regex expression</b>, based in line size, and that use a default <b>Break simbol</b>, that can be customized using a set method. By default:
<pre>
<b>→ The split character simbol:</b> A comma (,)
<b>→ The minimum and max size to break a line (a space to try to find a split character):</b> Min: 340 | Max: 400
<b>→ Default regex expression:</b> (?<=\\G.{340,400}),
</pre>

### <b id='setting-tip'>a. You can use set methods to change custom settings:</b>
<h4>Warning:</h4>

```diff
-Be carefull! Some complex, and long strings with a long split lenght (min → max) can generate a 'to complex regex' exception.
```

<h4 id="customize-settings">a. Customize settings</h4>
<pre>
<b>→ setMinSplitLenght</b>
<b>→ setMaxSplitLenght</b>
<b>→ setCharacterSplitSignal</b>
</pre>

<h4 id="serialize-values">b. Serialize values</h4>
• You can use a method to change the breakline to a serializiation, where the code stops to break line and convert the value to a JSON, where sometimes we can see all the line.
<pre>
<b>→ serializeLog</b>
</pre>

<h4 id="flow-settings">c. Flow settings</h4>
<br>• Every customization is reseted after the end of the proccess to log the data by a method inside the proccess called <b>'cleanInstanceVariables'</b>. So if you want to customize, you will need to change defaults again.

## <b id='other-methods'>IV. Other methods</b>

### <b id='start'>a. start()</b>
<pre>
<b>→ Obs:</b> This method is used in the place of 'log()' method without parameters. The difference between this two methos is only a aditional message showed indicating that the method you want to analize is 'starting...'.
</pre>
&emsp;<b>[Screen shoots]</b>
<br>&emsp;![Alt text](assets/image-13.png)
&emsp;![Alt text](assets/image-14.png)
<pre>
<b>→ Explanation:</b> Add a aditional information saying the method analised is starting.
</pre>
<hr></hr>

### <b id='end'>b. end()</b>
<pre>
<b>→ Obs:</b> Equals to the start, but is used to be placed in the end of the method.
</pre>
&emsp;<b>[Screen shoots]</b>
<br>&emsp;![Alt text](assets/image-15.png)
&emsp;![Alt text](assets/image-16.png)
<pre>
<b>→ Explanation:</b> Add a aditional information saying the method analised is ending.
</pre>
<hr></hr>

### <b id='set-start'>c. setStart()</b>
<pre>
<b>→ Obs:</b> You can use 'setStart()' method to add this additional message in a more complex log, to analyse for example parameters that the method received and its values when starting the method.
</pre>
&emsp;<b>[Screen shoots]</b>
<br>&emsp;![Alt text](assets/image-17.png)
&emsp;![Alt text](assets/image-18.png)
&emsp;![Alt text](assets/image-19.png)
<pre>
<b>→ Explanation:</b> Add a aditional information to a more complex log, saying the method analised is starting.
</pre>
<hr></hr>

### <b id='set-end'>d. setEnd()</b>
<pre>
<b>→ Obs:</b> You can use 'setEnd()' method to add this additional message in a more complex log, to analyse for example parameters when the method is ending, and see what happened during proccessment.
</pre>
&emsp;<b>[Screen shoots]</b>
<br>&emsp;![Alt text](assets/image-20.png)
&emsp;![Alt text](assets/image-21.png)
&emsp;![Alt text](assets/image-22.png)
<pre>
<b>→ Explanation:</b> Add a aditional information to a more complex log, saying the method analised is ending.
</pre>
