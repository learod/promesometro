# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
window.promesa ||= {}

$(document).ready ->
  $('.promesa .field.type > input[type=radio]').live 'change', ->
    $this = $(this)
    klass = $this.val().toLowerCase()
    $parent = $this.parents('.prueba')
    
    fields_to_hide = $parent.find('.field:not(.type):not(.'+klass+')')
    fields_to_hide.hide()
    fields_to_hide.find('input, textarea').attr('disabled',true)
    
    field_to_show = $parent.find('.field.'+klass)
    field_to_show.find('input, textarea').removeAttr('disabled')
    field_to_show.show()
    
promesa.upload_template = null
    
promesa.add_prueba = (tipo) ->
  $pruebas = $('#pruebas')
  ctx = {count: $pruebas.find('fieldset.prueba').size()}
  ctx[recurso] = tipo == recurso for recurso in ['link','imagen','archivo','video','mapa']
  if !promesa.upload_template
    promesa.upload_template = $('#prueba_upload_template')
      .html().replace(/_0_/g,'_{{count}}_').replace(/\[0\]/g,'[{{count}}]')
  $pruebas.append $ Mustache.render promesa.upload_template, ctx

promesa.remove_prueba = ($prueba) ->
  $prueba.find('input, textarea').attr('disabled',true)
  $prueba.remove()
  
jQuery ($) ->
  $('.seguir a[data-type=html], .reclamar a[data-type=html]').parent().on 'ajax:success', (event, data, status, xhr) ->
    $(this).html data
  $('.responder form[data-remote=true]').on 'ajax:success', (event, data, status, xhr) ->
    #alert($(this).parents('.responder').parents('.comment').find('.thread:first').html())
    $(this).parent('.responder').parent('.comment').find('.thread:first').prepend $(data)
  $('.comentar form[data-remote=true]').on 'ajax:success', (event, data, status, xhr) ->
    $(this).parents('.comentar').siblings('.comentarios').prepend $(data)
