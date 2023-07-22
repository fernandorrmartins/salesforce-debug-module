/*********************************************************************************************************************************************************************
@description:	Classe de teste para classe de apoio a debug.
@author:		Fernando Rodrigues Ribeiro Martins
@date:			2023-03-06
**********************************************************************************************************************************************************************/
@isTest
class DebugTest {
    private static final String className = 'DebugTest';

    @isTest
    static void startTest() {
        String message = Debug.getInstance().start();
        Assert.isTrue(message.contains(Debug.MESSAGE_START_METHOD));
    }

    @isTest
    static void setStartTest() {
        Debug debugInstance = Debug.getInstance().setStart();
        Assert.areEqual(
            Debug.MESSAGE_START_METHOD,
            debugInstance.informationalMessage
        );
        debugInstance.cleanInstanceVariables();
        Assert.areEqual(
            Debug.CHARACTER_EMPTY,
            debugInstance.informationalMessage
        );
    }

    @isTest
    static void endTest() {
        String message = Debug.getInstance().end();
        Assert.isTrue(message.contains(Debug.MESSAGE_END_METHOD));
    }

    @isTest
    static void setEndTest() {
        Debug debugInstance = Debug.getInstance().setEnd();
        System.assert(
            Debug.MESSAGE_END_METHOD.equals(debugInstance.informationalMessage)
        );
        debugInstance.cleanInstanceVariables();
        System.assert(
            Debug.CHARACTER_EMPTY.equals(debugInstance.informationalMessage)
        );
    }

    @isTest
    static void setMinSplitLenghtTest() {
        Integer minSplitLenght = 10;
        Debug.getInstance().setMinSplitLenght(minSplitLenght);
        System.assertEquals(minSplitLenght, Debug.getInstance().minSplitLenght);
    }

    @isTest
    static void setMaxSplitLenghtTest() {
        Integer maxSplitLenght = 20;
        Debug.getInstance().setMaxSplitLenght(maxSplitLenght);
        System.assertEquals(maxSplitLenght, Debug.getInstance().maxSplitLenght);
    }

    @isTest
    static void setCharacterSplitSignalTest() {
        String splitSignal = '/';
        Debug debugInstance = Debug.getInstance()
            .setCharacterSplitSignal(splitSignal);
        System.assert(splitSignal.equals(debugInstance.characterSplitSignal));
        debugInstance.cleanInstanceVariables();
        System.assert(
            Debug.CHARACTER_SPLIT_SIGNAL.equals(
                debugInstance.characterSplitSignal
            )
        );
    }

    @isTest
    static void cleanInstanceVariablesTest() {
        String splitSignal = ';';
        Debug debugInstance = Debug.getInstance()
            .setStart()
            .setCharacterSplitSignal(splitSignal);
        System.assert(splitSignal.equals(debugInstance.characterSplitSignal));
        System.assert(
            Debug.MESSAGE_START_METHOD.equals(
                debugInstance.informationalMessage
            )
        );
        debugInstance.cleanInstanceVariables();
        System.assert(
            Debug.CHARACTER_SPLIT_SIGNAL.equals(
                debugInstance.characterSplitSignal
            )
        );
        System.assert(
            Debug.CHARACTER_EMPTY.equals(debugInstance.informationalMessage)
        );
    }

    @isTest
    static void getClassMethodNameLineTest() {
        String methodName = 'getClassMethodNameLineTest';
        String classMethodNameLine = Debug.getInstance()
            .getClassMethodNameLine();
        System.assert(classMethodNameLine.contains(DebugTest.className));
        System.assert(classMethodNameLine.contains(methodName));
    }

    @isTest
    static void getClassNameTest() {
        String className = Debug.getInstance().getClassName();
        System.assert(DebugTest.className.equals(className));
    }

    @isTest
    static void getMethodNameTest() {
        String methodNameStr = 'getMethodNameTest';
        String methodName = Debug.getInstance().getMethodName();
        System.assert(methodNameStr.equals(methodNameStr));
    }

    @isTest
    static void getLineNumberTest() {
        /* lineNumberStr need be the line where the method 'Debug.getInstance().getLineNumber()' is called. */
        String lineNumberStr = '110';
        String lineNumber = Debug.getInstance().getLineNumber();
        System.assert(lineNumberStr.equals(lineNumber));
    }

    @isTest
    static void getMessageTest() {
        String className = 'className';
        String methodName = 'methodName';
        String lineNumber = '000';
        String bodyMessage = 'bodyMessage';
        Debug debugInstance = Debug.getInstance();
        String message = debugInstance.getMessage(
            className,
            methodName,
            lineNumber,
            bodyMessage
        );
        System.assert(message.contains(className));
        System.assert(message.contains(methodName));
        System.assert(message.contains(lineNumber));
        System.assert(message.contains(bodyMessage));
    }

    @isTest
    static void serializeLogTest() {
        String methodName = 'serializeLogTest';
        String accountName = 'serializeLogTest Name';
        Account record = new Account(Name = accountName);
        String logMessage = Debug.getInstance()
            .serializeLog()
            .log('Account', record);
        System.assert(logMessage.contains(DebugTest.className));
        System.assert(logMessage.contains(methodName));
        System.assert(logMessage.contains(accountName));
    }

