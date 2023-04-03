const pay = () => {
  const payjp = Payjp("pk_test_c11eb9ec0c9312cd5518c01f"); // PAY.JPテスト公開鍵
  const form = document.getElementById("charge-form");
  const elements = payjp.elements();
  const numberElement = elements.create("cardNumber");
  const expiryElement = elements.create("cardExpiry");
  const cvcElement = elements.create("cardCvc");

  numberElement.mount("#number-form");
  expiryElement.mount("#expiry-form");
  cvcElement.mount("#cvc-form");

  form.addEventListener("submit", (e) => {
    e.preventDefault();

    payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
      } else {
        const token = response.id;
        console.log(token);

        const tokenObj = `<input value=${token} name='token' type='hidden'>`;
        form.insertAdjacentHTML("beforeend", tokenObj);

        form.submit();
      }
    });
  });
};

window.addEventListener("load", pay);
