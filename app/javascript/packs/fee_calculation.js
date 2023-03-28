window.addEventListener("load", () => {
  const priceInput = document.getElementById("item-price");
  const addTaxDom = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");
  console.log(priceInput);
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;

    addTaxDom.innerHTML = Math.floor(inputValue * 0.1);
    profit.innerHTML = inputValue - Math.floor(inputValue * 0.1);
  });
});
