
#Fix modal mobile Boostrap 3
Show = (id) ->

    #Fix CSS
    $(".modal-footer").css
        padding: "19px 20px 20px"
        "margin-top": "15px"
        "text-align": "right"
        "border-top": "1px solid #e5e5e5"

    $(".modal-body").css "overflow-y", "auto"

    #Fix .modal-body height
    $("#" + id).on "shown.bs.modal", ->
        $("#" + id + ">.modal-dialog>.modal-content>.modal-body").css "height", "auto"
        h1 = $("#" + id + ">.modal-dialog").height()
        h2 = $(window).height()
        h3 = $("#" + id + ">.modal-dialog>.modal-content>.modal-body").height()
        h4 = h2 - (h1 - h3)
        if $(window).width() >= 768
            $("#" + id + ">.modal-dialog>.modal-content>.modal-body").height h4  if h1 > h2
            $("#" + id + ">.modal-dialog").css "margin", "30px auto"
            $("#" + id + ">.modal-dialog>.modal-content").css "border", "1px solid rgba(0,0,0,0.2)"
            $("#" + id + ">.modal-dialog>.modal-content").css "border-radius", 6
            if $("#" + id + ">.modal-dialog").height() + 30 > h2
                $("#" + id + ">.modal-dialog").css "margin-top", "0px"
                $("#" + id + ">.modal-dialog").css "margin-bottom", "0px"
        else

            #Fix full-screen in mobiles
            $("#" + id + ">.modal-dialog>.modal-content>.modal-body").height h4
            $("#" + id + ">.modal-dialog").css "margin", 0
            $("#" + id + ">.modal-dialog>.modal-content").css "border", 0
            $("#" + id + ">.modal-dialog>.modal-content").css "border-radius", 0

        #Aply changes on screen resize (example: mobile orientation)
        window.onresize = ->
            $("#" + id + ">.modal-dialog>.modal-content>.modal-body").css "height", "auto"
            h1 = $("#" + id + ">.modal-dialog").height()
            h2 = $(window).height()
            h3 = $("#" + id + ">.modal-dialog>.modal-content>.modal-body").height()
            h4 = h2 - (h1 - h3)
            if $(window).width() >= 768
                $("#" + id + ">.modal-dialog>.modal-content>.modal-body").height h4  if h1 > h2
                $("#" + id + ">.modal-dialog").css "margin", "30px auto"
                $("#" + id + ">.modal-dialog>.modal-content").css "border", "1px solid rgba(0,0,0,0.2)"
                $("#" + id + ">.modal-dialog>.modal-content").css "border-radius", 6
                if $("#" + id + ">.modal-dialog").height() + 30 > h2
                    $("#" + id + ">.modal-dialog").css "margin-top", "0px"
                    $("#" + id + ">.modal-dialog").css "margin-bottom", "0px"
            else

                #Fix full-screen in mobiles
                $("#" + id + ">.modal-dialog>.modal-content>.modal-body").height h4
                $("#" + id + ">.modal-dialog").css "margin", 0
                $("#" + id + ">.modal-dialog>.modal-content").css "border", 0
                $("#" + id + ">.modal-dialog>.modal-content").css "border-radius", 0
            return

        return


    #Free event listener
    $("#" + id).on "hide.bs.modal", ->
        window.onresize = ->

        return


    #Mobile haven't scrollbar, so this is touch event scrollbar implementation
    y1 = 0
    y2 = 0
    div = $("#" + id + ">.modal-dialog>.modal-content>.modal-body")[0]
    div.addEventListener "touchstart", (event) ->
        y1 = event.touches[0].clientY
        return

    div.addEventListener "touchmove", (event) ->
        event.preventDefault()
        y2 = event.touches[0].clientY
        limite = div.scrollHeight - div.clientHeight
        diff = div.scrollTop + y1 - y2
        diff = 0  if diff < 0
        diff = limite  if diff > limite
        div.scrollTop = diff
        y1 = y2
        return


    #Fix position modal, scroll to top.
    $("html, body").scrollTop 0

    #Show
    $("#" + id).modal "show"
    return
$("#button-modal").click ->
    Show "modal-id"
    return
