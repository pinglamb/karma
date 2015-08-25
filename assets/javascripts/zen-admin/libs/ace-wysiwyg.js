(function(a, b) {
    a.fn.ace_colorpicker = function(c) {
        var click_event = $.fn.tap ? "tap" : "click";
        var d = a.extend({pull_right: false,caret: true}, c);
        this.each(function() {
            var g = a(this);
            var e = "";
            var f = "";
            a(this).hide().find("option").each(function() {
                var h = "colorpick-btn";
                if (this.selected) {
                    h += " selected";
                    f = this.value
                }
                e += '<li><a class="' + h + '" href="#" style="background-color:' + this.value + ';" data-color="' + this.value + '"></a></li>'
            }).end().on("change.ace_inner_call", function() {
                a(this).next().find(".btn-colorpicker").css("background-color", this.value)
            }).after('<div class="dropdown dropdown-colorpicker"><a data-toggle="dropdown" class="dropdown-toggle" href="#"><span class="btn-colorpicker" style="background-color:' + f + '"></span></a><ul class="dropdown-menu' + (d.caret ? " dropdown-caret" : "") + (d.pull_right ? " pull-right" : "") + '">' + e + "</ul></div>").next().find(".dropdown-menu").on(click_event, function(j) {
                var h = a(j.target);
                if (!h.is(".colorpick-btn")) {
                    return false
                }
                h.closest("ul").find(".selected").removeClass("selected");
                h.addClass("selected");
                var i = h.data("color");
                g.val(i).change();
                j.preventDefault();
                return true
            })
        });
        return this
    }
})(window.jQuery);

