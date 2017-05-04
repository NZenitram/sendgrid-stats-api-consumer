var $window = $(window)
$stickyEl = $('#graphs-header');
elTop = $stickyEl.offset().top;

$(window).scroll(function() {
  $stickyEl.toggleClass('sticky', $window.scrollTop() > elTop);
});
