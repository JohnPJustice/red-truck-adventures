(function () {
  'use strict';

  var header    = document.getElementById('site-header');
  var toggle    = document.getElementById('nav-toggle');
  var mobileNav = document.getElementById('nav-mobile');

  // ── Scroll: add shadow to header ──────────────────────────────────────────
  if (header) {
    function onScroll() {
      header.classList.toggle('scrolled', window.scrollY > 20);
    }
    window.addEventListener('scroll', onScroll, { passive: true });
    onScroll();
  }

  // ── Mobile nav toggle ─────────────────────────────────────────────────────
  if (toggle && mobileNav) {
    function openMenu() {
      mobileNav.classList.add('open');
      toggle.classList.add('open');
      toggle.setAttribute('aria-expanded', 'true');
      document.body.style.overflow = 'hidden';
    }

    function closeMenu() {
      mobileNav.classList.remove('open');
      toggle.classList.remove('open');
      toggle.setAttribute('aria-expanded', 'false');
      document.body.style.overflow = '';
    }

    toggle.addEventListener('click', function () {
      mobileNav.classList.contains('open') ? closeMenu() : openMenu();
    });

    // Close when a nav link is clicked
    var mobileLinks = mobileNav.querySelectorAll('a');
    for (var i = 0; i < mobileLinks.length; i++) {
      mobileLinks[i].addEventListener('click', closeMenu);
    }

    // Close on outside click
    document.addEventListener('click', function (e) {
      if (mobileNav.classList.contains('open') && !header.contains(e.target)) {
        closeMenu();
      }
    });

    // Close on Escape key
    document.addEventListener('keydown', function (e) {
      if (e.key === 'Escape' && mobileNav.classList.contains('open')) {
        closeMenu();
        toggle.focus();
      }
    });
  }

  // ── Smooth scroll for hash links ──────────────────────────────────────────
  var headerHeight = header ? header.offsetHeight : 72;

  var anchors = document.querySelectorAll('a[href^="#"]');
  for (var j = 0; j < anchors.length; j++) {
    anchors[j].addEventListener('click', function (e) {
      var target = document.querySelector(this.getAttribute('href'));
      if (target) {
        e.preventDefault();
        var top = target.getBoundingClientRect().top + window.scrollY - headerHeight - 16;
        window.scrollTo({ top: top, behavior: 'smooth' });
      }
    });
  }

})();
