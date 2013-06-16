
  function removeclickeddiv(){
    $(this).parent().remove();
  }
  
  function genderchange(){
    var val = $(this).val();
    
    adult_child = $(this).parent().find(".adult_child")
    if (val == "f" && adult_child.val() == 1)
    {
      $(this).parent().find('.iffemale_div').show();  
    }
    else
    {
      $(this).parent().find('.iffemale_div').hide();
    }

  }
  function adult_child_change(){
    var gensel = $(this).parent().find('.gender_sel');
     var val = $(this).val();
     if (val == 1 && gensel.val() =='f' )
    {
      $(this).parent().find('.iffemale_div').show();  
    }
    else
    {
      $(this).parent().find('.iffemale_div').hide();
    }
  }
  function pregchange(){
    var val = $(this).val();
    if (val == "1")
    {
      $(this).parent().find('.dt_select').show(); 
    }
    else
    {
      $(this).parent().find('.dt_select').hide();
    }
  }

  function setUpFields(entry){


      var firstgensel = $(entry).find('.gender_sel');
      if (firstgensel.val() == 'm'){firstgensel.parent().find('.iffemale_div').hide();}
      firstgensel.bind('change',genderchange);
      //
      var first_preg_select = $(entry).find('.preg_select');
      if (first_preg_select.val() == 0){first_preg_select.parent().find('.dt_select').hide(); }
      first_preg_select.bind('change',pregchange);

      var adult_child = $(entry).find('.adult_child');
      if (adult_child.val() == 0){adult_child.parent().find('.iffemale_div').hide(); }
      adult_child.bind('change',adult_child_change);

      $(entry).find('.removediv').bind('click',removeclickeddiv);
  }


  /// End functions
  
$(function() {  

 // Setup all per_ex fields
 var form = $('#new_family');
  var x = form.find('.per_ex');
  var i = x.length-1;

  for (i;i>=0;i--){
    setUpFields(x[i]);
  }
  // END  Setup all per_ex fields


  // Initial First person div settings 
  $('#firstinfodiv > .removediv').hide();



});









$("#btn_add").click(function() { 
    
     var $repeatDiv = jQuery(".per_ex:last");
     var id = "repeatDiv" + new Date().getTime();
     var x = $repeatDiv.clone().attr("id",id );
     
      x.find('input').each(function() {
      var input = $(this);
      name = input.attr('name');
      nid = input.attr('id');
      a = name.replace(/(persons\[)(\d+)(\])/, function(f, p1, p2, p3) {return p1 + (parseInt(p2) + 1) + p3;})
      b = nid.replace(/(persons_)(\d+)(_)/, function(f, p1, p2, p3) {return p1 + (parseInt(p2) + 1) + p3;})
      input.attr('name',a)
      input.attr('id',b)
      });

      x.find('select').each(function() {
      var input = $(this);
      name = input.attr('name');
      nid = input.attr('id');
      a = name.replace(/(persons\[)(\d+)(\])/, function(f, p1, p2, p3) {return p1 + (parseInt(p2) + 1) + p3;})
      b = nid.replace(/(persons_)(\d+)(_)/, function(f, p1, p2, p3) {return p1 + (parseInt(p2) + 1) + p3;})
      input.attr('name',a)
      input.attr('id',b)

      });
      x.find('.removediv').show();
      x.find('.removediv').bind('click',removeclickeddiv);

      // Bindings
      var gensel = x.find('.gender_sel');
      if (gensel.val() == 'm'){gensel.parent().find('.iffemale_div').hide();}
      gensel.bind('change',genderchange);
      //
      var preg_select = x.find('.preg_select');
    if (preg_select.val() == 0){preg_select.parent().find('.dt_select').hide(); }
    preg_select.bind('change',pregchange);
      // end bindings

      $repeatDiv.after(x);
     
  });