
$(document).ready(function(){
  	$('.profile-tab-selector .profile-area').on('click', function(e){
  		e.preventDefault;
		$this = $(this);

		ProfileArea = '#' + $this.attr('data-profile-area');
		$('.content-manager > div').removeClass('active');
		$(ProfileArea).addClass('active');

		$('.profile-tab-selector .profile-area').removeClass('active');
		$this.addClass('active');
	});
});