    @isTest
    static void setBreakLinesTest() {
        String methodName = 'breakLinesTest';
        String accountName = 'breakLinesTest Name';
        Account record = new Account(Name = accountName);
        String logMessage = Debug.getInstance()
            .setMinSplitLenght(30)
            .setMaxSplitLenght(50)
            .serializeLog()
            .setBreakLines()
            .log('Account', record);
        System.assert(logMessage.contains(DebugTest.className));
        System.assert(logMessage.contains(methodName));
        System.assert(logMessage.contains(accountName));
        System.assert(logMessage.contains('\n'));
    }

    @isTest
    static void logTest() {
        String methodName = 'logTest';
        String logMessage = Debug.getInstance().log();
        System.assert(logMessage.contains(DebugTest.className));
        System.assert(logMessage.contains(methodName));
    }

    @isTest
    static void log2Test() {
        String methodName = 'log2Test';
        String key = 'key';
        String value = 'value';
        String logMessage = Debug.getInstance().log(key, value);
        System.assert(logMessage.contains(DebugTest.className));
        System.assert(logMessage.contains(methodName));
        System.assert(logMessage.contains(key));
        System.assert(logMessage.contains(value));
    }

    @isTest
    static void logExceptionTest() {
        try {
            throw new DebugTestException();
        } catch (DebugTestException e) {
            String logMessage = Debug.getInstance().log(e);
            System.assert(
                logMessage.contains(String.valueOf(DebugTestException.class))
            );
        }
    }

    @isTest
    static void getBodyMessageTest() {
        Integer number1 = 1;
        Integer number2 = 2;
        String key = 'acc';
        Id accountId = DebugTest.generateFakeId(
            Schema.Account.getSObjectType()
        );
        Account accountRecord = new Account(Id = accountId);
        Map<Object, Object> toLogMap = new Map<Object, Object>{
            1 => 2,
            key => accountRecord
        };
        String bodyMessage = Debug.getInstance().getBodyMessage(toLogMap);
        System.assert(
            bodyMessage.contains(
                String.valueOf(number1) + ' → ' + String.valueOf(number2)
            )
        );
        System.assert(bodyMessage.contains(key));
        System.assert(bodyMessage.contains(accountId));
    }

    @isTest
    static void getKeyValueLineTest() {
        String key = 'key for test';
        Id accountId = DebugTest.generateFakeId(
            Schema.Account.getSObjectType()
        );
        Account accountRecord = new Account(Id = accountId);
        String sobjectName = accountRecord.getSobjectType()
            .getDescribe()
            .getName();
        String keyValueLine = Debug.getInstance()
            .getKeyValueLine(key, accountRecord);
        System.assert(keyValueLine.contains(key));
        System.assert(keyValueLine.contains(sobjectName));
        System.assert(keyValueLine.contains(accountId));
    }

    @isTest
    static void validateMinAndMaxSplitSizeTest() {
        Debug.getInstance().setMinSplitLenght(1);
        Debug.getInstance().setMaxSplitLenght(3);
        Boolean valid = Debug.getInstance().validateMinAndMaxSplitSize();
        System.assert(valid);
        Debug.getInstance().setMinSplitLenght(3);
        Debug.getInstance().setMaxSplitLenght(1);
        Boolean valid2 = Debug.getInstance().validateMinAndMaxSplitSize();
        System.assert(!valid2);
        Debug.getInstance().setMinSplitLenght(null);
        Debug.getInstance().setMaxSplitLenght(null);
        Boolean valid3 = Debug.getInstance().validateMinAndMaxSplitSize();
        System.assert(!valid3);
        Debug.getInstance().setMinSplitLenght(1);
        Debug.getInstance().setMaxSplitLenght(null);
        Boolean valid4 = Debug.getInstance().validateMinAndMaxSplitSize();
        System.assert(!valid4);
        Debug.getInstance().setMinSplitLenght(null);
        Debug.getInstance().setMaxSplitLenght(3);
        Boolean valid5 = Debug.getInstance().validateMinAndMaxSplitSize();
        System.assert(!valid5);
    }

    @isTest
    static void setMinMaxSplitLenghtRegexTest() {
        String regex = Debug.getInstance().setMinMaxSplitLenghtRegex(10, 20);
        System.assert(regex.contains(String.valueOf(10)));
        System.assert(regex.contains(String.valueOf(20)));
    }

    @isTest
    static void breakLinesTest() {
        String treatText = 'text';
        String treatedText2 = Debug.getInstance().breakLines(treatText);
        System.assert(treatedText2.equals(treatText));

        String bigText =
            ''.center(Debug.GREAT_SIZE_LINE_MIN, 'a') +
            ',' +
            ''.center(Debug.GREAT_SIZE_LINE_MIN, 'b') +
            ',oi';
        String treatedText = Debug.getInstance().breakLines(bigText);
        System.assert(treatedText.contains(Debug.TITLE_BREAK_GREAT_LINES));
        System.assert(
            treatedText.contains(
                Debug.CHARACTER_SPLIT_SIGNAL + Debug.CHARACTER_BREAK_LINE
            )
        );

        List<String> textSplited = treatedText.split(
            Debug.CHARACTER_BREAK_LINE
        );
        for (String text : textSplited) {
            System.assert(text.length() <= Debug.GREAT_SIZE_LINE_MAX);
        }
    }

    public static Id generateFakeId(Schema.SObjectType sobj) {
        Id fakeId = null;
        if (sobj != null) {
            fakeId = String.format(
                '{0}{1}{1}{2}',
                new List<String>{
                    sobj.getDescribe().getKeyPrefix(),
                    '00',
                    String.valueOf(System.now().getTime()).substring(0, 8)
                }
            );
        }
        return fakeId;
    }

    class DebugTestException extends Exception {
    }
}
