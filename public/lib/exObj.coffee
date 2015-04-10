define ['backbone'], (Backbone) ->
    String::trim = ->
        @replace /^\s+|\s+$/g, ""
    String::capitalize = ->
        @trim().substring(0, 1).toUpperCase() + @trim().substring(1)
    String::startsWith = (pattern) ->
        @lastIndexOf(pattern, 0) is 0
    String::endsWith = (pattern) ->
        d = @length - pattern.length
        d >= 0 and @indexOf(pattern, d) is d
    String::isEmpty = ->
        this.length is 0 || this is " " || (/^\s*$/).test(this)
    String::replaceAll = (s1, s2)->
        this.replace(new RegExp(s1, "gm"), s2);
    String::truncate = (length, truncation) ->
        length = length or 30
        truncation = (if Object.isUndefined(truncation) then "..." else truncation)
        (if @length > length then @slice(0, length - truncation.length) + truncation else String(this))
    String::fileName = ->
        @substr(@lastIndexOf('/') + 1)
    Function::getName = ->
        s = Function::getName.caller.toString()
        (if /function\s+([^\s\(]+)/i.test(s) then RegExp.$1 else "anonymous ")
    Date::isSameDay = (d) ->
        @getFullYear() is d.getFullYear() and @getMonth is d.getMonth and @getDate() is d.getDate()
    Date::addDays = (d) ->
        if d
            t = @getTime()
            t = t + (d * 86400000)
            @setTime t
        @
    Date::nextWeekDay = (day) ->
        @addDays (day + 7 - @getDay()) % 7
    Date::firstDayOfMonth = ->
        new Date(@getFullYear(), @getMonth(), 1)
    Date::lastDayOfMonth = ->
        new Date(@getFullYear(), @getMonth() + 1, 1).addDays -1
    Date::monday = ->
        if @getDay() > 0
            @addDays(1 - @getDay())
        else
            @addDays(1 - 7)

    Date::sunday = ->
        if @getDay() > 0
            @addDays(7 - @getDay())
        else
            @

    Date::nextMonth = ->
        new Date(@getFullYear(), @getMonth() + 1, 1);
    Date::lastMonth = ->
        new Date(@getFullYear(), @getMonth() - 1, 1);
    Number::toOrdinal = ->
        n = this % 100
        suffix = [ "th", "st", "nd", "rd", "th" ]
        ord = (if n < 21 then (if n < 4 then suffix[n] else suffix[0]) else (if n % 10 > 4 then suffix[0] else suffix[n % 10]))
        this + ord

    Number::toPaddedString = (length, radix) ->
        string = @toString(radix or 10)
        "0".times(length - string.length) + string

    Number::formatMoney = (cc, c = 2, d = '.', t = ',') ->
        cc = cf._curCode || '$'
        n = this
        s = (if n < 0 then " -" else "")
        i = parseInt(n = Math.abs(+n or 0).toFixed(c)) + ""
        j = (if (j = i.length) > 3 then j % 3 else 0)
        cc + s + ((if j then i.substr(0, j) + t else "")) + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + ((if c then d + Math.abs(n - i).toFixed(c).slice(2) else ""))

    Array::findOrCreate = (prop, val)->
        for it in @
            return it if it[prop] is val
        it = {}
        it[prop] = val
        @push it
        it
    `
    Date.prototype.pattern=function (fmt) {
            var o = {
                "Y+":this.getFullYear(), //年
                "M+":this.getMonth() + 1, //月份
                "d+":this.getDate(), //日
                "h+":this.getHours() % 12 == 0 ? 12 : this.getHours() % 12, //小时
                "H+":this.getHours(), //小时
                "m+":this.getMinutes(), //分
                "s+":this.getSeconds(), //秒
                "q+":Math.floor((this.getMonth() + 3) / 3), //季度
                "S":this.getMilliseconds() //毫秒
            };
            var week = {
                "0":"\u65e5",
                "1":"\u4e00",
                "2":"\u4e8c",
                "3":"\u4e09",
                "4":"\u56db",
                "5":"\u4e94",
                "6":"\u516d"
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
        }
    $.extend(Array.prototype, {
            clear:function () {
                this.length = 0;
                return this;
            },

            first:function () {
                return this[0];
            },

            last:function () {
                return this[this.length - 1];
            },

            each:function (iterator, context) {
                var i = this.length;
                while (i--)
                    iterator.call(context, i, this[i]);
                return this;
            },
            has:function (val) {
                var i = this.length;
                while (i--)
                    if (val == this[i])
                        return true;
                return false;
            },
            cross:function (arr) {
                var i = this.length;
                while (i--)
                    if (arr.has(this[i])) return true;
                return false;
            },
            collect:function (iterator, context) {
                var results = [];
                for (var i = 0; i < this.length; i++)
                    results.push(iterator.call(context, i, this[i]));
                return results;
            },
            include:function (value) {
                for (var i = 0; i < this.length; i++)
                    if (this[i] == value) return true;
                return false;
            },
            includeBy:function (prop, val) {
                var i = this.length;
                while (i--)
                    if (val == this[i][prop]) return true;
                return false;
            },
            /**
             * find val in array
             * @param val
             */
            detect:function (val,nv) {
                for (var i = 0; i < this.length; i++)
                    if (this[i] == val){
                        if(nv) this[i] = nv
                        return this[i];
                    }
                return null;
            },
            /**
             * remove obj in array with the same id
             * @param id
             */
            del:function (id) {
                for (var i = 0; i < this.length; i++)
                    if (this[i].id == id) {
                        this.splice(i, 1);
                        return this[i];
                    }
                return null;
            },
            /**
             * remove val in array
             * @param val
             */
            remove:function (val) {
                for (var i = 0; i < this.length; i++)
                    if (this[i] == val) {
                        this.splice(i, 1);
                        return val;
                    }
                return null;
            },
            /**
             * remove obj in array with the prop val
             * @param val
             */
            delBy:function (prop, val) {
                for (var i = 0; i < this.length; i++)
                    if ((prop.indexOf('.') > 0 ? seqProp(this[i], prop) : this[i][prop]) == val) {
                        this.splice(i, 1);
                        return this[i];
                    }
                return null;
            },
            detectBy:function (prop, val) {
                for (var i = 0; i < this.length; i++)
                    if ((prop.indexOf('.') > 0 ? seqProp(this[i], prop) : this[i][prop]) == val)
                        return this[i];
                return null;
            },
            /**
             * find obj in array by id
             * @param id
             */
            find:function (id) {
                for (var i = 0; i < this.length; i++)
                    if (this[i].id && this[i].id.toString() == id) {
                        return this[i];
                    }
                return null;
            },
            /**
             * find obj in array with prop val
             * @param prop
             * @param val
             */
            findBy:function (prop, val) {
                for (var i = 0; i < this.length; i++)
                    if ((prop.indexOf('.') > 0 ? seqProp(this[i], prop) : this[i][prop]) == val)
                        return this[i];
                return null;
            },
            findAllBy:function (prop, val) {
                var res = [];
                for (var i = 0; i < this.length; i++) {
                    if ((prop.indexOf('.') > 0 ? seqProp(this[i], prop) : this[i][prop]) == val)
                        res.push(this[i]);
                }
                return res;
            },

            /**
             * replace obj in array by item with id
             * @param data
             * @param item
             */
            replaceById:function (item) {
                for (var i = 0; i < this.length; i++) {
                    if (this[i].id == item.id)
                        this[i] = item;
                }
            },
            sortBy:function (attr, isAsc) {
                this.sort(function (a, b) {

                    if (isAsc)
                        return a[attr] < b[attr] ? -1 : 1;
                    else
                        return a[attr] > b[attr] ? -1 : 1;
                });
                return this;
            },
            pushById:function (obj) {
                if (this.detectBy('id', obj.id))
                    return;
                else this.push(obj)
            },
            addUniq: function(val){
                if(!this.has(val))
                    this.push(val)
            }

        }
    );
    $.extend({
        moveTo:function (settings) {
            settings = $.extend({
                pos:'body',
                time:500,
                offset:0
            }, settings || {});
            return this;
        }
    });
    `
    Array::addOrUpdate = (item, key = 'id')->
        find = false
        for it in @
            if it[key] is item[key]
                @[_i] = item
                find = true
                break
        @push item unless find

    Array::concatBy = (next, key, func)->
        for it in next
            d = @findBy(key, it[key])
            if d
                func(d, it) if func
            else @push it
        @
    Array::recSet = (sub = 'children',fun)->
        for it in @
            fun(it)
            it[sub].recSet(sub,fun) if _.isArray it[sub]

    Array::recFind = (sub, val, prop = 'id')->
        for it in @
            if it[prop] is val
                return it
            if _.isArray it[sub]
                r = it[sub].recFind(sub,val,prop)
                return r if r
        return null

#            recFindById:function (sub, val, name) {
#    name = name || 'id'
#        for (var i = 0; i < this.length; i++) {
#        if (this[i][name] == val)
#            return this[i];
#        if (_.isArray(this[i][sub]))
#            var res = this[i][sub].recFindById(sub, val,name);
#            if(res)
#                return res;
#        }
#        return null;
#        },


    #backbone enhance
    Backbone.View::_super = (act) ->
        @constructor.__super__[act].apply @, _.rest(arguments)

    Backbone.View::_over = (act) ->
        @constructor::[act].apply @, _.rest(arguments)

    Backbone.View::reRender = ->
        @$el.empty()
        @render()

    Backbone.View::close = ->
        @remove()
        @dPlugin?()
        @unbind()
        @undelegateEvents()
        @stopListening()
        @onClose?()

    $.fn.serializeObject = ->
        o = {}
        $.each @serializeArray(), ->
            if o[@name]?
                o[@name] = [o[@name]]  unless o[@name].push
                o[@name].push @value or ""
            else
                o[@name] = @value or ""
            return
        o
    $.postJSON = (url, data, success, error)->
        $.ajax
            type: "POST"
            url: url
            data: util.tStr data
            contentType: "application/json; charset=utf-8"
            dataType: "JSON"
            success: success
            error: error

    #backbone/jquery enhance
#    $.fn.view = ->
#        el = $(this).closest("[data-view-cid]")
#        el and Thorax._viewsIndexedByCid[el.attr("data-view-cid")]
#
#    $.fn.model = (view) ->
#        $this = $(this)
#        modelElement = $this.closest("[data-model-cid]")
#        modelCid = modelElement and modelElement.attr("[data-model-cid]")
#        if modelCid
#            view = $this.view()
#            return view and view.model
#        false




#        /**
#             * find obj in array by id recursive
#             * @param sub
#             * @param val
#             */
#        recFindById:function (sub, val, name) {
#    name = name || 'id'
#        for (var i = 0; i < this.length; i++) {
#        if (this[i][name] == val)
#            return this[i];
#        if (_.isArray(this[i][sub]))
#            var res = this[i][sub].recFindById(sub, val,name);
#            if(res)
#                return res;
#        }
#        return null;
#        },