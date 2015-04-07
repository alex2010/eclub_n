_.extend String::,
    trim: ->
        @replace /^\s+|\s+$/g, ""
    capitalize: ->
        @trim().substring(0, 1).toUpperCase() + @trim().substring(1)
    startsWith: (pattern) ->
        @lastIndexOf(pattern, 0) is 0
    endsWith: (pattern) ->
        d = @length - pattern.length
        d >= 0 and @indexOf(pattern, d) is d
    isEmpty: ->
        this.length is 0 || this is " " || (/^\s*$/).test(this)
    replaceAll: (s1, s2)->
        this.replace(new RegExp(s1, "gm"), s2);
    truncate: (length, truncation) ->
        length = length or 30
        truncation = (if Object.isUndefined(truncation) then "..." else truncation)
        (if @length > length then @slice(0, length - truncation.length) + truncation else String(this))
    fileName: ->
        @substr(@lastIndexOf('/') + 1)


_.extend Date::,

    isSameDay: (d) ->
        @getFullYear() is d.getFullYear() and @getMonth is d.getMonth and @getDate() is d.getDate()
    addDays: (d) ->
        if d
            t = @getTime()
            t = t + (d * 86400000)
            @setTime t
        @
    nextWeekDay: (day) ->
        @addDays (day + 7 - @getDay()) % 7
    firstDayOfMonth: ->
        new Date(@getFullYear(), @getMonth(), 1)
    lastDayOfMonth: ->
        new Date(@getFullYear(), @getMonth() + 1, 1).addDays -1
    monday: ->
        if @getDay() > 0
            @addDays(1 - @getDay())
        else
            @addDays(1 - 7)

    sunday: ->
        if @getDay() > 0
            @addDays(7 - @getDay())
        else
            @

    nextMonth: ->
        new Date(@getFullYear(), @getMonth() + 1, 1);
    lastMonth: ->
        new Date(@getFullYear(), @getMonth() - 1, 1);

Date.parseLocal = (time) ->
    time = time.substring(0, 19) if time.length > 19
    new Date((time or "").replace(/-/g, "/").replace(/[TZ]/g, " "))


`Date.prototype.pattern = function (fmt) {
    var o = {
        "Y+": this.getFullYear(), //年
        "M+": this.getMonth() + 1, //月份
        "d+": this.getDate(), //日
        "h+": this.getHours() % 12 == 0 ? 12 : this.getHours() % 12, //小时
        "H+": this.getHours(), //小时
        "m+": this.getMinutes(), //分
        "s+": this.getSeconds(), //秒
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度
        "S": this.getMilliseconds() //毫秒
    };
    var week = {
        "0": "\u65e5",
        "1": "\u4e00",
        "2": "\u4e8c",
        "3": "\u4e09",
        "4": "\u56db",
        "5": "\u4e94",
        "6": "\u516d"
    };
    if (/(y+)/.test(fmt)) {
        fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    }
    if (/(E+)/.test(fmt)) {
        fmt = fmt.replace(RegExp.$1, ((RegExp.$1.length > 1) ? (RegExp.$1.length > 2 ? "\u661f\u671f" : "\u5468") : "") + week[this.getDay() + ""]);
    }
    for (var k in o) {
        if (new RegExp("(" + k + ")").test(fmt)) {
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        }
    }
    return fmt;
}`