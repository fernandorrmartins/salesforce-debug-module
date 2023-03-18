/*********************************************************************************************************************************************************************
@description:	Classe de teste para classe de apoio a debug.
@author:		Fernando Rodrigues Ribeiro Martins
@date:			2023-03-06
**********************************************************************************************************************************************************************/
public without sharing class Debug
{
    /* Static Variables */
    @TestVisible
    private static final Integer GREAT_SIZE_LINE_MIN            = 340;
    @TestVisible
    private static final Integer GREAT_SIZE_LINE_MAX            = 400;
    @TestVisible
    private static final String TITLE_BREAK_GREAT_LINES         = ' Great line ';
    @TestVisible
    private static final String TITLE_END_GREAT_LINES           = ' End g. line ';
    @TestVisible
    private static final String TITLE_EXCEPTION                 = ' Exception Data ';
    @TestVisible
    private static final String PATTERN_BODY_LINE               = ' • {0} → {1}';
    @TestVisible
    private static final String PATTERN_SPLIT_CLASS_METHOD      = 'Class.';
    @TestVisible
    private static final String PATTERN_SPLIT_TRIGGER_METHOD    = 'Trigger.';
    @TestVisible
    private static final String PATTERN_OWN_DEBUG_CLASS         = 'Class.Debug.';
    @TestVisible
    private static final String CHARACTER_DOT                   = '.';
    @TestVisible
    private static final String CHARACTER_DOUBLE_DOT            = ':';
    @TestVisible
    private static final String REGEX_SPLIT_SIZE_LENGH_COMMA    = '(?<=\\G.{param1,param2})param3';
    @TestVisible
    private static final String CHARACTER_EMPTY                 = '';
    @TestVisible
    private static final String CHARACTER_BREAK_LINE            = '\n';
    @TestVisible
    private static final String CHARACTER_SPLIT_SIGNAL          = ',';
    @TestVisible
    private static final String DIVISION_CHARACTER_DEBUG        = '#';
    @TestVisible
    private static final String DIVISION_CHARACTER_LINE         = '=';
    @TestVisible
    private static final String MESSAGE_START_METHOD            = 'Method start...';
    @TestVisible
    private static final String MESSAGE_END_METHOD              = 'Method end...';
    @TestVisible
    private static final String MESSAGE_BODY                    = '\nClass name: {0}\nMethod name: {1}{2}{3}';
    @TestVisible
    private static final String MESSAGE_BODY_DETAIL             = '\nDetail: ';
    @TestVisible
    private static final String MESSAGE_BODY_MESSAGE             = '\nMessage:\n';
    @TestVisible
    private static final String MESSAGE_FORMAT
    {
        private set;
        private get {
            if(String.isBlank(Debug.MESSAGE_FORMAT))
			{
                Debug.MESSAGE_FORMAT =
                    Debug.CHARACTER_BREAK_LINE + Debug.CHARACTER_EMPTY.center(Debug.GREAT_SIZE_LINE_MAX, Debug.DIVISION_CHARACTER_DEBUG) +
                    Debug.MESSAGE_BODY +
                    Debug.CHARACTER_BREAK_LINE + Debug.CHARACTER_EMPTY.center(Debug.GREAT_SIZE_LINE_MAX, Debug.DIVISION_CHARACTER_DEBUG);
            }
            return Debug.MESSAGE_FORMAT;
        }
    }
    @TestVisible
    private static final Debug INSTANCE
    {
        private set;
        private get
        {
            if(Debug.INSTANCE == null){ Debug.INSTANCE = new Debug(); }
            return Debug.INSTANCE;
        }
    }

    /* Instance Variables */
    @TestVisible
    private Integer minSplitLenght = null;
    @TestVisible
    private Integer maxSplitLenght = null;
    @TestVisible
    private Boolean serializeLog = false;
    @TestVisible
    private Boolean breakLines = true;
    @TestVisible
    private String informationalMessage = Debug.CHARACTER_EMPTY;
    @TestVisible
    private String characterSplitSignal
    {
        private set;
        private get {
            if(String.isBlank(this.characterSplitSignal))
            {
                this.characterSplitSignal = Debug.CHARACTER_SPLIT_SIGNAL;
            }
            return characterSplitSignal;
        }
    }

    private Debug() {}
    
    public static Debug getInstance()
    {
        return Debug.INSTANCE;
    }

    public String start()
    {
        this.setStart();
        return this.log();
    }

    public Debug setStart()
    {
        this.informationalMessage = Debug.MESSAGE_START_METHOD;
        return this;
    }

    public String end()
    {
        this.setEnd();
        return this.log();
    }

    public Debug setEnd()
    {
        this.informationalMessage = Debug.MESSAGE_END_METHOD;
        return this;
    }

    public Debug setMinSplitLenght(Integer minSplitLenght)
    {
        this.minSplitLenght = minSplitLenght;
        return this;
    }

    public Debug setMaxSplitLenght(Integer maxSplitLenght)
    {
        this.maxSplitLenght = maxSplitLenght;
        return this;
    }

    public Debug setCharacterSplitSignal(String characterSignal)
    {
        this.characterSplitSignal = characterSignal;
        return this;
    }

    public Debug cleanInstanceVariables()
    {
        this.serializeLog = false;
        this.breakLines = true;
        this.minSplitLenght = null;
        this.maxSplitLenght = null;
        this.characterSplitSignal = Debug.CHARACTER_EMPTY;
        this.informationalMessage = Debug.CHARACTER_EMPTY;
        return this;
    }

    public Debug serializeLog()
    {
        this.serializeLog = true;
        this.breakLines = false;
        return this;
    }

    public Debug setBreakLines()
    {
        this.breakLines = true;
        return this;
    }

    public String log(Object key, Object value)
    {
        String bodyMessage = this.getKeyValueLine(key, value);
        return this.log(bodyMessage);
    }

    public String log()
    {
        return this.log(new Map<Object,Object>());
    }

    public String log(Exception e) {
        return this.log(new Map<Object, Object>(), e);
    }

    public String log(Map<Object, Object> debugMap, Exception e) {
        String debugLine =  Debug.DIVISION_CHARACTER_LINE.leftPad(30, DIVISION_CHARACTER_LINE);
        debugMap.put('', String.format('{0}{1}{2}', new String[] { debugLine, Debug.TITLE_EXCEPTION, debugLine }));
        debugMap.put('TypeName', e.getTypeName());
        debugMap.put('LineNumber', String.valueOf(e.getLineNumber()));
        debugMap.put('Cause', String.valueOf(e.getCause()));
        debugMap.put('Message', e.getMessage());
        debugMap.put('StackTraceString', e.getStackTraceString());
        return this.log(debugMap);
    }

    public String log(Map<Object, Object> debugMap)
    {
        String bodyMessage = this.getBodyMessage(debugMap);
        return this.log(bodyMessage);
    }

    public String log(String bodyMessage)
    {
        String message = this.prepareLogMessage(bodyMessage);
        this.cleanInstanceVariables();
        System.debug(System.LoggingLevel.DEBUG, message);
        return message;
    }

    @TestVisible
    private String prepareLogMessage(String bodyMesage)
    {
        String className = this.getClassName();
        String methodName = this.getMethodName();
        String message = this.getMessage(className, methodName, bodyMesage);
        return message;
    }

    @TestVisible
    private String getClassMethodNameLine()
    {
        String stacktraceString = new DmlException().getStackTraceString();
        List<String> lines = stacktraceString.split(Debug.CHARACTER_BREAK_LINE);
        String line = Debug.CHARACTER_EMPTY;
        if(!lines.isEmpty())
        {
            for(String lineStr : lines)
            {
                if(String.isNotBlank(lineStr) && !lineStr.contains(Debug.PATTERN_OWN_DEBUG_CLASS))
                {
                    line = lineStr;
                    break;
                }
            }
        }
        return this.cleanClassMethodNameLine(line);
    }

    @TestVisible
    private String cleanClassMethodNameLine(String line)
    {
        line = String.isNotBlank(line) ? line.replace(Debug.PATTERN_SPLIT_CLASS_METHOD, Debug.CHARACTER_EMPTY) : line;
        line = String.isNotBlank(line) ? line.replace(Debug.PATTERN_SPLIT_TRIGGER_METHOD, Debug.CHARACTER_EMPTY) : line;
        return line;
    }

    public String getClassName()
    {
        String line = this.getClassMethodNameLine();
        String classPattern = Debug.PATTERN_SPLIT_CLASS_METHOD;
        return line.substringBefore(Debug.CHARACTER_DOUBLE_DOT).substringBeforeLast(Debug.CHARACTER_DOT);
    }

    public String getMethodName()
    {
        String line = this.getClassMethodNameLine();
        return line.substringBefore(Debug.CHARACTER_DOUBLE_DOT).substringAfterLast(Debug.CHARACTER_DOT);
    }

    public String getMessage(String className, String methodName, String bodyMessage)
    {
        String message = String.format(
            Debug.MESSAGE_FORMAT,
            new String[] {
                className, methodName,
                String.isNotBlank(this.informationalMessage) ? Debug.MESSAGE_BODY_DETAIL + this.informationalMessage : Debug.CHARACTER_EMPTY,
                String.isNotBlank(bodyMessage) ? Debug.MESSAGE_BODY_MESSAGE + bodyMessage : Debug.CHARACTER_EMPTY
            }
        );
        return message;
    }

    public String getBodyMessage(Map<Object, Object> debugMap)
    {
        List<String> bodyPeaces = new List<String>();
        if(debugMap != null)
        {
            for(Object key : debugMap.keySet())
            {
                Object value = debugMap.get(key);
                String bodyLine = this.getKeyValueLine(key, value);
                bodyPeaces.add(bodyLine);
            }
        }
        String bodyMessage = String.join(bodyPeaces, Debug.CHARACTER_BREAK_LINE);
        return bodyMessage;
    }

    public String getKeyValueLine(Object key, Object value)
    {
        String keyStr = String.valueOf(key);
        String valueStr = this.serializeLog ? JSON.serialize(value) : String.valueOf(value);
        valueStr = this.breakLines ? this.breakLines(valueStr) : valueStr;
        String keyValueLine = String.format(Debug.PATTERN_BODY_LINE, new List<String> { keyStr, valueStr });
        return keyValueLine;
    }

    @TestVisible
    private Boolean validateMinAndMaxSplitSize()
    {
        Boolean validMinAndMax =
            minSplitLenght != null && this.maxSplitLenght != null &&
            minSplitLenght > 0 && this.maxSplitLenght > 0 && minSplitLenght < this.maxSplitLenght;
        return validMinAndMax;
    }

    @TestVisible
    private String setMinMaxSplitLenghtRegex(Integer min, Integer max)
    {
        String regex = Debug.REGEX_SPLIT_SIZE_LENGH_COMMA
            .replace('param1', String.valueOf(min))
            .replace('param2', String.valueOf(max))
            .replace('param3', this.characterSplitSignal);
        return regex;
    }

    public String breakLines(String text)
    {
        Boolean validMinAndMax = this.validateMinAndMaxSplitSize();
        minSplitLenght = validMinAndMax ? minSplitLenght : GREAT_SIZE_LINE_MIN;
        maxSplitLenght = validMinAndMax ? maxSplitLenght : GREAT_SIZE_LINE_MAX;
        String splitRegex = this.setMinMaxSplitLenghtRegex(minSplitLenght, maxSplitLenght);
        Boolean needBreak = String.isNotBlank(text) && text.length() > minSplitLenght;
        List<String> splitedText = needBreak ? text.split(splitRegex) : new List<String> { text };
        text = needBreak ?
            Debug.CHARACTER_BREAK_LINE + Debug.TITLE_BREAK_GREAT_LINES.center(GREAT_SIZE_LINE_MAX, Debug.DIVISION_CHARACTER_LINE) + Debug.CHARACTER_BREAK_LINE +
            String.join(splitedText, this.characterSplitSignal + Debug.CHARACTER_BREAK_LINE) +
            Debug.CHARACTER_BREAK_LINE + Debug.TITLE_END_GREAT_LINES.center(GREAT_SIZE_LINE_MAX, Debug.DIVISION_CHARACTER_LINE) :
            text;
        return text;
    }
}