(function(a, b) {
    a.fn.aceWysiwyg = function(c, h) {
        var click_event = $.fn.tap ? "tap" : "click";
        var d = a.extend({speech_button: true,wysiwyg: {}}, c);
        var e = ["#ac725e", "#d06b64", "#f83a22", "#fa573c", "#ff7537", "#ffad46", "#42d692", "#16a765", "#7bd148", "#b3dc6c", "#fbe983", "#fad165", "#92e1c0", "#9fe1e7", "#9fc6e7", "#4986e7", "#9a9cff", "#b99aff", "#c2c2c2", "#cabdbf", "#cca6ac", "#f691b2", "#cd74e6", "#a47ae2", "#444444"];
        var g = {font: {values: ["Arial", "Courier", "Comic Sans MS", "Helvetica", "Open Sans", "Tahoma", "Verdana"],icon: "fa-font",title: "Font"},fontSize: {values: {5: "Huge",3: "Normal",1: "Small"},icon: "fa-text-height",title: "Font Size"},bold: {icon: "fa-bold",title: "Bold (Ctrl/Cmd+B)"},italic: {icon: "fa-italic",title: "Italic (Ctrl/Cmd+I)"},strikethrough: {icon: "fa-strikethrough",title: "Strikethrough"},underline: {icon: "fa-underline",title: "Underline"},insertunorderedlist: {icon: "fa-list-ul",title: "Bullet list"},insertorderedlist: {icon: "fa-list-ol",title: "Number list"},outdent: {icon: "fa-dedent",title: "Reduce indent (Shift+Tab)"},indent: {icon: "fa-indent",title: "Indent (Tab)"},justifyleft: {icon: "fa-align-left",title: "Align Left (Ctrl/Cmd+L)"},justifycenter: {icon: "fa-align-center",title: "Center (Ctrl/Cmd+E)"},justifyright: {icon: "fa-align-right",title: "Align Right (Ctrl/Cmd+R)"},justifyfull: {icon: "fa-align-justify",title: "Justify (Ctrl/Cmd+J)"},createLink: {icon: "fa-link",title: "Hyperlink",button_text: "Add",placeholder: "URL",button_class: "btn-primary"},unlink: {icon: "fa-unlink",title: "Remove Hyperlink"},insertImage: {icon: "fa-picture-o",title: "Insert picture",button_text: '<i class="fa-file"></i> Choose Image &hellip;',placeholder: "Image URL",button_insert: "Insert",button_class: "btn-success",button_insert_class: "btn-primary",choose_file: true},foreColor: {values: e,title: "Change Color"},backColor: {values: e,title: "Change Background Color"},undo: {icon: "fa-undo",title: "Undo (Ctrl/Cmd+Z)"},redo: {icon: "fa-repeat",title: "Redo (Ctrl/Cmd+Y)"},viewSource: {icon: "fa-code",title: "View Source"}};
        var f = d.toolbar || [/*"font", null, "fontSize", null, */"bold", "italic", "strikethrough", "underline", null, "insertunorderedlist", "insertorderedlist", "outdent", "indent", null, "justifyleft", "justifycenter", "justifyright", "justifyfull", null, "createLink", "unlink", null, "insertImage", null, /*"foreColor", null,*/"undo", "redo", null, "viewSource"];
        this.each(function() {
            var r = ' <div class="wysiwyg-toolbar btn-toolbar wysiwyg-style1" data-role="editor-toolbar"> <div class="btn-group"> ';
            for (var n in f) {
                if (f.hasOwnProperty(n)) {
                    var p = f[n];
                    if (p === null) {
                        r += ' </div> <div class="btn-group"> ';
                        continue
                    }
                    if (typeof p == "string" && p in g) {
                        p = g[p];
                        p.name = f[n]
                    } else {
                        if (typeof p == "object" && p.name in g) {
                            p = a.extend(g[p.name], p)
                        } else {
                            continue
                        }
                    }
                    var q = "className" in p ? p.className : "";
                    switch (p.name) {
                        case "font":
                            r += ' <a class="btn btn-sm ' + q + ' dropdown-toggle" data-toggle="dropdown" title="' + p.title + '"><i class="fa ' + p.icon + '"></i><i class="fa fa-angle-down icon-on-right"></i></a> ';
                            r += ' <ul class="dropdown-menu dropdown-light">';
                            for (var j in p.values) {
                                if (p.values.hasOwnProperty(j)) {
                                    r += ' <li><a data-edit="fontName ' + p.values[j] + '" style="font-family:\'' + p.values[j] + "'\">" + p.values[j] + "</a></li> "
                                }
                            }
                            r += " </ul>";
                            break;
                        case "fontSize":
                            r += ' <a class="btn btn-sm ' + q + ' dropdown-toggle" data-toggle="dropdown" title="' + p.title + '"><i class="fa ' + p.icon + '"></i>&nbsp;<i class="fa fa-angle-down icon-on-right"></i></a> ';
                            r += ' <ul class="dropdown-menu dropdown-light"> ';
                            for (var t in p.values) {
                                if (p.values.hasOwnProperty(t)) {
                                    r += ' <li><a data-edit="fontSize ' + t + '"><font size="' + t + '">' + p.values[t] + "</font></a></li> "
                                }
                            }
                            r += " </ul> ";
                            break;
                        case "createLink":
                            r += ' <div class="inline position-relative"> <a class="btn btn-sm ' + q + ' dropdown-toggle" data-toggle="dropdown" title="' + p.title + '"><i class="fa ' + p.icon + '"></i></a> ';
                            r += ' <div class="dropdown-menu dropdown-caret pull-right">							<div class="input-group">								<input class="form-control" placeholder="' + p.placeholder + '" type="text" data-edit="' + p.name + '" />								<span class="input-group-btn">									<button class="btn ' + p.button_class + '" type="button">' + p.button_text + "</button>								</span>							</div>						</div> </div>";
                            break;
                        case "insertImage":
                            r += ' <div class="inline position-relative"> <a class="btn btn-sm ' + q + ' dropdown-toggle" data-toggle="dropdown" title="' + p.title + '"><i class="fa ' + p.icon + '"></i></a> ';
                            r += ' <div class="dropdown-menu dropdown-caret pull-right">							<div class="input-group">								<input class="form-control" placeholder="' + p.placeholder + '" type="text" data-edit="' + p.name + '" />								<span class="input-group-btn">									<button class="btn ' + p.button_insert_class + '" type="button">' + p.button_insert + "</button>								</span>							</div>";
                            if (p.choose_file && "FileReader" in window) {
                                r += '<div class="space-2"></div>							 <div class="center">								<button class="btn btn-sm ' + p.button_class + ' wysiwyg-choose-file" type="button">' + p.button_text + '</button>								<input type="file" data-edit="' + p.name + '" />							  </div>'
                            }
                            r += " </div> </div>";
                            break;
                        case "foreColor":
                        case "backColor":
                            r += ' <select class="hide wysiwyg_colorpicker" title="' + p.title + '"> ';
                            for (var m in p.values) {
                                r += ' <option value="' + p.values[m] + '">' + p.values[m] + "</option> "
                            }
                            r += " </select> ";
                            r += ' <input style="display:none;" disabled class="hide" type="text" data-edit="' + p.name + '" /> ';
                            break;
                        case "viewSource":
                            r += ' <a class="btn btn-sm ' + q + '" data-view="source" title="' + p.title + '"><i class="fa ' + p.icon + '"></i></a> ';
                            break;
                        default:
                            r += ' <a class="btn btn-sm ' + q + '" data-edit="' + p.name + '" title="' + p.title + '"><i class="fa ' + p.icon + '"></i></a> ';
                            break
                    }
                }
            }
            r += " </div> </div> ";
            if (d.toolbar_place) {
                r = d.toolbar_place.call(this, r)
            } else {
                r = a(this).before(r).prev()
            }
            r.find("a[title]").tooltip({animation: false,container: "body"});
            r.find(".dropdown-menu input:not([type=file])").on(click_event, function() {
                return false
            }).on("change", function() {
                a(this).closest(".dropdown-menu").siblings(".dropdown-toggle").dropdown("toggle")
            }).on("keydown", function(u) {
                if (u.which == 27) {
                    this.value = "";
                    a(this).change()
                }
            });
            r.find("input[type=file]").prev().on(click_event, function(u) {
                a(this).next().click()
            });
            r.find(".wysiwyg_colorpicker").each(function() {
                a(this).ace_colorpicker({pull_right: true}).change(function() {
                    a(this).nextAll("input").eq(0).val(this.value).change()
                }).next().find(".btn-colorpicker").tooltip({title: this.title,animation: false,container: "body"})
            });
            var k;
            if (d.speech_button && "onwebkitspeechchange" in (k = document.createElement("input"))) {
                var i = a(this).offset();
                r.append(k);
                a(k).attr({type: "text","data-edit": "inserttext","x-webkit-speech": ""}).addClass("wysiwyg-speech-input").css({position: "absolute"}).offset({top: i.top,left: i.left + a(this).innerWidth() - 35})
            } else {
                k = null
            }
            var s = a(this);
            var l = false;
            r.find("a[data-view=source]").on("click", function(v) {
                v.preventDefault();
                if (!l) {
                    a("<textarea />").css({width: s.outerWidth(),height: s.outerHeight()}).val(s.html()).insertAfter(s);
                    s.hide();
                    a(this).addClass("active")
                } else {
                    var u = s.next();
                    s.html(u.val()).show();
                    u.remove();
                    a(this).removeClass("active")
                }
                l = !l
            });
            var o = a.extend({}, {activeToolbarClass: "active",toolbarSelector: r}, d.wysiwyg || {});
            a(this).wysiwyg(o)
        });
        return this
    }
})(window.jQuery);
