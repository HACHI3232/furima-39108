const pay = () => {
	const payjp = Payjp(process.env.PAYJP_PUBLIC_KEY); // PAY.JPテスト公開鍵
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
				const tokenObj = `<input value=${token} name='token' type='hidden'>`;
				form.insertAdjacentHTML("beforeend", tokenObj);
			}
		});

		form.submit();
	});
};

window.addEventListener("load", pay);
