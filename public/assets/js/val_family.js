function validate_per(entry,mess){
	// First name - Required and only alphabets
	fname = $(entry).find('.fname');
	if (fname.val() == ''){
		mess.push('<li>Enter first name of this person');
	}
	else{
		var reg =/^[a-zA-Z]+$/;
		if (!reg.test(fname.val())){
			mess.push('<li>First name can only contain alphabets')
		}
	}///// END first name

	// Last name - Required and only alphabets
	lname = $(entry).find('.lname');
	if (lname.val() == ''){
		mess.push('<li>Enter last name of this person');
	}
	else{
		var reg =/^[a-zA-Z]+$/;
		if (!reg.test(lname.val())){
			mess.push('<li>Last name can only contain alphabets')
		}
	}///// END Last name

	/// Mobile Number - If mobilenumber then 10 digit - Not mandatory field
	mob = $(entry).find('.mobilenum');
	if (mob.val() != ''){
		var reg =/^\d{10}$/;
		if (!reg.test(mob.val())){
			mess.push('<li>Mobile Number must be a 10 digit number')
		}
	}
	///// END Mobile 	

	// ADULT - FEMALE - PREGANT - Reminder Enabled - then mobile required
	adult = $(entry).find('.adult_child');
	gender = $(entry).find('.gender_sel');
	preg = $(entry).find('.preg_select');
	rem = $(entry).find('.rem_select');
	//alert("Adult"+adult.val()+"Gender"+gender.val()+"Preg"+preg.val()+"rem"+rem.val());
	if(adult.val()==1 && gender.val() == 'f' && preg.val() == 1 && rem.val()==1){
		if (mob.val() == ''){
			mess.push('<li>Mobile Number is REQUIRED as reminders are enabled');
		}
	}
	//END

	return mess.length // return the number of errors
}

function onSubmitForm(){
	
	var mess_fam = []; // Stores errors family the family box
	var tot_count = 0;  // Stores the total number of errors
	var form = $(this);
	
	// Family box validation
	if (form.find('#family_village').val() == ""){
		mess_fam.push('<li>Enter a Village name');
	}
	if (form.find('#family_cardNum').val() == ""){
		mess_fam.push('<li>Enter a Card Number for family');
	}
	
	/// END Family entries validation
	
	tot_count += mess_fam.length;
	
	// Individual validation
	var x = form.find('.per_ex')
	var i = x.length-1;
	var mess = new Array(i);

	for (i;i>=0;i--){
		mess[i] = new Array();
		tot_count += validate_per(x[i],mess[i]);
	}
	// END Individual validation


	// Show error boxes
	var fam_err_box = form.find('#fam_error')
	if (mess_fam.length != 0)
	{	fam_err_box.hide();
		fam_err_box.html('');
		fam_err_box.append(mess_fam);
		fam_err_box.show('50');
	}
	else{
		fam_err_box.hide();
		fam_err_box.html('');
	}
	
	// For persons
	var i = x.length-1;
	for (i;i>=0;i--){
		var box = $(x[i]).find(".per_error_box");
		if(mess[i].length != 0)
		{	box.hide();
			box.html('');
			box.append(mess[i]);
			box.show('50');
		}
		else{
			box.hide();
			box.html('');
		}
	}
	// End error boxes


	if (tot_count == 0) {return true;}
	else {return false;}
}



// Binding 
$(function(){
	$('#new_family').bind('submit',onSubmitForm);
});