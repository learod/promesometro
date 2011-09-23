(function($,undefined){var rails;$.rails=rails={linkClickSelector:'a[data-confirm], a[data-method], a[data-remote]',selectChangeSelector:'select[data-remote]',formSubmitSelector:'form',formInputClickSelector:'form input[type=submit], form input[type=image], form button[type=submit], form button:not([type])',disableSelector:'input[data-disable-with], button[data-disable-with], textarea[data-disable-with]',enableSelector:'input[data-disable-with]:disabled, button[data-disable-with]:disabled, textarea[data-disable-with]:disabled',requiredInputSelector:'input[name][required]:not([disabled]),textarea[name][required]:not([disabled])',fileInputSelector:'input:file',CSRFProtection:function(xhr){var token=$('meta[name="csrf-token"]').attr('content');if(token)xhr.setRequestHeader('X-CSRF-Token',token);},fire:function(obj,name,data){var event=$.Event(name);obj.trigger(event,data);return event.result!==false;},confirm:function(message){return confirm(message);},ajax:function(options){return $.ajax(options);},handleRemote:function(element){var method,url,data,crossDomain=element.data('cross-domain')||null,dataType=element.data('type')||($.ajaxSettings&&$.ajaxSettings.dataType);if(rails.fire(element,'ajax:before')){if(element.is('form')){method=element.attr('method');url=element.attr('action');data=element.serializeArray();var button=element.data('ujs:submit-button');if(button){data.push(button);element.data('ujs:submit-button',null);}}else if(element.is('select')){method=element.data('method');url=element.data('url');data=element.serialize();if(element.data('params'))data=data+"&"+element.data('params');}else{method=element.data('method');url=element.attr('href');data=element.data('params')||null;}
options={type:method||'GET',data:data,dataType:dataType,crossDomain:crossDomain,beforeSend:function(xhr,settings){if(settings.dataType===undefined){xhr.setRequestHeader('accept','*/*;q=0.5, '+settings.accepts.script);}
return rails.fire(element,'ajax:beforeSend',[xhr,settings]);},success:function(data,status,xhr){element.trigger('ajax:success',[data,status,xhr]);},complete:function(xhr,status){element.trigger('ajax:complete',[xhr,status]);},error:function(xhr,status,error){element.trigger('ajax:error',[xhr,status,error]);}};if(url){$.extend(options,{url:url});}
rails.ajax(options);}},handleMethod:function(link){var href=link.attr('href'),method=link.data('method'),csrf_token=$('meta[name=csrf-token]').attr('content'),csrf_param=$('meta[name=csrf-param]').attr('content'),form=$('<form method="post" action="'+href+'"></form>'),metadata_input='<input name="_method" value="'+method+'" type="hidden" />';if(csrf_param!==undefined&&csrf_token!==undefined){metadata_input+='<input name="'+csrf_param+'" value="'+csrf_token+'" type="hidden" />';}
form.hide().append(metadata_input).appendTo('body');form.submit();},disableFormElements:function(form){form.find(rails.disableSelector).each(function(){var element=$(this),method=element.is('button')?'html':'val';element.data('ujs:enable-with',element[method]());element[method](element.data('disable-with'));element.attr('disabled','disabled');});},enableFormElements:function(form){form.find(rails.enableSelector).each(function(){var element=$(this),method=element.is('button')?'html':'val';if(element.data('ujs:enable-with'))element[method](element.data('ujs:enable-with'));element.removeAttr('disabled');});},allowAction:function(element){var message=element.data('confirm'),answer=false,callback;if(!message){return true;}
if(rails.fire(element,'confirm')){answer=rails.confirm(message);callback=rails.fire(element,'confirm:complete',[answer]);}
return answer&&callback;},blankInputs:function(form,specifiedSelector,nonBlank){var inputs=$(),input,selector=specifiedSelector||'input,textarea';form.find(selector).each(function(){input=$(this);if(nonBlank?input.val():!input.val()){inputs=inputs.add(input);}});return inputs.length?inputs:false;},nonBlankInputs:function(form,specifiedSelector){return rails.blankInputs(form,specifiedSelector,true);},stopEverything:function(e){$(e.target).trigger('ujs:everythingStopped');e.stopImmediatePropagation();return false;},callFormSubmitBindings:function(form){var events=form.data('events'),continuePropagation=true;if(events!==undefined&&events['submit']!==undefined){$.each(events['submit'],function(i,obj){if(typeof obj.handler==='function')return continuePropagation=obj.handler(obj.data);});}
return continuePropagation;}};$.ajaxPrefilter(function(options,originalOptions,xhr){if(!options.crossDomain){rails.CSRFProtection(xhr);}});$(rails.linkClickSelector).live('click.rails',function(e){var link=$(this);if(!rails.allowAction(link))return rails.stopEverything(e);if(link.data('remote')!==undefined){rails.handleRemote(link);return false;}else if(link.data('method')){rails.handleMethod(link);return false;}});$(rails.selectChangeSelector).live('change.rails',function(e){var link=$(this);if(!rails.allowAction(link))return rails.stopEverything(e);rails.handleRemote(link);return false;});$(rails.formSubmitSelector).live('submit.rails',function(e){var form=$(this),remote=form.data('remote')!==undefined,blankRequiredInputs=rails.blankInputs(form,rails.requiredInputSelector),nonBlankFileInputs=rails.nonBlankInputs(form,rails.fileInputSelector);if(!rails.allowAction(form))return rails.stopEverything(e);if(blankRequiredInputs&&form.attr("novalidate")==undefined&&rails.fire(form,'ajax:aborted:required',[blankRequiredInputs])){return rails.stopEverything(e);}
if(remote){if(nonBlankFileInputs){return rails.fire(form,'ajax:aborted:file',[nonBlankFileInputs]);}
if(!$.support.submitBubbles&&rails.callFormSubmitBindings(form)===false)return rails.stopEverything(e);rails.handleRemote(form);return false;}else{setTimeout(function(){rails.disableFormElements(form);},13);}});$(rails.formInputClickSelector).live('click.rails',function(event){var button=$(this);if(!rails.allowAction(button))return rails.stopEverything(event);var name=button.attr('name'),data=name?{name:name,value:button.val()}:null;button.closest('form').data('ujs:submit-button',data);});$(rails.formSubmitSelector).live('ajax:beforeSend.rails',function(event){if(this==event.target)rails.disableFormElements($(this));});$(rails.formSubmitSelector).live('ajax:complete.rails',function(event){if(this==event.target)rails.enableFormElements($(this));});})(jQuery);$.extend({show_milestone_comments:function(){$('.hito_header').click(function(){visible=$('.hito_content:visible').attr('id');$('.hito_content').slideUp(600);number=$(this).attr('id').substr(12)
content=$('#hito_content_'+number);if(visible!=content.attr('id')){content.slideDown(600);}})},do_comment:function(){$('#do_comment').click(function(){$('.post_comment').toggle();return false;});}});$(document).ready(function(){$.show_milestone_comments();$.do_comment();});