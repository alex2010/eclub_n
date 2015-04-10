define [
    'underscore'
    '/lib/exObj.js'
], (_) ->

    printObj: (obj, name, indent, depth) ->
        return indent + name + ": <Maximum Depth Reached>\n"  if depth > 10
        name = (if name then name else "Object")
        indent = (if indent then indent else "\t")
        depth = (if depth then depth else 1)
        if typeof obj is "object"
            child = undefined
            output = indent + name + "\n"
            indent += "\t"
            for item of obj
                try
                    child = obj[item]
                catch e
                    child = "<Unable to Evaluate>"
                if typeof child is "object"
                    output += mlu.printObj(child, item, indent, depth + 1)
                else
                    output += indent + item + ": " + child + "\n"
            output
        else
            obj

    renderObj: (obj, cap, meta)->
        t = $('<table class="table table-striped table-bordered"/>')
        if cap
            t.append("<caption>#{v}</caption>")
        for k,v of obj
            tr = $('<tr/>')
            tr.append("<th>#{meta['data::' + k].label}</th>")
            tr.append("<td>#{v}</td>")
            t.append tr
        t
