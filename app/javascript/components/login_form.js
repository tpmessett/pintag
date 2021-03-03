
export const LoginToggle = () => {
document.querySelector('.img__btn').addEventListener('click', function() {
  document.querySelector('.cont').classList.toggle('s--signup');
  console.log("clicked");
});
}

export const RegCheck = () => {
  const queryString = window.location.search;
  if (queryString == "?reg=true" ){
    document.querySelector('.cont').classList.toggle('s--signup');
  }
}

