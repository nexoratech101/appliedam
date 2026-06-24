document.addEventListener('click', function(e) {

  // Toggle menu on trigger click
  var trigger = e.target.closest('.aam-share-trigger');
  if (trigger) {
    e.preventDefault();
    e.stopPropagation();
    var menu = trigger.nextElementSibling;
    var isOpen = menu.classList.contains('is-open');
    // Close all open menus first
    document.querySelectorAll('.aam-share-menu.is-open').forEach(function(m) {
      m.classList.remove('is-open');
    });
    if (!isOpen) menu.classList.add('is-open');
    return;
  }

  // Copy link button
  var copyBtn = e.target.closest('.aam-share-copy');
  if (copyBtn) {
    e.preventDefault();
    var url = copyBtn.getAttribute('data-url');
    navigator.clipboard.writeText(url).then(function() {
      copyBtn.textContent = 'Copied!';
      setTimeout(function() {
        copyBtn.innerHTML = '<svg viewBox="0 0 24 24" fill="currentColor"><path d="M16 1H4c-1.1 0-2 .9-2 2v14h2V3h12V1zm3 4H8c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h11c1.1 0 2-.9 2-2V7c0-1.1-.9-2-2-2zm0 16H8V7h11v14z"/></svg> Copy link';
      }, 2000);
    });
    return;
  }

  // Click outside closes all menus
  if (!e.target.closest('.aam-card-share')) {
    document.querySelectorAll('.aam-share-menu.is-open').forEach(function(m) {
      m.classList.remove('is-open');
    });
  }
});