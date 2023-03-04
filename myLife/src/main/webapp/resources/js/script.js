let mainImg = document.querySelector(".image.fill img");

window.addEventListener('scroll', function() {
  let value = window.scrollY;
  console.log("scroll value", value);

  if (value >= 400) {
    mainImg.style.animation='back 1.5s ease-out forwards';
  } else {
    mainImg.style.animation='slide 1.5s ease-out';
  }
})