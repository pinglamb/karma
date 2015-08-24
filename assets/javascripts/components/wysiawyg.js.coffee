class @Wysiawyg
  dataURIToBlob = (dataURI) ->
    byteString = if dataURI.split(',')[0].indexOf('base64') >= 0
      atob dataURI.split(',')[1]
    else
      unescape dataURI.split(',')[1]
    mimeString = dataURI.split(',')[0].split(':')[1].split(';')[0]
    ia = new Uint8Array(byteString.length)
    ia[i] = byteString.charCodeAt(i) for i in [0..(byteString.length-1)]
    new Blob [ia], type: mimeString

  constructor: (dom) ->
    @dom = $(dom)
    @uploadURL = @dom.data('upload-url')
    @dom.aceWysiwyg()
    @dom.on 'image-inserted', => @uploadImages()

    input = $(@dom.data('target'))
    @dom.closest('form').on 'submit', =>
      input.val(@dom.cleanHtml())

  uploadImages: ->
    indicator = @dom.siblings('.image-upload-indicator')
    imagesToUpload = @dom.find("img[src^='data:image']:not([data-uploading]):not([data-uploaded])")
    console.log imagesToUpload.length
    imagesToUpload.each (i, img) =>
      img = $(img)
      img.attr('data-uploading', true)

      # Extract file extension
      base64Data = img.attr('src')
      extension = base64Data.match(/^data:image\/(.*);base64/i)[1]

      # Prepare data for submission
      blob = dataURIToBlob(base64Data)
      data = new FormData()
      data.append 'attachment[image]', blob, "image.#{extension}"

      indicator.removeClass('hidden')
      $.ajax
        url: @uploadURL
        type: 'POST'
        data: data
        processData: false
        contentType: false
        success: (json) ->
          if json.attachment?
            img.attr('src', json.attachment.url)
            img.attr('data-uploaded', true)
            img.removeAttr('data-uploading')
            indicator.addClass('hidden')

$(document).on 'ready page:load', ->
  $(".wysiwyg-editor").each ->
    new Wysiawyg($(this))
