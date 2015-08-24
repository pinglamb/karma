class @CategoriesPicker
  constructor: (dom) ->
    @dom = $(dom)
    @url = @dom.data("url")

    @categories = @dom.find("select#deal_category_ids")
    @sections   = @dom.find("select#deal_section_ids")
    @tags       = @dom.find("select#deal_tag_ids")

    @categories.on 'change', => @filterSectionsOptions()
    @sections.on 'change', => @filterTagsOptions()

    @filterSectionsOptions()
    @filterTagsOptions()

  filterSectionsOptions: ->
    $
      .ajax
        url: @url
        data:
          category_ids: @categories.val()
      .done (html) =>
        sectionIds = @sections.val()
        @sections.html(html)
        @sections.val(sectionIds)
        @sections.change()

  filterTagsOptions: ->
    $
      .ajax
        url: @url
        data:
          section_ids: @sections.val()
      .done (html) =>
        tagIds = @tags.val()
        @tags.html(html)
        @tags.val(tagIds)


$(document).on 'ready page:load', ->
  $(".categories-picker").each ->
    new CategoriesPicker(this)
