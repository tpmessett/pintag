import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  new Typed('#banner-typed-text', {
    strings: ["Knowledge Shared is Knowledge Doubled", "Never lose a link again", "Optimise your knowledge sharing"],
    typeSpeed: 50,
    loop: true
  });

  new Typed('#banner-typed-text-again', {
    strings: ["Knowledge Shared is Knowledge Doubled", "Never lose a link again", "Optimise your knowledge sharing"],
    typeSpeed: 50,
    loop: true
  });
}

export { loadDynamicBannerText };
